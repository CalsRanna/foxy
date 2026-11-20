/// Base class for errors raised by foxy_agent.
///
/// Messages are English diagnostics for logs; user-facing Chinese copy should
/// be mapped by exception type in the host app.
class AgentException implements Exception {
  /// English diagnostic message.
  final String message;

  const AgentException(this.message);

  @override
  String toString() => 'AgentException: $message';
}

/// The provider answered with a non-200 status code.
final class AgentHttpException extends AgentException {
  /// HTTP status code of the response.
  final int statusCode;

  /// Response body, possibly truncated for diagnostics.
  final String body;

  AgentHttpException({required this.statusCode, required this.body})
    : super('Provider returned HTTP $statusCode: ${_truncate(body)}');

  static String _truncate(String text) =>
      text.length <= 500 ? text : '${text.substring(0, 500)}...';
}
