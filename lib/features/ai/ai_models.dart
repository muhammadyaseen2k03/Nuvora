enum AiKind { coach, flashcards, summarize, questions, explain }

class AiRequest {
  const AiRequest(this.kind, {this.text, this.context = const {}});

  final AiKind kind;

  /// User-provided text (notes, a concept). Sent only after the user has
  /// seen what will be sent and confirmed.
  final String? text;

  /// Aggregated numbers the user allowed (never free-text journal content).
  final Map<String, Object?> context;
}

class AiCard {
  const AiCard(this.front, this.back);
  final String front;
  final String back;
}

/// A validated AI response. Always treated as a draft and labelled as
/// AI-generated in the UI.
class AiReply {
  const AiReply({required this.kind, this.text = '', this.cards = const []});

  final AiKind kind;
  final String text;
  final List<AiCard> cards;

  static const maxText = 6000;
  static const maxCards = 20;
  static const maxFront = 500;
  static const maxBack = 1000;

  /// Validates a decoded JSON response. Anything unexpected is rejected
  /// rather than displayed.
  static AiReply parse(AiKind kind, Object? json) {
    if (json is! Map<String, dynamic>) {
      throw const AiException('invalid_response');
    }
    final text = json['text'];
    if (text != null && text is! String) throw const AiException('invalid_response');
    final cardsRaw = json['cards'];
    if (cardsRaw != null && cardsRaw is! List) {
      throw const AiException('invalid_response');
    }
    final cards = <AiCard>[];
    for (final c in (cardsRaw as List<dynamic>? ?? const [])) {
      if (c is! Map<String, dynamic>) throw const AiException('invalid_response');
      final front = c['front'];
      final back = c['back'];
      if (front is! String || back is! String) {
        throw const AiException('invalid_response');
      }
      final f = front.trim();
      final b = back.trim();
      if (f.isEmpty || b.isEmpty) continue;
      cards.add(AiCard(
        f.length > maxFront ? f.substring(0, maxFront) : f,
        b.length > maxBack ? b.substring(0, maxBack) : b,
      ));
      if (cards.length >= maxCards) break;
    }
    final body = ((text as String?) ?? '').trim();
    if (body.isEmpty && cards.isEmpty) throw const AiException('invalid_response');
    return AiReply(
      kind: kind,
      text: body.length > maxText ? body.substring(0, maxText) : body,
      cards: cards,
    );
  }
}

class AiException implements Exception {
  const AiException(this.code);

  /// `consent_required`, `not_configured`, `unauthorized`, `offline`,
  /// `rate_limited`, `input_too_long`, `server`, `invalid_response`,
  /// `too_soon`.
  final String code;

  @override
  String toString() => 'AiException($code)';
}
