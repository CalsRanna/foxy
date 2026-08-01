import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

const _kDialogWidth = 640.0;

// ─── 公共壳 ───────────────────────────────────────────────────────────────

/// 设置相关对话框的公共壳（标题 + 内容 + 操作区）。
class SettingDialogShell extends StatelessWidget {
  final Widget title;
  final Widget child;
  final List<Widget> actions;

  const SettingDialogShell({
    super.key,
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

/// 对话框标题行（图标 + 文本）。
Widget settingDialogTitleRow(IconData icon, String text, {Color? iconColor}) {
  return Row(
    spacing: 10,
    children: [
      Icon(icon, size: 20, color: iconColor),
      Text(text),
    ],
  );
}

/// 弱化提示文本。
Widget settingDialogMutedHint(BuildContext context, String text) {
  final theme = ShadTheme.of(context);
  return Text(text, style: theme.textTheme.muted.copyWith(fontSize: 13));
}

/// 结果横幅（成功/错误/警告，带颜色与图标）。
Widget settingDialogBanner(
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

/// 路径输入行（输入框 + 浏览按钮）。
Widget settingDialogPathField({
  required StringFieldController controller,
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
          controller: controller.controller,
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

/// 只读路径展示框（目录配置来自设置页，动作对话框不再直接编辑）。
Widget settingDialogReadonlyPath(BuildContext context, String path) {
  final theme = ShadTheme.of(context);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: theme.colorScheme.border),
    ),
    child: Row(
      spacing: 8,
      children: [
        Icon(
          LucideIcons.folder,
          size: 15,
          color: theme.colorScheme.mutedForeground,
        ),
        Expanded(
          child: SelectableText(path, style: const TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}

/// 进度面板（比例条或加载指示 + 标签 + 详情）。
Widget settingDialogProgressPanel(
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
            Text(
              '${(ratio * 100).clamp(0, 100).toStringAsFixed(0)}%',
              style: muted,
            ),
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
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      if (detail.isNotEmpty) Text(detail, style: muted),
      if (ratio == null && label.isEmpty) Text(idleText, style: muted),
      if (trailing != null)
        Align(alignment: Alignment.centerRight, child: trailing),
    ],
  );
}

// ─── 导入对话框 ───────────────────────────────────────────────────────────

class DbcImportDialog extends StatefulWidget {
  final DbcImportWorkflowViewModel vm;
  const DbcImportDialog({super.key, required this.vm});

  @override
  State<DbcImportDialog> createState() => _DbcImportDialogState();
}

class _DbcImportDialogState extends State<DbcImportDialog> {
  DbcImportWorkflowViewModel get _vm => widget.vm;

  /// 就绪标记用 signal：Watch 直接订阅，避免父级 setState 重建 Watch
  /// 触发 signals_flutter 的 didUpdateWidget→recompute 链路破坏订阅。
  final _ready = signal(false);

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    try {
      await _vm.prepare();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
    if (!mounted) return;
    _ready.value = true;
  }

  Future<void> _start() async {
    try {
      await _vm.start();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kDialogWidth,
      child: Watch((_) {
        if (!_ready.value) {
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.fileInput, '导入 DBC'),
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

        final workflowStatus = _vm.status.value;
        final importing =
            workflowStatus == WorkflowStatus.preparing ||
            workflowStatus == WorkflowStatus.running ||
            workflowStatus == WorkflowStatus.cancelling;
        final error = _vm.errorMessage.value;
        final success = workflowStatus == WorkflowStatus.succeeded;
        final theme = ShadTheme.of(context);

        if (success) {
          return SettingDialogShell(
            title: settingDialogTitleRow(
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
            child: settingDialogBanner(
              context,
              text:
                  '导入完成：写入 ${_vm.result.value?.completed ?? 0} 个文件'
                  '${(_vm.result.value?.skipped ?? 0) > 0 ? '，跳过 ${_vm.result.value!.skipped} 个' : ''}。',
              color: theme.colorScheme.primary,
              icon: LucideIcons.circleCheck,
            ),
          );
        }

        if (importing) {
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.fileInput, '正在导入 DBC'),
            child: settingDialogProgressPanel(
              context,
              ratio: _vm.progress.value,
              label: _vm.progressLabel.value,
              detail: _vm.progressDetail.value,
              trailing: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: workflowStatus == WorkflowStatus.cancelling
                    ? null
                    : _vm.cancel,
                child: Text(
                  workflowStatus == WorkflowStatus.cancelling
                      ? '正在取消…'
                      : '取消导入',
                ),
              ),
            ),
          );
        }

        final path = _vm.path.value;
        final configured = path != null && path.trim().isNotEmpty;
        return SettingDialogShell(
          title: settingDialogTitleRow(LucideIcons.fileInput, '导入 DBC'),
          actions: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('关闭'),
            ),
            ShadButton(
              onPressed: configured ? _start : null,
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
              settingDialogMutedHint(
                context,
                '从配置的服务端 DBC 目录导入。导入以 DBC 为准：将覆盖数据库中'
                '对应表的数据；若需保留库内数据请先自行备份。',
              ),
              Text(
                '服务端 DBC 目录',
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (configured)
                settingDialogReadonlyPath(context, path)
              else
                settingDialogMutedHint(
                  context,
                  '尚未配置服务端 DBC 目录，请先前往设置页「目录设置」中配置。',
                ),
              if (error != null)
                settingDialogBanner(
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
  final DbcExportWorkflowViewModel vm;
  const DbcExportDialog({super.key, required this.vm});

  @override
  State<DbcExportDialog> createState() => _DbcExportDialogState();
}

class _DbcExportDialogState extends State<DbcExportDialog> {
  DbcExportWorkflowViewModel get _vm => widget.vm;
  final _dirController = StringFieldController();
  final _searchController = StringFieldController();
  /// 以下状态用 signal：Watch 直接订阅，避免父级 setState 重建 Watch
  /// 触发 signals_flutter 的 didUpdateWidget→recompute 链路破坏订阅。
  final _outputDir = signal<String?>(null);
  final _loaded = signal(false);
  final _query = signal('');

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _query.value = _searchController.collect().trim().toLowerCase();
    });
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await _vm.prepare();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
    if (!mounted) return;
    final defaultDir = _vm.outputDirectory.value;
    if (defaultDir != null) {
      _dirController.init(defaultDir);
      _outputDir.value = defaultDir;
    }
    if (mounted) _loaded.value = true;
  }

  @override
  void dispose() {
    _dirController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<DbcExportItem> _filterItems(List<DbcExportItem> items) {
    final query = _query.value;
    if (query.isEmpty) return items;
    return items
        .where(
          (item) =>
              item.dbcFileName.toLowerCase().contains(query) ||
              item.tableName.toLowerCase().contains(query),
        )
        .toList();
  }

  Future<void> _browse() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    _dirController.init(dir);
    _outputDir.value = dir;
    _vm.setOutputDirectory(dir);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kDialogWidth,
      child: Watch((_) {
        // 显式订阅列表信号，保证全选/取消全选时整表刷新。
        final allItems = _vm.items.value;
        final workflowStatus = _vm.status.value;
        final exporting =
            workflowStatus == WorkflowStatus.preparing ||
            workflowStatus == WorkflowStatus.running ||
            workflowStatus == WorkflowStatus.cancelling;
        final error = _vm.errorMessage.value;
        final success = workflowStatus == WorkflowStatus.succeeded;
        final theme = ShadTheme.of(context);

        if (!_loaded.value && !exporting) {
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.fileOutput, '导出 DBC'),
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
          return SettingDialogShell(
            title: settingDialogTitleRow(
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
                settingDialogBanner(
                  context,
                  text:
                      '成功导出 ${_vm.result.value?.completed ?? 0} 个文件'
                      '${(_vm.result.value?.skipped ?? 0) > 0 ? '，跳过 ${_vm.result.value!.skipped} 个空表' : ''}。',
                  color: theme.colorScheme.primary,
                  icon: LucideIcons.circleCheck,
                ),
                if (_outputDir.value != null)
                  settingDialogMutedHint(context, '输出目录：${_outputDir.value}'),
              ],
            ),
          );
        }

        if (exporting) {
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.fileOutput, '正在导出 DBC'),
            child: settingDialogProgressPanel(
              context,
              ratio: _vm.progress.value,
              label: _vm.progressLabel.value,
              detail: _vm.progressDetail.value,
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

        return SettingDialogShell(
          title: settingDialogTitleRow(LucideIcons.fileOutput, '导出 DBC'),
          actions: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('关闭'),
            ),
            ShadButton(
              onPressed: selectedCount == 0 || _outputDir.value == null
                  ? null
                  : () async {
                      _vm.setOutputDirectory(_outputDir.value!);
                      try {
                        await _vm.start();
                      } catch (_) {
                        // The workflow exposes the failure through errorMessage.
                      }
                    },
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
              settingDialogMutedHint(context, '将数据库中的 DBC 表写出为 .dbc 文件。空表会自动跳过。'),
              Text(
                '输出目录',
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              settingDialogPathField(
                controller: _dirController,
                placeholder: '选择导出目录',
                onBrowse: _browse,
                onChanged: (value) {
                  final trimmed = value.trim();
                  _outputDir.value = trimmed.isEmpty ? null : trimmed;
                  _vm.setOutputDirectory(value);
                },
              ),
              if (error != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    settingDialogBanner(
                      context,
                      text: error,
                      color: theme.colorScheme.destructive,
                      icon: LucideIcons.triangleAlert,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ShadButton.outline(
                        size: ShadButtonSize.sm,
                        onPressed: _outputDir.value == null
                            ? null
                            : () {
                                _vm.setOutputDirectory(_outputDir.value!);
                                _vm.retry();
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
                settingDialogBanner(
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
                      controller: _searchController.controller,
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
                  border: Border.all(color: theme.colorScheme.border),
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
                                _query.value.isEmpty
                                    ? '没有可导出的表'
                                    : '没有匹配的表',
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

  const _ExportTableRow({
    super.key,
    required this.item,
    required this.onChanged,
  });

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
      onChanged: item.canSelect ? (value) => onChanged(value ?? false) : null,
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
