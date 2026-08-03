import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';

/// DBC 导出/导入工作流共用的「失败摘要」文案。
///
/// 三个工作流 VM 曾各自维护一份拷贝(仅首词「导出/导入」不同),
/// 收敛到这里避免漂移。错误只展示前 5 条,超长用省略号折叠。
String formatDbcSyncFailureSummary(DbcSyncResult result, String operation) {
  final top = result.errors.take(5).join('\n');
  return '$operation结束，部分文件失败（成功 ${result.completed}，跳过 ${result.skipped}）：\n'
      '$top${result.errors.length > 5 ? '\n...等 ${result.errors.length} 个错误' : ''}';
}

/// 图标提取工作流的失败摘要(结果类型字段不同,单独实现)。
String formatIconExtractionFailureSummary(GameIconExtractionResult result) {
  final top = result.errors.take(5).join('\n');
  final suffix = result.errors.length > 5
      ? '\n...等 ${result.errors.length} 个错误'
      : '';
  return '提取结束，部分文件失败（成功 ${result.extracted}，跳过 ${result.skipped}）：\n'
      '$top$suffix';
}
