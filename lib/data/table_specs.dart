/// Describes the profile-owned tables for backup, restore and sync.
///
/// Order matters: parents come before children so foreign keys are satisfied
/// when rows are inserted in this order (and deleted in reverse).
class TableSpec {
  const TableSpec(
    this.name, {
    this.pk = const ['id'],
    this.profileColumn = 'profile_id',
    this.fks = const {},
    this.changeColumn,
    this.mutable = true,
    this.category = SyncCategory.core,
  });

  final String name;

  /// Primary key column(s). One-row-per-profile tables use `profile_id`.
  final List<String> pk;

  /// Column holding the owning profile id (`id` for the profiles table).
  final String profileColumn;

  /// Foreign-key columns (other than the profile) and the table they point to.
  final Map<String, String> fks;

  /// Column used to detect changes: an `updated_at` for mutable rows, or the
  /// creation/event time for append-only rows. Null means never synced.
  final String? changeColumn;

  /// False for append-only rows (water logs, review history, awards).
  final bool mutable;
  final SyncCategory category;

  bool get isProfilesTable => name == 'profiles';

  /// Whether rows of this table are uploaded by cloud sync.
  bool get isSynced => changeColumn != null;

  /// Single-column key used to identify a row, or the profile id for 1:1 tables.
  String get keyColumn => pk.length == 1 ? pk.first : pk.join('+');
}

/// Groups of data the user can include or exclude from cloud sync.
enum SyncCategory { core, prayer, study, fitness, journal }

/// Tables in dependency order.
const tableSpecs = <TableSpec>[
  // Not synced: names and recovery data stay on the device.
  TableSpec('profiles', profileColumn: 'id'),
  TableSpec('user_preferences',
      pk: ['profile_id'], changeColumn: 'updated_at'),
  // Device-specific, so not synced.
  TableSpec('notification_preferences', pk: ['profile_id']),
  // Consent is per device and must never be copied by sync.
  TableSpec('privacy_preferences', pk: ['profile_id']),
  TableSpec('prayer_settings',
      pk: ['profile_id'],
      changeColumn: 'updated_at',
      category: SyncCategory.prayer),
  TableSpec('prayer_records',
      changeColumn: 'updated_at', category: SyncCategory.prayer),
  TableSpec('subjects',
      changeColumn: 'updated_at', category: SyncCategory.study),
  TableSpec('syllabus_topics',
      fks: {'subject_id': 'subjects'},
      changeColumn: 'updated_at',
      category: SyncCategory.study),
  TableSpec('exams',
      fks: {'subject_id': 'subjects'},
      changeColumn: 'updated_at',
      category: SyncCategory.study),
  TableSpec('study_sessions',
      fks: {'subject_id': 'subjects'},
      changeColumn: 'updated_at',
      category: SyncCategory.study),
  TableSpec('flashcards',
      fks: {'subject_id': 'subjects'},
      changeColumn: 'updated_at',
      category: SyncCategory.study),
  TableSpec('flashcard_reviews',
      fks: {'card_id': 'flashcards'},
      changeColumn: 'reviewed_at',
      mutable: false,
      category: SyncCategory.study),
  TableSpec('water_logs',
      changeColumn: 'created_at',
      mutable: false,
      category: SyncCategory.fitness),
  TableSpec('fasting_sessions',
      changeColumn: 'updated_at', category: SyncCategory.fitness),
  TableSpec('workout_sessions',
      changeColumn: 'created_at',
      mutable: false,
      category: SyncCategory.fitness),
  TableSpec('journal_entries',
      changeColumn: 'updated_at', category: SyncCategory.journal),
  TableSpec('achievement_awards',
      changeColumn: 'awarded_at', mutable: false),
  TableSpec('daily_plans', changeColumn: 'generated_at'),
  TableSpec('planned_activities',
      fks: {'plan_id': 'daily_plans'}, changeColumn: 'updated_at'),
];

TableSpec? specFor(String name) {
  for (final s in tableSpecs) {
    if (s.name == name) return s;
  }
  return null;
}
