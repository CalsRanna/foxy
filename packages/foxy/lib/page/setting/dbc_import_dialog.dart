import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
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
            return SettingDialogShell(
              title: SettingDialogShell.titleRow(
                LucideIcons.fileInput,
                '导入 DBC',
              ),
              child: const SizedBox(
                height: 120,
                child: Center(child: FoxyLoadingIndicator()),
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
              title: SettingDialogShell.titleRow(
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
              child: SettingDialogShell.banner(
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
            // Block Esc/back while a task is in flight: closing mid-run would
            // leave the import running in the background with no visible
            // state. Cancel (the only exit shown here) is in-dialog.
            return PopScope(
              canPop: false,
              child: SettingDialogShell(
                title: SettingDialogShell.titleRow(
                  LucideIcons.fileInput,
                  '正在导入 DBC',
                ),
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

          final path = _vm.path.value;
          final configured = path != null && path.trim().isNotEmpty;
          return SettingDialogShell(
            title: SettingDialogShell.titleRow(LucideIcons.fileInput, '导入 DBC'),
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
                SettingDialogShell.mutedHint(
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
                  SettingDialogShell.readonlyPath(context, path)
                else
                  SettingDialogShell.mutedHint(
                    context,
                    '尚未配置服务端 DBC 目录，请先前往设置页「目录设置」中配置。',
                  ),
                if (error != null)
                  SettingDialogShell.banner(
                    context,
                    text: error,
                    color: theme.colorScheme.destructive,
                    icon: LucideIcons.triangleAlert,
                  ),
              ],
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _prepare());
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
}
