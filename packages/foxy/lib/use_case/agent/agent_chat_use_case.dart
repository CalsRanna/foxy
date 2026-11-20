import 'package:foxy_agent/foxy_agent.dart';

/// Wires one provider configuration and the read-only toolset into a
/// [FoxyAgent] for a single conversation run.
///
/// The caller owns the returned event stream and must [close] the use case
/// when the run ends or the page is disposed.
class AgentChatUseCase {
  final FoxyAgent _agent;

  AgentChatUseCase({
    required AgentProviderConfig provider,
    required TableCatalog catalog,
    required ReadOnlyDataSource dataSource,
  }) : _agent = FoxyAgent(
         provider: provider,
         instructions: '''$readOnlyAssistantInstructions

## 其他可用数据
- characters 库：角色、背包、公会等游戏进度数据。
- auth 库：账号、权限、封禁、服务器列表等数据。
- 用 list_tables 查找这两个库中的表，使用工具返回的库名前缀。''',
         tools: createReadOnlyTools(catalog: catalog, dataSource: dataSource),
       );

  void close() => _agent.close();

  Stream<AgentEvent> run(AgentSession session, String message) =>
      _agent.run(session, message);
}
