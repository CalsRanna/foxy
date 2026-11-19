import 'package:foxy_agent/foxy_agent.dart';

/// Who produced a chat message.
enum AgentChatRole { user, assistant, tool }

/// One message rendered in the agent workspace.
class AgentChatMessage {
  AgentChatMessage({required this.role, required this.text});

  final AgentChatRole role;

  /// Mutable so streamed deltas can be appended without rebuilding objects.
  String text;
}

/// One conversation in the agent session list.
class AgentChatSession {
  AgentChatSession({required this.id, required this.title});

  final String id;

  /// Display title; set from the first user message.
  String title;

  /// Protocol-level conversation state sent with every request.
  final session = AgentSession();

  final messages = <AgentChatMessage>[];
}
