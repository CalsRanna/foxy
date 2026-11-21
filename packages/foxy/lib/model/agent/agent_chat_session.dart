import 'package:foxy_agent/foxy_agent.dart';

/// One message rendered in the agent workspace.
class AgentChatMessage {
  final AgentChatRole role;

  /// Mutable so streamed deltas can be appended without rebuilding objects.
  String text;

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

  Map<String, Object?> toJson() => {'role': role.name, 'text': text};
}

/// Who produced a chat message.
enum AgentChatRole { user, assistant, tool, reasoning, error }

/// One conversation in the agent session list.
class AgentChatSession {
  final String id;

  /// The model-generated title or a short excerpt of the first message.
  String title;

  /// Protocol-level conversation state sent with every request.
  final session = AgentSession();

  final messages = <AgentChatMessage>[];

  AgentChatSession({required this.id, required this.title});

  /// Session title derived from the first user message.
  static String titleFrom(String text, {int maxLength = 24}) {
    final line = text.split('\n').first.trim();
    return line.length <= maxLength
        ? line
        : '${line.substring(0, maxLength)}...';
  }
}

/// Lightweight session entry shown in the session list.
class AgentChatSessionMeta {
  final String id;

  final String title;

  final DateTime updatedAt;

  const AgentChatSessionMeta({
    required this.id,
    required this.title,
    required this.updatedAt,
  });
}
