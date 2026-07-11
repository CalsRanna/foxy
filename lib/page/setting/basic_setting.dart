import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/setting/dbc_sync_dialogs.dart';
import 'package:foxy/page/setting/setting_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class BasicSettingPage extends StatefulWidget {
  const BasicSettingPage({super.key});

  @override
  State<BasicSettingPage> createState() => _BasicSettingPageState();
}

class _BasicSettingPageState extends State<BasicSettingPage> {
  final viewModel = GetIt.instance.get<SettingViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('基本设置'),
            const SizedBox(height: 24),
            _buildLocaleSwitch(),
            const SizedBox(height: 32),
            _buildSectionTitle('DBC 数据管理'),
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
                '选择魔兽客户端中的 DBC 目录，将数据写入 foxy 库。'
                '已有数据的表会自动跳过。',
            trailing: ShadButton(
              size: ShadButtonSize.sm,
              onPressed: busy ? null : _showImportDialog,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Icon(LucideIcons.fileInput, size: 15),
                  Text('导入'),
                ],
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
                children: [
                  Icon(LucideIcons.fileOutput, size: 15),
                  Text('导出'),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showImportDialog() {
    showShadDialog(
      context: context,
      builder: (ctx) => DbcImportDialog(vm: viewModel),
    );
  }

  void _showExportDialog() {
    showShadDialog(
      context: context,
      builder: (ctx) => DbcExportDialog(vm: viewModel),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _buildLocaleSwitch() {
    return Watch((_) {
      final hasLocaleTables = viewModel.hasLocaleTables.value;
      final localeEnabled = viewModel.localeEnabled.value;

      return _SettingItem(
        title: '启用多语言支持',
        description: hasLocaleTables
            ? '数据库中检测到 locale 表，可以启用多语言功能以显示本地化内容。'
            : '数据库中未检测到 locale 表，无法启用多语言功能。',
        trailing: ShadSwitch(
          value: localeEnabled,
          onChanged: hasLocaleTables
              ? (value) => viewModel.setLocaleEnabled(value)
              : null,
        ),
        enabled: hasLocaleTables,
      );
    });
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget trailing;
  final bool enabled;

  const _SettingItem({
    required this.title,
    required this.description,
    required this.trailing,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: enabled
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: enabled
                        ? colorScheme.onSurface.withValues(alpha: 0.7)
                        : colorScheme.onSurface.withValues(alpha: 0.4),
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
