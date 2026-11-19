/// Events emitted by the agent while a run is in progress.
sealed class AgentEvent {
  const AgentEvent();
}

/// A streamed chunk of the model's visible output text.
final class AgentTextDeltaEvent extends AgentEvent {
  const AgentTextDeltaEvent(this.text);

  final String text;
}

/// The model requested a tool call.
final class AgentToolCallEvent extends AgentEvent {
  const AgentToolCallEvent({
    required this.callId,
    required this.name,
    required this.arguments,
  });

  final String callId;

  final String name;

  final Map<String, Object?> arguments;
}

/// The result of a tool call, already scheduled to be sent back to the model.
final class AgentToolResultEvent extends AgentEvent {
  const AgentToolResultEvent({
    required this.callId,
    required this.name,
    required this.output,
    required this.isError,
  });

  final String callId;

  final String name;

  /// The output string sent to the model (JSON-encoded unless the tool
  /// returned a plain string).
  final String output;

  final bool isError;
}

/// The run finished normally; the model answered without more tool calls.
final class AgentCompletedEvent extends AgentEvent {
  const AgentCompletedEvent();
}

/// The run failed; the event stream closes after this event.
final class AgentFailedEvent extends AgentEvent {
  const AgentFailedEvent(this.message);

  final String message;
}
