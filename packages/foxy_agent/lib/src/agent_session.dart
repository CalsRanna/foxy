/// Client-side conversation state, kept as Responses `input` items.
///
/// Requests are stateless: every request carries the full item list and never
/// uses `previous_response_id`, so any Responses-compatible provider works and
/// no conversation state is retained by the provider.
final class AgentSession {
  final List<Map<String, Object?>> _items = [];

  /// The full item list, in protocol order.
  List<Map<String, Object?>> get items => List.unmodifiable(_items);

  /// Appends a user message.
  void addUserMessage(String text) {
    _items.add({'role': 'user', 'content': text});
  }

  /// Appends raw items returned by the provider (assistant messages,
  /// function calls, reasoning items, ...), preserved verbatim.
  void addItems(Iterable<Map<String, Object?>> items) {
    _items.addAll(items);
  }

  /// Clears the conversation.
  void clear() => _items.clear();
}
