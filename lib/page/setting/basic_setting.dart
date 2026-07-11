import 'package:auto_route/auto_route.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
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
            const SizedBox(height: 12),
            _buildDbcExportItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildDbcExportItem() {
    return _SettingItem(
      title: '导出 DBC 文件',
      description: '将当前数据库中的 DBC 数据导出为 .dbc 文件，可选择需要导出的表。',
      trailing: ShadButton(
        size: ShadButtonSize.sm,
        child: const Text('导出'),
        onPressed: () => _showExportDialog(),
      ),
    );
  }

  void _showExportDialog() {
    showShadDialog(
      context: context,
      builder: (ctx) => _DbcExportDialog(vm: viewModel),
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

const _kDbcExportDialogWidth = 560.0;

class _DbcExportDialog extends StatefulWidget {
  final SettingViewModel vm;
  const _DbcExportDialog({required this.vm});

  @override
  State<_DbcExportDialog> createState() => _DbcExportDialogState();
}

class _DbcExportDialogState extends State<_DbcExportDialog> {
  SettingViewModel get _vm => widget.vm;
  final _dirController = TextEditingController();
  String? _outputDir;
  bool _loaded = false;
  void Function()? _unsub;

  @override
  void initState() {
    super.initState();
    // 避免上次导出成功后 signal 仍为 true，导致对话框一打开就被立刻关闭。
    _vm.dbcExportSuccess.value = false;
    _unsub = _vm.dbcExportSuccess.subscribe(_onExportSuccessChanged);
    _vm.loadExportItems().then((_) {
      if (mounted) setState(() => _loaded = true);
    });
  }

  @override
  void dispose() {
    _unsub?.call();
    _dirController.dispose();
    super.dispose();
  }

  void _onExportSuccessChanged(bool success) {
    if (success && mounted) {
      _unsub?.call();
      _unsub = null;
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kDbcExportDialogWidth,
      child: Watch((_) => _buildBody()),
    );
  }

  Widget _buildBody() {
    // 在顶层读取所有可能变化的 signal，确保 Watch 的 computed 正确追踪依赖
    final error = _vm.dbcExportError.value;
    final exporting = _vm.dbcExporting.value;
    final items = _vm.dbcExportItems.value;

    if (error != null) return _buildErrorBody(error);
    if (exporting) return _buildProgressBody();
    if (!_loaded) return _buildLoadingBody();
    return _buildSelectionBody(items);
  }

  Widget _buildLoadingBody() {
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcExportDialogWidth),
      title: const Row(
        spacing: 10,
        children: [
          SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          Text('正在加载表清单...'),
        ],
      ),
      child: const SizedBox(height: 100),
    );
  }

  Widget _buildSelectionBody(List<DbcExportItem> items) {
    final selectedCount = items.where((e) => e.selected).length;
    final allSelected = selectedCount == items.length;
    final theme = ShadTheme.of(context);

    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcExportDialogWidth),
      title: Row(
        spacing: 10,
        children: [
          Icon(LucideIcons.fileOutput, size: 20),
          const Text('导出 DBC 文件'),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          Row(
            children: [
              ShadButton.ghost(
                size: ShadButtonSize.sm,
                onPressed: () {
                  final newVal = !allSelected;
                  _vm.dbcExportItems.value = [
                    for (final item in _vm.dbcExportItems.value)
                      item.copyWith(selected: newVal),
                  ];
                },
                child: Text(allSelected ? '取消全选' : '全选'),
              ),
              const Spacer(),
              Text(
                '已选 $selectedCount / ${items.length}',
                style: theme.textTheme.muted.copyWith(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 260,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Material(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _buildTableRow(items[index]);
                  },
                ),
              ),
            ),
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: ShadInput(
                  controller: _dirController,
                  placeholder: const Text('选择输出目录...'),
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(LucideIcons.folderSearch, size: 16),
                  ),
                  readOnly: true,
                ),
              ),
              ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: () async {
                  final dir = await getDirectoryPath();
                  if (dir != null && mounted) {
                    setState(() {
                      _dirController.text = dir;
                      _outputDir = dir;
                    });
                  }
                },
                child: const Text('浏览...'),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              const Spacer(),
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('取消'),
              ),
              ShadButton(
                onPressed: selectedCount == 0 || _outputDir == null
                    ? null
                    : () => _vm.exportDbc(_outputDir!),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [Icon(LucideIcons.play, size: 15), Text('开始导出')],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(DbcExportItem item) {
    final theme = Theme.of(context);
    final shad = ShadTheme.of(context);
    final countColor = item.countFailed
        ? shad.colorScheme.destructive
        : theme.colorScheme.onSurface.withValues(alpha: 0.55);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ShadCheckbox(
            value: item.selected,
            onChanged: (v) {
              final items = [..._vm.dbcExportItems.value];
              final idx = items.indexWhere(
                (e) => e.tableName == item.tableName,
              );
              if (idx != -1) items[idx] = item.copyWith(selected: v);
              _vm.dbcExportItems.value = items;
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface,
                ),
                children: [
                  TextSpan(text: item.dbcFileName),
                  TextSpan(
                    text: '  (${item.recordCountLabel})',
                    style: TextStyle(fontSize: 12, color: countColor),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBody() {
    final theme = ShadTheme.of(context);
    final mutedStyle = theme.textTheme.muted.copyWith(fontSize: 12);
    final ratio = _vm.dbcExportProgress.value;
    final label = _vm.dbcExportProgressLabel.value;
    final detail = _vm.dbcExportProgressDetail.value;

    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcExportDialogWidth),
      title: Row(
        spacing: 10,
        children: [
          const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const Text('正在导出 DBC 数据'),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 14,
        children: [
          if (ratio != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('总体进度', style: mutedStyle),
                Text('${(ratio * 100).toStringAsFixed(0)}%', style: mutedStyle),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: ratio, minHeight: 6),
            ),
          ],
          if (label.isNotEmpty)
            Row(
              spacing: 8,
              children: [
                Icon(
                  LucideIcons.fileOutput,
                  size: 15,
                  color: theme.colorScheme.mutedForeground,
                ),
                Expanded(
                  child: Text(label, style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
          if (detail.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text(detail, style: mutedStyle),
            ),
          if (ratio == null && label.isEmpty)
            const Text('正在准备...', style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildErrorBody(String error) {
    final theme = ShadTheme.of(context);
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcExportDialogWidth),
      title: Row(
        spacing: 10,
        children: [
          Icon(
            LucideIcons.triangleAlert,
            size: 20,
            color: theme.colorScheme.destructive,
          ),
          const Text('DBC 导出失败'),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.destructive.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: theme.colorScheme.destructive.withValues(alpha: 0.2),
              ),
            ),
            child: SelectableText(error, style: const TextStyle(fontSize: 13)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                ShadButton.outline(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('关闭'),
                ),
                ShadButton(
                  onPressed: _outputDir != null
                      ? () => _vm.retryExport(_outputDir!)
                      : null,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Icon(LucideIcons.rotateCw, size: 15),
                      Text('重试'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
