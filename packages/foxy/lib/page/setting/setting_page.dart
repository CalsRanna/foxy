import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/setting/directory_setting_row.dart';
import 'package:foxy/page/setting/icon_extract_dialog.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/page/setting/update_dialog.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

/// Settings group: top divider + title + bottom divider + item list.
class _SettingSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final divider = Divider(
      height: 1,
      color: theme.colorScheme.border.withValues(alpha: 0.6),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        divider,
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        divider,
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}

/// Single-row settings item: title + description + right-side action,
/// borderless.
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
    final theme = ShadTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.muted.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        trailing,
      ],
    );
  }
}

class _SettingPageState extends State<SettingPage> {
  final setupViewModel = GetIt.instance.get<SetupStatusViewModel>();
  final importViewModel = GetIt.instance.get<DbcImportWorkflowViewModel>();
  final exportViewModel = GetIt.instance.get<DbcExportWorkflowViewModel>();
  final iconViewModel = GetIt.instance.get<IconExtractWorkflowViewModel>();
  final updateViewModel = GetIt.instance.get<UpdateViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: FoxyHeader('设置'),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SettingSection(
                  title: '目录设置',
                  children: [
                    DirectorySettingRow(
                      vm: setupViewModel,
                      target: DirectoryConfigTarget.clientDir,
                    ),
                    const SizedBox(height: 16),
                    DirectorySettingRow(
                      vm: setupViewModel,
                      target: DirectoryConfigTarget.serverDir,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildDbcSection(),
                const SizedBox(height: 24),
                _buildIconSection(),
                const SizedBox(height: 24),
                _buildUpdateSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDbcSection() {
    return Watch((_) {
      final busy = importViewModel.isRunning || exportViewModel.isRunning;
      return _SettingSection(
        title: 'DBC 数据管理',
        children: [
          _SettingItem(
            title: '导入 DBC 文件',
            description:
                '从服务端目录自动检测的 DBC 目录导入数据，以 DBC 为准写入 foxy 库并覆盖对应表。'
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
          const SizedBox(height: 16),
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

  Widget _buildIconSection() {
    return Watch((_) {
      final busy = iconViewModel.isRunning;
      return _SettingSection(
        title: '游戏图标',
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
                children: [Icon(LucideIcons.download, size: 15), Text('提取')],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildUpdateSection() {
    return Watch((_) {
      final version = updateViewModel.currentVersion.value;
      return _SettingSection(
        title: '关于与更新',
        children: [
          _SettingItem(
            title: '检查更新',
            description: version == null
                ? '检查 Foxy 是否有新版本'
                : '当前版本 $version，检查 Foxy 是否有新版本',
            trailing: ShadButton(
              size: ShadButtonSize.sm,
              onPressed: _showUpdateDialog,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [Icon(LucideIcons.refreshCw, size: 15), Text('检查更新')],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SettingItem(
            title: '项目主页',
            description: '访问 GitHub 仓库，查看更新记录、文档与反馈问题',
            trailing: ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: _openProjectPage,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Icon(LucideIcons.externalLink, size: 15),
                  Text('打开'),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    exportViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setupViewModel.prepare();
    updateViewModel.prepare();
  }

  void _showExportDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcExportDialog(vm: exportViewModel),
    );
  }

  void _showIconExtractDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => IconExtractDialog(vm: iconViewModel),
    );
  }

  void _showImportDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcImportDialog(vm: importViewModel),
    );
  }

  /// Triggers the manual check first (the signal enters "checking" state
  /// synchronously), then opens a dialog that live-updates with the state.
  void _showUpdateDialog() {
    updateViewModel.checkManually();
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => UpdateDialog(vm: updateViewModel),
    );
  }

  Future<void> _openProjectPage() async {
    final ok = await launchUrl(
      Uri.parse('https://github.com/CalsRanna/foxy'),
      mode: LaunchMode.externalApplication,
    );
    if (!ok) {
      DialogUtil.instance.error('无法打开项目主页');
    }
  }
}
