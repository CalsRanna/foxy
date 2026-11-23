import 'package:flutter/material.dart';
import 'package:foxy/page/setting/dbc_table_select_list.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/view_model/workflow/dbc_export_item.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class MpqExportDialog extends StatefulWidget {
  final MpqExportWorkflowViewModel vm;
  const MpqExportDialog({super.key, required this.vm});

  @override
  State<MpqExportDialog> createState() => _MpqExportDialogState();
}

class _MpqExportDialogState extends State<MpqExportDialog>
    with DialogErrorState {
  final _fileNameController = StringFieldController();
  final _searchController = StringFieldController();

  /// The following states use signals: SignalBuilder subscribes directly, avoiding
  /// a parent setState rebuilding the SignalBuilder and triggering signals_flutter's
  /// didUpdateWidget→recompute chain that would break the subscription.
  final _fileName = signal('');
  final _loaded = signal(false);
  final _query = signal('');
  @override
  ReadonlySignal<String?> get dialogError => _vm.errorMessage;

  MpqExportWorkflowViewModel get _vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DialogUtil.width,
      child: SignalBuilder(
        builder: (_) {
          // Explicitly subscribe to the list signal so select-all/deselect
          // refreshes the whole table.
          final allItems = _vm.items.value;
          final workflowStatus = _vm.status.value;
          final exporting =
              workflowStatus == WorkflowStatus.preparing ||
              workflowStatus == WorkflowStatus.running ||
              workflowStatus == WorkflowStatus.cancelling;
          final success = workflowStatus == WorkflowStatus.succeeded;
          final theme = ShadTheme.of(context);

          if (!_loaded.value && !exporting) {
            return SettingDialogShell(
              title: '导出 MPQ 补丁',
              child: const SizedBox(
                height: 140,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      FoxyLoadingIndicator(),
                      Text('正在读取表统计…', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ),
            );
          }

          if (success) {
            final name = p.basename(_vm.fileName.value);
            final result = _vm.result.value;
            return SettingDialogShell(
              title: '导出完成',
              actions: [
                ShadButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('确定'),
                ),
              ],
              child: SelectableText(
                '已生成 MPQ 补丁 $name'
                '${(result?.completed ?? 0) > 0 ? '，打包 ${result!.completed} 张 DBC 表' : ''}'
                '${(result?.skipped ?? 0) > 0 ? '，跳过 ${result!.skipped} 个空表' : ''}。',
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
                title: '正在导出 MPQ 补丁',
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
          final selectableCount = allItems
              .where((item) => item.canSelect)
              .length;
          final allSelected =
              selectableCount > 0 &&
              allItems
                  .where((item) => item.canSelect)
                  .every((item) => item.selected);
          final hasOutputDirectory = _vm.outputDirectory.value != null;
          final fileNameReady = _fileName.value.trim().isNotEmpty;

          return SettingDialogShell(
            title: '导出 MPQ 补丁',
            actions: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('取消'),
              ),
              ShadButton(
                onPressed:
                    selectedCount == 0 || !hasOutputDirectory || !fileNameReady
                    ? null
                    : () async {
                        _vm.setFileName(_fileName.value);
                        try {
                          await _vm.start();
                        } catch (_) {
                          // The workflow exposes the failure through errorMessage.
                        }
                      },
                child: const Text('导出'),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                SettingDialogShell.mutedHint(
                  context,
                  '将选中的 DBC 表打包为 MPQ 补丁，客户端启动时会加载补丁以覆盖原始 DBC。',
                ),
                if (!hasOutputDirectory)
                  SettingDialogShell.mutedHint(
                    context,
                    '请在「设置 → 游戏环境」中配置客户端目录。',
                  ),
                Text(
                  'MPQ 文件名',
                  style: theme.textTheme.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ShadInput(
                  controller: _fileNameController.controller,
                  placeholder: const Text(
                    MpqExportWorkflowViewModel.defaultPatchFileName,
                  ),
                  onChanged: (value) {
                    final trimmed = value.trim();
                    _fileName.value = trimmed.isEmpty ? '' : trimmed;
                    _vm.setFileName(value);
                  },
                ),
                if (workflowStatus == WorkflowStatus.failed)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ShadButton.outline(
                      size: ShadButtonSize.sm,
                      onPressed: !hasOutputDirectory
                          ? null
                          : () async {
                              _vm.setFileName(_fileName.value);
                              try {
                                await _vm.retry();
                              } catch (_) {
                                // The workflow reports through errorMessage.
                              }
                            },
                      child: const Text('重试'),
                    ),
                  ),
                Row(
                  spacing: 8,
                  children: [
                    ShadButton.ghost(
                      size: ShadButtonSize.sm,
                      onPressed: selectableCount == 0
                          ? null
                          : () => _vm.setAllSelectableSelected(!allSelected),
                      child: Text(allSelected ? '取消全选' : '全选'),
                    ),
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
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
    // Prepare outside the build phase; see DbcExportDialog.initState.
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    try {
      await _vm.prepare();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
    if (!mounted) return;
    _fileNameController.init(_vm.fileName.value);
    _fileName.value = _vm.fileName.value;
    _loaded.value = true;
    if (_vm.errorMessage.value == null) {
      DbcTableSelectList.reportCountErrors(_vm.items.value);
    }
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
