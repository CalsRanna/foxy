import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/setting/dbc_sync_dialogs.dart';
import 'package:foxy/page/setting/setting_view_model.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final viewModel = GetIt.instance.get<SettingViewModel>();

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
                  'DBC 数据管理',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  '从客户端目录导入 .dbc 到数据库，或将库内 DBC 表导出为文件。',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDbcActions(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDbcActions() {
    return Watch((_) {
      final busy = viewModel.isDbcBusy;
      return Column(
        children: [
          _SettingItem(
            title: '导入 DBC 文件',
            description:
                '选择魔兽客户端中的 DBC 目录，以 DBC 为准写入 foxy 库并覆盖对应表。'
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

  void _showImportDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcImportDialog(vm: viewModel),
    );
  }

  void _showExportDialog() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcExportDialog(vm: viewModel),
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
