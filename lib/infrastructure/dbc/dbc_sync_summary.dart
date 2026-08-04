import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';

/// "Failure summary" text shared by the DBC export/import workflows.
///
/// The three workflow VMs used to keep their own copies (differing only in
/// the leading word "export/import"); converged here to avoid drift. Only
/// the first 5 errors are shown; overlong lists collapse with an ellipsis.
String formatDbcSyncFailureSummary(DbcSyncResult result, String operation) {
  final top = result.errors.take(5).join('\n');
  return '$operation结束，部分文件失败（成功 ${result.completed}，跳过 ${result.skipped}）：\n'
      '$top${result.errors.length > 5 ? '\n...等 ${result.errors.length} 个错误' : ''}';
}

/// Failure summary for the icon-extraction workflow (its result-type fields
/// differ, so implemented separately).
String formatIconExtractionFailureSummary(GameIconExtractionResult result) {
  final top = result.errors.take(5).join('\n');
  final suffix = result.errors.length > 5
      ? '\n...等 ${result.errors.length} 个错误'
      : '';
  return '提取结束，部分文件失败（成功 ${result.extracted}，跳过 ${result.skipped}）：\n'
      '$top$suffix';
}
