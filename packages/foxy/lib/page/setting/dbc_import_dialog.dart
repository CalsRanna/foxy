import 'package:flutter/material.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class DbcImportDialog extends StatefulWidget {
  final DbcImportWorkflowViewModel vm;
  const DbcImportDialog({super.key, required this.vm});

  @override
  State<DbcImportDialog> createState() => _DbcImportDialogState();
}

class _DbcImportDialogState extends State<DbcImportDialog> {
  /// The ready flag uses a signal: SignalBuilder subscribes directly, avoiding a
  /// parent setState rebuilding the SignalBuilder and triggering signals_flutter's
  /// didUpdateWidget→recompute chain that would break the subscription.
  final _ready = signal(false);

  DbcImportWorkflowViewModel get _vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DialogUtil.width,
      child: SignalBuilder(
        builder: (_) {
          if (!_ready.value) {
            return const PopScope(
              canPop: false,
              child: SettingDialogShell(
                title: '正在导入 DBC',
                child: SizedBox(
                  height: 120,
                  child: Center(child: FoxyLoadingIndicator()),
                ),
              ),
            );
          }

          final workflowStatus = _vm.status.value;
          final importing =
              workflowStatus == WorkflowStatus.preparing ||
              workflowStatus == WorkflowStatus.running ||
              workflowStatus == WorkflowStatus.cancelling;
          final success = workflowStatus == WorkflowStatus.succeeded;

          if (success) {
            return SettingDialogShell(
              title: '导入完成',
              actions: [
                ShadButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('确定'),
                ),
              ],
              child: SelectableText(
                '导入完成：写入 ${_vm.result.value?.completed ?? 0} 个文件'
                '${(_vm.result.value?.skipped ?? 0) > 0 ? '，跳过 ${_vm.result.value!.skipped} 个' : ''}。',
              ),
            );
          }

          if (importing) {
            // Block Esc/back while a task is in flight: closing mid-run would
            // leave the import running in the background with no visible
            // state. Cancel (the only exit shown here) is in-dialog.
            return PopScope(
              canPop: false,
              child: SettingDialogShell(
                title: '正在导入 DBC',
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
                          : '取消导入',
                    ),
                  ),
                ),
              ),
            );
          }

          if (workflowStatus == WorkflowStatus.failed) {
            return DialogUtil.errorDialog(
              context,
              _vm.errorMessage.value ?? 'DBC 导入失败。',
              onRetry: _prepareAndStart,
            );
          }

          return SettingDialogShell(
            title: '未配置服务端 DBC 目录',
            actions: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('取消'),
              ),
            ],
            child: SettingDialogShell.mutedHint(
              context,
              '请在「目录设置」中选择包含 DBC 文件的服务端目录。',
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Prepare after the first frame so signal writes do not land during
    // the build phase.
    WidgetsBinding.instance.addPostFrameCallback((_) => _prepareAndStart());
  }

  Future<void> _prepareAndStart() async {
    if (!mounted) return;
    _ready.value = false;
    try {
      await _vm.prepare();
      if (!mounted) return;
      _ready.value = true;
      if (_vm.path.value != null) await _vm.start();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
      if (mounted) _ready.value = true;
    }
  }
}
