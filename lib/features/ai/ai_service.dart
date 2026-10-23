import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database.dart';
import '../insights/history_repository.dart';
import '../insights/weekly_report.dart';
import 'ai_client.dart';
import 'ai_models.dart';

/// What the user has allowed the AI features to use.
class AiConsent {
  const AiConsent({
    this.enabled = false,
    this.study = false,
    this.fitness = false,
    this.prayer = false,
  });

  /// Master switch. Off means no request of any kind is ever sent.
  final bool enabled;
  final bool study;
  final bool fitness;
  final bool prayer;
}

/// Builds the minimal context for the coach: aggregated numbers for the
/// categories the user allowed, nothing else. It never includes journal
/// text, notes, the user's name or any identifier.
Map<String, Object?> buildCoachContext({
  required AiConsent consent,
  required List<DayStats> days,
  required WeeklyGoals goals,
  required String fitnessLevel,
  required int workoutMinutes,
}) {
  final ctx = <String, Object?>{'window_days': days.length};
  if (consent.study) {
    final bySubject = <String, int>{};
    for (final d in days) {
      d.studyBySubject.forEach((k, v) => bySubject[k] = (bySubject[k] ?? 0) + v);
    }
    ctx['study'] = {
      'minutes_total': days.fold<int>(0, (s, d) => s + d.studyMinutes),
      'daily_goal_minutes': goals.studyMinutesPerDay,
      'minutes_by_subject': bySubject,
    };
  }
  if (consent.fitness) {
    ctx['fitness'] = {
      'workouts': days.fold<int>(0, (s, d) => s + d.workouts),
      'preferred_workout_minutes': workoutMinutes,
      'level': fitnessLevel,
      'water_days_goal_met':
          days.where((d) => d.waterMl >= goals.waterMlPerDay).length,
      'water_goal_ml': goals.waterMlPerDay,
    };
  }
  if (consent.prayer) {
    ctx['prayer'] = {
      'completed': days.fold<int>(0, (s, d) => s + d.prayersCompleted),
      'recorded': days.fold<int>(
          0, (s, d) => s + d.prayersCompleted + d.prayersMissed),
    };
  }
  return ctx;
}

/// Consent-gated access to the AI backend, plus local history.
///
/// * Nothing is sent unless the master switch is on.
/// * Requests are spaced at least [minInterval] apart.
/// * Replies are validated by [AiReply.parse] before they get here.
/// * History is local only and can be cleared.
class AiService {
  AiService(this._db, this._client, this._history,
      {DateTime Function()? clock, this.minInterval = const Duration(seconds: 3)})
      : _now = clock ?? DateTime.now;

  final AppDatabase _db;
  final AiClient _client;
  final HistoryRepository _history;
  final DateTime Function() _now;
  final Duration minInterval;
  static const _uuid = Uuid();
  static const maxInputChars = 8000;
  DateTime? _lastRequest;

  Stream<AiConsent> watchConsent(String profileId) =>
      (_db.select(_db.privacyPreferences)
            ..where((p) => p.profileId.equals(profileId)))
          .watchSingleOrNull()
          .map((p) => p == null
              ? const AiConsent()
              : AiConsent(
                  enabled: p.aiConsent,
                  study: p.aiShareStudy,
                  fitness: p.aiShareFitness,
                  prayer: p.aiSharePrayer));

  Future<AiConsent> consentFor(String profileId) => watchConsent(profileId).first;

  Future<void> setConsent(
    String profileId, {
    bool? enabled,
    bool? study,
    bool? fitness,
    bool? prayer,
  }) =>
      (_db.update(_db.privacyPreferences)
            ..where((p) => p.profileId.equals(profileId)))
          .write(PrivacyPreferencesCompanion(
        aiConsent: Value.absentIfNull(enabled),
        aiShareStudy: Value.absentIfNull(study),
        aiShareFitness: Value.absentIfNull(fitness),
        aiSharePrayer: Value.absentIfNull(prayer),
        updatedAt: Value(_now()),
      ));

  /// Suggests manageable goals and a plan from the user's own aggregated
  /// activity (only the categories they allowed).
  Future<AiReply> coach(String profileId) async {
    final consent = await _requireConsent(profileId);
    final prefs = await (_db.select(_db.userPreferences)
          ..where((p) => p.profileId.equals(profileId)))
        .getSingleOrNull();
    final today = _now();
    final records = await _history.load(
        profileId,
        DateTime(today.year, today.month, today.day - 6),
        DateTime(today.year, today.month, today.day));
    final context = buildCoachContext(
      consent: consent,
      days: [for (final r in records) r.stats],
      goals: WeeklyGoals(
        studyMinutesPerDay: prefs?.studyGoalMinutes ?? 60,
        waterMlPerDay: prefs?.waterGoalMl ?? 2000,
      ),
      fitnessLevel: prefs?.fitnessLevel ?? 'beginner',
      workoutMinutes: prefs?.workoutMinutes ?? 20,
    );
    return _ask(profileId, AiRequest(AiKind.coach, context: context),
        userLabel: 'coach');
  }

  /// Runs a study tool on text the user supplied for this request.
  Future<AiReply> studyTool(String profileId, AiKind kind, String text) async {
    assert(kind != AiKind.coach);
    await _requireConsent(profileId);
    final trimmed = text.trim();
    if (trimmed.isEmpty) throw const AiException('invalid_response');
    if (trimmed.length > maxInputChars) throw const AiException('input_too_long');
    return _ask(profileId, AiRequest(kind, text: trimmed), userLabel: kind.name);
  }

  Future<AiConsent> _requireConsent(String profileId) async {
    final consent = await consentFor(profileId);
    if (!consent.enabled) throw const AiException('consent_required');
    return consent;
  }

  Future<AiReply> _ask(String profileId, AiRequest request,
      {required String userLabel}) async {
    final now = _now();
    final last = _lastRequest;
    if (last != null && now.difference(last) < minInterval) {
      throw const AiException('too_soon');
    }
    _lastRequest = now;
    final reply = await _client.send(request);
    await _save(profileId, 'user', request.kind, userLabel, now);
    final body = reply.cards.isEmpty
        ? reply.text
        : '${reply.text}${reply.text.isEmpty ? '' : '\n'}'
            '${reply.cards.map((c) => '${c.front} -> ${c.back}').join('\n')}';
    await _save(profileId, 'assistant', request.kind, body, _now());
    return reply;
  }

  Future<void> _save(String profileId, String role, AiKind kind, String body,
      DateTime at) =>
      _db.into(_db.aiMessages).insert(AiMessagesCompanion.insert(
            id: _uuid.v4(),
            profileId: profileId,
            role: role,
            kind: kind.name,
            body: body,
            createdAt: at,
          ));

  Stream<List<AiMessage>> watchHistory(String profileId) =>
      (_db.select(_db.aiMessages)
            ..where((m) => m.profileId.equals(profileId))
            ..orderBy([
              (m) => OrderingTerm.desc(m.createdAt),
              (m) => OrderingTerm.desc(const CustomExpression<int>('rowid')),
            ])
            ..limit(50))
          .watch();

  Future<void> clearHistory(String profileId) =>
      (_db.delete(_db.aiMessages)..where((m) => m.profileId.equals(profileId)))
          .go();
}
