import 'package:foxy_agent/foxy_agent.dart';

/// Who produced a chat message.
enum AgentChatRole { user, assistant, tool }

/// One message rendered in the agent workspace.
class AgentChatMessage {
  AgentChatMessage({required this.role, required this.text});

  factory AgentChatMessage.fromJson(Map<String, Object?> json) {
    final roleName = json['role'];
    final text = json['text'];
    return AgentChatMessage(
      role: AgentChatRole.values.firstWhere(
        (role) => role.name == roleName,
        orElse: () => AgentChatRole.tool,
      ),
      text: text is String ? text : '',
    );
  }

  final AgentChatRole role;

  /// Mutable so streamed deltas can be appended without rebuilding objects.
  String text;

  Map<String, Object?> toJson() => {'role': role.name, 'text': text};
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

/// Lightweight session entry shown in the session list.
class AgentChatSessionMeta {
  const AgentChatSessionMeta({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  final String id;

  final String title;

  final DateTime updatedAt;
}

/// Session title derived from the first user message.
String agentSessionTitle(String text, {int maxLength = 24}) {
  final line = text.split('\n').first.trim();
  return line.length <= maxLength ? line : '${line.substring(0, maxLength)}...';
}
