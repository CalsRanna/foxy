import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/view_model/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/mpq_export_workflow_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CombinedExportDialog extends StatefulWidget {
  final CombinedExportWorkflowViewModel vm;
  const CombinedExportDialog({super.key, required this.vm});

  @override
  State<CombinedExportDialog> createState() => _CombinedExportDialogState();
}

class _CombinedExportDialogState extends State<CombinedExportDialog> {
  final _dbcDirController = StringFieldController();
  final _mpqDirController = StringFieldController();
  final _fileNameController = StringFieldController();
  final _searchController = StringFieldController();

  /// The following states use signals: Watch subscribes directly, avoiding
  /// a parent setState rebuilding the Watch and triggering signals_flutter's
  /// didUpdateWidget→recompute chain that would break the subscription.
  final _dbcOutputDir = signal<String?>(null);
  final _mpqOutputDir = signal<String?>(null);
  final _fileName = signal('');
  final _loaded = signal(false);
  final _query = signal('');
  CombinedExportWorkflowViewModel get _vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DialogUtil.width,
      child: Watch((_) {
        // Explicitly subscribe to the list signal so select-all/deselect
        // refreshes the whole table.
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
            title: SettingDialogShell.titleRow(LucideIcons.zap, '一键导出 DBC + MPQ'),
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
          final dbcDirectory = _dbcOutputDir.value;
          final mpqDirectory = _mpqOutputDir.value;
          final name = _fileName.value;
          final mpqTarget = mpqDirectory != null && name.isNotEmpty
              ? p.join(mpqDirectory, name)
              : null;
          return SettingDialogShell(
            title: SettingDialogShell.titleRow(
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
                SettingDialogShell.banner(
                  context,
                  text:
                      '已导出 ${_vm.result.value?.completed ?? 0} 个 DBC 文件'
                      '${(_vm.result.value?.skipped ?? 0) > 0 ? '，跳过 ${_vm.result.value!.skipped} 个空表' : ''}'
                      '，并打包 MPQ 补丁。',
                  color: theme.colorScheme.primary,
                  icon: LucideIcons.circleCheck,
                ),
                if (dbcDirectory != null)
                  SettingDialogShell.mutedHint(context, 'DBC 输出目录：$dbcDirectory'),
                if (mpqTarget != null)
                  SettingDialogShell.mutedHint(context, '已生成: $mpqTarget'),
              ],
            ),
          );
        }

        if (exporting) {
          // Block Esc/back while a task is in flight: closing mid-run would
          // leave the export running in the background with no visible
          // state. Cancel (the only exit shown here) is in-dialog.
          return PopScope(
            canPop: false,
            child: SettingDialogShell(
              title: SettingDialogShell.titleRow(LucideIcons.zap, '正在一键导出 DBC + MPQ'),
              child: SettingDialogShell.progressPanel(
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
                        : '取消导出',
                  ),
                ),
              ),
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
        final dbcTargetDir = _dbcOutputDir.value;
        final mpqTargetDir = _mpqOutputDir.value;
        final fileNameReady = _fileName.value.trim().isNotEmpty;

        return SettingDialogShell(
          title: SettingDialogShell.titleRow(LucideIcons.zap, '一键导出 DBC + MPQ'),
          actions: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('关闭'),
            ),
            ShadButton(
              onPressed:
                  selectedCount == 0 ||
                      dbcTargetDir == null ||
                      mpqTargetDir == null ||
                      !fileNameReady
                  ? null
                  : () async {
                      _vm.setDbcOutputDirectory(dbcTargetDir);
                      _vm.setMpqOutputDirectory(mpqTargetDir);
                      _vm.setFileName(_fileName.value);
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                SettingDialogShell.mutedHint(
                  context,
                  '同时导出 DBC 文件并打包 MPQ 补丁：MPQ 直接复用本次导出的 DBC 文件，'
                  '全程只读取一次数据库。',
                ),
                Text(
                  'DBC 输出目录',
                  style: theme.textTheme.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SettingDialogShell.pathField(
                  controller: _dbcDirController,
                  placeholder: '服务端 DBC 目录',
                  onBrowse: _browseDbc,
                  onChanged: (value) {
                    final trimmed = value.trim();
                    _dbcOutputDir.value = trimmed.isEmpty ? null : trimmed;
                    _vm.setDbcOutputDirectory(value);
                  },
                ),
                Text(
                  'MPQ 输出目录',
                  style: theme.textTheme.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SettingDialogShell.pathField(
                  controller: _mpqDirController,
                  placeholder: '客户端 MPQ 目录（如 Data\\zhCN）',
                  onBrowse: _browseMpq,
                  onChanged: (value) {
                    final trimmed = value.trim();
                    _mpqOutputDir.value = trimmed.isEmpty ? null : trimmed;
                    _vm.setMpqOutputDirectory(value);
                  },
                ),
                Text(
                  'MPQ 文件名',
                  style: theme.textTheme.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ShadInput(
                  controller: _fileNameController.controller,
                  placeholder: const Text(MpqExportWorkflowViewModel.defaultPatchFileName),
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(LucideIcons.fileArchive, size: 16),
                  ),
                  onChanged: (value) {
                    final trimmed = value.trim();
                    _fileName.value = trimmed.isEmpty ? '' : trimmed;
                    _vm.setFileName(value);
                  },
                ),
                if (error != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8,
                    children: [
                      SettingDialogShell.banner(
                        context,
                        text: error,
                        color: theme.colorScheme.destructive,
                        icon: LucideIcons.triangleAlert,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ShadButton.outline(
                          size: ShadButtonSize.sm,
                          onPressed:
                              dbcTargetDir == null || mpqTargetDir == null
                              ? null
                              : () {
                                  _vm.setDbcOutputDirectory(dbcTargetDir);
                                  _vm.setMpqOutputDirectory(mpqTargetDir);
                                  _vm.setFileName(_fileName.value);
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
                  SettingDialogShell.banner(
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
                DbcTableSelectList(
                  items: items,
                  emptyText: _query.value.isEmpty ? '没有可导出的表' : '没有匹配的表',
                  onToggle: (item) =>
                      _vm.setItemSelected(item.tableName, !item.selected),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _dbcDirController.dispose();
    _mpqDirController.dispose();
    _fileNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
    final defaultDbcDir = _vm.dbcOutputDirectory.value;
    if (defaultDbcDir != null) {
      _dbcDirController.init(defaultDbcDir);
      _dbcOutputDir.value = defaultDbcDir;
    }
    final defaultMpqDir = _vm.mpqOutputDirectory.value;
    if (defaultMpqDir != null) {
      _mpqDirController.init(defaultMpqDir);
      _mpqOutputDir.value = defaultMpqDir;
    }
    _fileNameController.init(_vm.fileName.value);
    _fileName.value = _vm.fileName.value;
    if (mounted) _loaded.value = true;
  }

  Future<void> _browseDbc() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    _dbcDirController.init(dir);
    _dbcOutputDir.value = dir;
    _vm.setDbcOutputDirectory(dir);
  }

  Future<void> _browseMpq() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    _mpqDirController.init(dir);
    _mpqOutputDir.value = dir;
    _vm.setMpqOutputDirectory(dir);
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
}
