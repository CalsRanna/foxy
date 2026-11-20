/// A tool the agent can call.
///
/// Implementations live in the host app and should expose read-only
/// operations for the first version (repository queries, enum lookups, ...).
abstract base class AgentTool {
  const AgentTool();

  /// Functional description telling the model when and how to use the tool.
  String get description;

  /// JSON Schema (object type) describing the tool input.
  Map<String, Object?> get inputSchema;

  /// Unique tool name, sent to the model verbatim.
  String get name;

  /// Executes the tool. The returned value must be JSON-encodable; a plain
  /// [String] is sent to the model as-is, anything else is JSON-encoded.
  Future<Object?> call(Map<String, Object?> arguments);
}
