/// Cloud configuration, supplied at build time:
///
///   flutter run --dart-define=SUPABASE_URL=https://xyz.supabase.co \
///               --dart-define=SUPABASE_ANON_KEY=`<anon key>`
///
/// The anon key is a *public* key by design: all access is limited by
/// row-level security on the server. The service-role key must never be put
/// in the app and is only used by server-side functions.
class CloudConfig {
  const CloudConfig({required this.url, required this.anonKey});

  factory CloudConfig.fromEnvironment() => const CloudConfig(
        url: String.fromEnvironment('SUPABASE_URL'),
        anonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
      );

  final String url;
  final String anonKey;

  /// False until real values are provided; cloud features stay hidden.
  bool get isConfigured =>
      url.startsWith('https://') && anonKey.isNotEmpty;

  Uri endpoint(String path, [Map<String, String>? query]) {
    final base = Uri.parse(url);
    return base.replace(
      path: '${base.path.endsWith('/') ? base.path.substring(0, base.path.length - 1) : base.path}$path',
      queryParameters: query,
    );
  }
}
