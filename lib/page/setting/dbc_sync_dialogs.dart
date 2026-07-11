import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/setting/setting_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

const _kDialogWidth = 640.0;

// ─── 公共壳 ───────────────────────────────────────────────────────────────

class _DialogShell extends StatelessWidget {
  final Widget title;
  final Widget child;
  final List<Widget> actions;

  const _DialogShell({
    required this.title,
    required this.child,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDialogWidth),
      title: title,
      actions: actions,
      child: child,
    );
  }
}

Widget _titleRow(IconData icon, String text, {Color? iconColor}) {
  return Row(
    spacing: 10,
    children: [
      Icon(icon, size: 20, color: iconColor),
      Text(text),
    ],
  );
}

Widget _mutedHint(BuildContext context, String text) {
  final theme = ShadTheme.of(context);
  return Text(text, style: theme.textTheme.muted.copyWith(fontSize: 13));
}

Widget _banner(
  BuildContext context, {
  required String text,
  required Color color,
  IconData? icon,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.22)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        if (icon != null) Icon(icon, size: 16, color: color),
        Expanded(
          child: SelectableText(
            text,
            style: TextStyle(fontSize: 13, color: color, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _pathField({
  required TextEditingController controller,
  required String placeholder,
  required VoidCallback onBrowse,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  bool enabled = true,
}) {
  return Row(
    spacing: 8,
    children: [
      Expanded(
        child: ShadInput(
          controller: controller,
          placeholder: Text(placeholder),
          enabled: enabled,
          leading: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(LucideIcons.folderSearch, size: 16),
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        ),
      ),
      ShadButton.outline(
        size: ShadButtonSize.sm,
        onPressed: enabled ? onBrowse : null,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [Icon(LucideIcons.folderOpen, size: 15), Text('浏览')],
        ),
      ),
    ],
  );
}

Widget _progressPanel(
  BuildContext context, {
  required double? ratio,
  required String label,
  required String detail,
  String idleText = '正在准备...',
  Widget? trailing,
}) {
  final theme = ShadTheme.of(context);
  final muted = theme.textTheme.muted.copyWith(fontSize: 12);
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: 12,
    children: [
      if (ratio != null) ...[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('进度', style: muted),
            Text('${(ratio * 100).clamp(0, 100).toStringAsFixed(0)}%', style: muted),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: ratio, minHeight: 8),
        ),
      ] else
        const Center(
          child: SizedBox.square(
            dimension: 28,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      if (label.isNotEmpty)
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      if (detail.isNotEmpty) Text(detail, style: muted),
      if (ratio == null && label.isEmpty) Text(idleText, style: muted),
      if (trailing != null) Align(alignment: Alignment.centerRight, child: trailing),
    ],
  );
}

// ─── 导入对话框 ───────────────────────────────────────────────────────────

class DbcImportDialog extends StatefulWidget {
  final SettingViewModel vm;
  const DbcImportDialog({super.key, required this.vm});

  @override
  State<DbcImportDialog> createState() => _DbcImportDialogState();
}

class _DbcImportDialogState extends State<DbcImportDialog> {
  SettingViewModel get _vm => widget.vm;
  final _pathController = TextEditingController();
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _vm.prepareImportDialog().then((_) {
      if (!mounted) return;
      final path = _vm.dbcImportPath.value;
      if (path != null) _pathController.text = path;
      setState(() => _ready = true);
    });
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  Future<void> _browse() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    _pathController.text = dir;
    _vm.setImportPathLocal(dir);
    setState(() {});
    await _vm.setImportPath(dir);
  }

  Future<void> _start() async {
    _vm.setImportPathLocal(_pathController.text);
    await _vm.startImport();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kDialogWidth,
      child: Watch((_) {
        if (!_ready) {
          return _DialogShell(
            title: _titleRow(LucideIcons.fileInput, '导入 DBC'),
            child: const SizedBox(
              height: 120,
              child: Center(
                child: SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          );
        }

        final importing = _vm.dbcImporting.value;
        final error = _vm.dbcImportError.value;
        final success = _vm.dbcImportSuccess.value;
        final theme = ShadTheme.of(context);

        if (success) {
          return _DialogShell(
            title: _titleRow(
              LucideIcons.circleCheck,
              '导入完成',
              iconColor: theme.colorScheme.primary,
            ),
            actions: [
              ShadButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('完成'),
              ),
            ],
            child: _banner(
              context,
              text: _vm.dbcImportSuccessMessage.value.isEmpty
                  ? 'DBC 数据已导入。'
                  : _vm.dbcImportSuccessMessage.value,
              color: theme.colorScheme.primary,
              icon: LucideIcons.circleCheck,
            ),
          );
        }

        if (importing) {
          return _DialogShell(
            title: _titleRow(LucideIcons.fileInput, '正在导入 DBC'),
            child: _progressPanel(
              context,
              ratio: _vm.dbcImportProgress.value,
              label: _vm.dbcImportProgressLabel.value,
              detail: _vm.dbcImportProgressDetail.value,
              trailing: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: _vm.dbcImportCancelling.value
                    ? null
                    : _vm.cancelImport,
                child: Text(
                  _vm.dbcImportCancelling.value ? '正在取消…' : '取消导入',
                ),
              ),
            ),
          );
        }

        return _DialogShell(
          title: _titleRow(LucideIcons.fileInput, '导入 DBC'),
          actions: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('关闭'),
            ),
            ShadButton(
              onPressed:
                  (_vm.dbcImportPath.value == null ||
                      _vm.dbcImportPath.value!.trim().isEmpty)
                  ? null
                  : _start,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [Icon(LucideIcons.play, size: 15), Text('开始导入')],
              ),
            ),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14,
            children: [
              _mutedHint(
                context,
                '选择包含 Spell.dbc、Faction.dbc 等文件的客户端 DBC 目录。'
                '导入以 DBC 为准：将覆盖数据库中对应表的数据；若需保留库内数据请先自行备份。',
              ),
              Text('源目录', style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
              _pathField(
                controller: _pathController,
                placeholder: '选择或输入 DBC 目录路径',
                onBrowse: _browse,
                onChanged: (value) {
                  _vm.setImportPathLocal(value);
                  setState(() {});
                },
                onSubmitted: (_) => _start(),
              ),
              if (error != null)
                _banner(
                  context,
                  text: error,
                  color: theme.colorScheme.destructive,
                  icon: LucideIcons.triangleAlert,
                ),
            ],
          ),
        );
      }),
    );
  }
}

