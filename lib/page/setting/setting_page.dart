import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/page/setting/directory_setting_row.dart';
import 'package:foxy/page/setting/icon_extract_dialog.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final setupViewModel = GetIt.instance.get<SetupStatusViewModel>();
  final importViewModel = GetIt.instance.get<DbcImportWorkflowViewModel>();
  final exportViewModel = GetIt.instance.get<DbcExportWorkflowViewModel>();
  final iconViewModel = GetIt.instance.get<IconExtractWorkflowViewModel>();

  @override
  void initState() {
    super.initState();
    setupViewModel.prepare();
  }

  @override
  void dispose() {
    exportViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: FoxyHeader('设置'),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '目录设置',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  '应用运行所需的两个目录，分别用于图标提取与 DBC 数据导入。',
                  style: _mutedDescription(context),
                ),
                const SizedBox(height: 16),
                DirectorySettingRow(
                  vm: setupViewModel,
                  target: DirectoryConfigTarget.clientDir,
                ),
                const SizedBox(height: 12),
                DirectorySettingRow(
                  vm: setupViewModel,
                  target: DirectoryConfigTarget.dbcPath,
                ),
                const SizedBox(height: 24),
                const Text(
                  'DBC 数据管理',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  '从服务端 DBC 目录导入 .dbc 到数据库，或将库内 DBC 表导出为文件。',
                  style: _mutedDescription(context),
                ),
                const SizedBox(height: 16),
                _buildDbcActions(),
                const SizedBox(height: 24),
                const Text(
                  '游戏图标',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  '从客户端 MPQ 归档提取游戏图标到本地缓存，应用不内置图标。',
                  style: _mutedDescription(context),
                ),
                const SizedBox(height: 16),
                _buildIconActions(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _mutedDescription(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(
      color: Theme.of(
        context,
      ).colorScheme.onSurface.withValues(alpha: 0.65),
    ) ?? const TextStyle(fontSize: 13);
  }

  Widget _buildDbcActions() {
    return Watch((_) {
      final busy = importViewModel.isRunning || exportViewModel.isRunning;
      return Column(
        children: [
          _SettingItem(
            title: '导入 DBC 文件',
            description:
                '从配置的服务端 DBC 目录导入数据，以 DBC 为准写入 foxy 库并覆盖对应表。'
                '若需保留库内数据请先自行备份。',
            trailing: ShadButton(
              size: ShadButtonSize.sm,
              onPressed: busy ? null : _showImportDialog,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [Icon(LucideIcons.fileInput, size: 15), Text('导入')],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SettingItem(
            title: '导出 DBC 文件',
            description: '将数据库中的 DBC 表导出为 .dbc 文件，可搜索并勾选需要导出的表。',
            trailing: ShadButton(
              size: ShadButtonSize.sm,
              onPressed: busy ? null : _showExportDialog,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [Icon(LucideIcons.fileOutput, size: 15), Text('导出')],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildIconActions() {
    return Watch((_) {
      final busy = iconViewModel.isRunning;
      return Column(
        children: [
          _SettingItem(
            title: '提取游戏图标',
            description:
                '从配置的客户端目录的 Data\\<语言> MPQ 归档中提取全部图标'
                '（约 6300 个，BLP 原始格式）。未提取的图标在列表页显示占位符。',
            trailing: ShadButton(
              size: ShadButtonSize.sm,
              onPressed: busy ? null : _showIconExtractDialog,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [Icon(LucideIcons.download, size: 15), Text('提取图标')],
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showImportDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcImportDialog(vm: importViewModel),
    );
  }

  void _showIconExtractDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => IconExtractDialog(vm: iconViewModel),
    );
  }

  void _showExportDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcExportDialog(vm: exportViewModel),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget trailing;

  const _SettingItem({
    required this.title,
    required this.description,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          trailing,
        ],
      ),
    );
  }
}
