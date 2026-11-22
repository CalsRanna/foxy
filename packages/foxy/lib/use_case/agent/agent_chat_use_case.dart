import 'package:foxy_agent/foxy_agent.dart';
import 'package:http/http.dart' as http;

/// Wires one provider configuration and the read-only toolset into a
/// [FoxyAgent] for a single conversation run.
///
/// The caller owns the returned event stream and must [close] the use case
/// when the run ends or the page is disposed.
class AgentChatUseCase {
  static const _featureInstructions = '''

## Foxy 界面指引
- 用户问在 Foxy 里哪里查看、怎么编辑或如何使用某项功能时，调用 find_foxy_feature。纯界面问题直接查该工具，无需调用数据库工具。
- 查询具体记录后，如果用户需要在 Foxy 中核对或继续操作，调用 find_foxy_feature，并把已查到的名称或 ID 填入操作步骤。纯统计或分析问题按需提供入口。
- 需要引导用户完成 DBC 导入时，调用 find_foxy_feature 搜索「导入 DBC」，按工具返回的入口说明步骤。
- 页面名称、标签页和操作以工具返回为准。找不到时，说明工具未查到已确认的入口；不要根据表名猜测菜单。工具仅提供指引，界面中的操作由用户执行。''';

  final FoxyAgent _agent;

  AgentChatUseCase({
    required AgentProviderConfig provider,
    required TableCatalog catalog,
    required ReadOnlyDataSource dataSource,
    AgentTool? featureTool,
    http.Client? httpClient,
  }) : _agent = FoxyAgent(
         provider: provider,
         instructions:
             '''$sqlReadOnlyAssistantInstructions

## 其他可用数据
- characters 库：角色、背包、公会等游戏进度数据。
- auth 库：账号、权限、封禁、服务器列表等数据。
- 用 list_tables 查找这两个库中的表，使用工具返回的库名前缀。${featureTool == null ? '' : _featureInstructions}''',
         tools: [
           ...createReadOnlyTools(catalog: catalog, dataSource: dataSource),
           ?featureTool,
         ],
         httpClient: httpClient,
       );

  void close() => _agent.close();

  Stream<AgentEvent> run(AgentSession session, String message) =>
      _agent.run(session, message);
}