// ─── 导出对话框 ───────────────────────────────────────────────────────────

class DbcExportDialog extends StatefulWidget {
  final SettingViewModel vm;
  const DbcExportDialog({super.key, required this.vm});

  @override
  State<DbcExportDialog> createState() => _DbcExportDialogState();
}

class _DbcExportDialogState extends State<DbcExportDialog> {
  SettingViewModel get _vm => widget.vm;
  final _dirController = TextEditingController();
  final _searchController = TextEditingController();
  String? _outputDir;
  bool _loaded = false;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final defaultDir = await _vm.prepareExportDialog();
    if (!mounted) return;
    if (defaultDir != null) {
      _dirController.text = defaultDir;
      _outputDir = defaultDir;
    }
    await _vm.loadExportItems();
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _dirController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<DbcExportItem> _filterItems(List<DbcExportItem> items) {
    if (_query.isEmpty) return items;
    return items
        .where(
          (item) =>
              item.dbcFileName.toLowerCase().contains(_query) ||
              item.tableName.toLowerCase().contains(_query),
        )
        .toList();
  }

  Future<void> _browse() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    setState(() {
      _dirController.text = dir;
      _outputDir = dir;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kDialogWidth,
      child: Watch((_) {
        // 显式订阅列表信号，保证全选/取消全选时整表刷新。
        final allItems = _vm.dbcExportItems.value;
        final exporting = _vm.dbcExporting.value;
        final error = _vm.dbcExportError.value;
        final success = _vm.dbcExportSuccess.value;
        final theme = ShadTheme.of(context);

        if (!_loaded && !exporting) {
          return _DialogShell(
            title: _titleRow(LucideIcons.fileOutput, '导出 DBC'),
            child: const SizedBox(
              height: 140,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    Text('正在读取表统计…', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
          );
        }

        if (success) {
          return _DialogShell(
            title: _titleRow(
              LucideIcons.circleCheck,
              '导出完成',
              iconColor: theme.colorScheme.primary,
            ),
            actions: [
              ShadButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('完成'),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                _banner(
                  context,
                  text: _vm.dbcExportSuccessMessage.value.isEmpty
                      ? 'DBC 文件已写出。'
                      : _vm.dbcExportSuccessMessage.value,
                  color: theme.colorScheme.primary,
                  icon: LucideIcons.circleCheck,
                ),
                if (_outputDir != null)
                  _mutedHint(context, '输出目录：$_outputDir'),
              ],
            ),
          );
        }

        if (exporting) {
          return _DialogShell(
            title: _titleRow(LucideIcons.fileOutput, '正在导出 DBC'),
            child: _progressPanel(
              context,
              ratio: _vm.dbcExportProgress.value,
              label: _vm.dbcExportProgressLabel.value,
              detail: _vm.dbcExportProgressDetail.value,
            ),
          );
        }

        final items = _filterItems(allItems);
        final selectedCount = allItems
            .where((item) => item.selected && item.canSelect)
            .length;
        final selectableCount = allItems.where((item) => item.canSelect).length;
        final allSelected =
            selectableCount > 0 &&
            allItems
                .where((item) => item.canSelect)
                .every((item) => item.selected);
        final failureCount = allItems.where((item) => item.countFailed).length;

        return _DialogShell(
          title: _titleRow(LucideIcons.fileOutput, '导出 DBC'),
          actions: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('关闭'),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              _mutedHint(
                context,
                '将数据库中的 DBC 表写出为 .dbc 文件。空表会自动跳过。',
              ),
              Text(
                '输出目录',
                style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
              ),
              _pathField(
                controller: _dirController,
                placeholder: '选择导出目录',
                onBrowse: _browse,
                onChanged: (value) {
                  final trimmed = value.trim();
                  setState(() {
                    _outputDir = trimmed.isEmpty ? null : trimmed;
                  });
                },
              ),
              if (error != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    _banner(
                      context,
                      text: error,
                      color: theme.colorScheme.destructive,
                      icon: LucideIcons.triangleAlert,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ShadButton.outline(
                        size: ShadButtonSize.sm,
                        onPressed: _outputDir == null
                            ? null
                            : () {
                                _vm.clearExportFeedback();
                                _vm.retryExport(_outputDir!);
                              },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 6,
                          children: [
                            Icon(LucideIcons.rotateCw, size: 14),
                            Text('重试'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              if (failureCount > 0)
                _banner(
                  context,
                  text: '$failureCount 张表统计失败，已禁用勾选。将鼠标悬停在表名上可查看原因。',
                  color: theme.colorScheme.destructive,
                  icon: LucideIcons.circleAlert,
                ),
              Row(
                children: [
                  ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    onPressed: selectableCount == 0
                        ? null
                        : () => _vm.setAllSelectableSelected(!allSelected),
                    child: Text(allSelected ? '取消全选' : '全选'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '已选 $selectedCount / $selectableCount',
                    style: theme.textTheme.muted.copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: ShadInput(
                      controller: _searchController,
                      placeholder: const Text('搜索表名…'),
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(LucideIcons.search, size: 14),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.border,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      color: theme.colorScheme.muted.withValues(alpha: 0.35),
                      child: Row(
                        children: [
                          const SizedBox(width: 28),
                          Expanded(
                            child: Text(
                              '文件',
                              style: theme.textTheme.muted.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 96,
                            child: Text(
                              '记录数',
                              textAlign: TextAlign.end,
                              style: theme.textTheme.muted.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: items.isEmpty
                          ? Center(
                              child: Text(
                                _query.isEmpty ? '没有可导出的表' : '没有匹配的表',
                                style: theme.textTheme.muted,
                              ),
                            )
                          : ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (_, _) => Divider(
                                height: 1,
                                color: theme.colorScheme.border.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return _ExportTableRow(
                                  key: ValueKey(
                                    '${item.tableName}:${item.selected}:${item.recordCountLabel}',
                                  ),
                                  item: item,
                                  onChanged: (value) => _vm.setItemSelected(
                                    item.tableName,
                                    value,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ExportTableRow extends StatelessWidget {
  final DbcExportItem item;
  final ValueChanged<bool> onChanged;

  const _ExportTableRow({super.key, required this.item, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final material = Theme.of(context);
    final failed = item.countFailed;
    final countColor = failed
        ? theme.colorScheme.destructive
        : material.colorScheme.onSurface.withValues(alpha: 0.65);
    final nameColor = failed
        ? material.colorScheme.onSurface.withValues(alpha: 0.55)
        : material.colorScheme.onSurface;

    // 使用受控 Checkbox，避免 shadcn 组件内部状态与外部 selected 脱节。
    final checkbox = Checkbox(
      value: item.selected,
      onChanged: item.canSelect
          ? (value) => onChanged(value ?? false)
          : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );

    final row = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.canSelect ? () => onChanged(!item.selected) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              checkbox,
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.dbcFileName,
                  style: TextStyle(fontSize: 13, color: nameColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (failed) ...[
                Icon(
                  LucideIcons.circleAlert,
                  size: 14,
                  color: theme.colorScheme.destructive,
                ),
                const SizedBox(width: 6),
              ],
              SizedBox(
                width: 96,
                child: Text(
                  item.recordCountLabel,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12, color: countColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!failed) return row;
    return Tooltip(
      message: item.countError ?? '行数统计失败',
      waitDuration: const Duration(milliseconds: 250),
      child: row,
    );
  }
}
