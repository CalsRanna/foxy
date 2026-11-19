/// Connection settings for a provider that implements the Responses API.
///
/// Any service exposing `POST {baseUrl}/responses` (OpenAI, compatible
/// gateways, self-hosted proxies) can be used, which lets users bring their
/// own provider in the app settings.
final class AgentProviderConfig {
  const AgentProviderConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    this.headers = const {},
  });

  /// API root, e.g. `https://api.openai.com/v1`; requests go to
  /// `{baseUrl}/responses`.
  final String baseUrl;

  /// Bearer API key; providers with custom auth can override it via [headers].
  final String apiKey;

  /// Model name, sent to the provider verbatim.
  final String model;

  /// Extra request headers; entries override the defaults on conflict.
  final Map<String, String> headers;

  /// The Responses endpoint derived from [baseUrl].
  Uri get endpoint {
    final root = baseUrl.replaceAll(RegExp(r'/+$'), '');
    return Uri.parse('$root/responses');
  }
}
