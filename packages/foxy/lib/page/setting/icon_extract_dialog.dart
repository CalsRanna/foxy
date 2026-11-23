import 'package:flutter/material.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class IconExtractDialog extends StatefulWidget {
  final IconExtractWorkflowViewModel vm;
  const IconExtractDialog({super.key, required this.vm});

  @override
  State<IconExtractDialog> createState() => _IconExtractDialogState();
}

class _IconExtractDialogState extends State<IconExtractDialog> {
  /// The ready flag uses a signal: SignalBuilder subscribes directly, avoiding a
  /// parent setState rebuilding the SignalBuilder and triggering signals_flutter's
  /// didUpdateWidget→recompute chain that would break the subscription.
  final _ready = signal(false);

  IconExtractWorkflowViewModel get _vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DialogUtil.width,
      child: SignalBuilder(
        builder: (_) {
          if (!_ready.value) {
            return SettingDialogShell(
              title: '正在提取图标',
              child: const SizedBox(
                height: 120,
                child: Center(child: FoxyLoadingIndicator()),
              ),
            );
          }

          final workflowStatus = _vm.status.value;
          final extracting =
              workflowStatus == WorkflowStatus.preparing ||
              workflowStatus == WorkflowStatus.running ||
              workflowStatus == WorkflowStatus.cancelling;
          final success = workflowStatus == WorkflowStatus.succeeded;

          if (success) {
            final result = _vm.result.value;
            return SettingDialogShell(
              title: '提取完成',
              actions: [
                ShadButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('确定'),
                ),
              ],
              child: SelectableText(
                '提取完成：成功 ${result?.extracted ?? 0} 个'
                '${(result?.skipped ?? 0) > 0 ? '，跳过已存在 ${result!.skipped} 个' : ''}。'
                '图标已缓存到应用数据目录，直接显示在列表页。',
              ),
            );
          }

          if (extracting) {
            // Block Esc/back while a task is in flight: closing mid-run would
            // leave the extraction running in the background with no visible
            // state. Cancel (the only exit shown here) is in-dialog.
            return PopScope(
              canPop: false,
              child: SettingDialogShell(
                title: '正在提取图标',
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
                          : '取消提取',
                    ),
                  ),
                ),
              ),
            );
          }

          if (workflowStatus == WorkflowStatus.failed) {
            return DialogUtil.errorDialog(
              context,
              _vm.errorMessage.value ?? '图标提取失败。',
              onRetry: _prepareAndStart,
            );
          }

          return SettingDialogShell(
            title: '未配置客户端目录',
            actions: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('取消'),
              ),
            ],
            child: SettingDialogShell.mutedHint(context, '请先在「目录设置」中配置客户端目录。'),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Prepare outside the build phase; see DbcExportDialog.initState.
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
