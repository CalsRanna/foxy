/// The run finished normally; the model answered without more tool calls.
final class AgentCompletedEvent extends AgentEvent {
  const AgentCompletedEvent();
}

/// Events emitted by the agent while a run is in progress.
sealed class AgentEvent {
  const AgentEvent();
}

/// The run failed; the event stream closes after this event.
final class AgentFailedEvent extends AgentEvent {
  final String message;

  const AgentFailedEvent(this.message);
}

/// A streamed chunk of the model's visible output text.
final class AgentTextDeltaEvent extends AgentEvent {
  final String text;

  const AgentTextDeltaEvent(this.text);
}

/// The model requested a tool call.
final class AgentToolCallEvent extends AgentEvent {
  final String callId;

  final String name;

  final Map<String, Object?> arguments;

  const AgentToolCallEvent({
    required this.callId,
    required this.name,
    required this.arguments,
  });
}

/// The result of a tool call, already scheduled to be sent back to the model.
final class AgentToolResultEvent extends AgentEvent {
  final String callId;

  final String name;

  /// The output string sent to the model (JSON-encoded unless the tool
  /// returned a plain string).
  final String output;

  final bool isError;

  const AgentToolResultEvent({
    required this.callId,
    required this.name,
    required this.output,
    required this.isError,
  });
}
