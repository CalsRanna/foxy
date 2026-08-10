import 'package:flutter/material.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class IconExtractDialog extends StatefulWidget {
  final IconExtractWorkflowViewModel vm;
  const IconExtractDialog({super.key, required this.vm});

  @override
  State<IconExtractDialog> createState() => _IconExtractDialogState();
}

class _IconExtractDialogState extends State<IconExtractDialog> {
  /// The ready flag uses a signal: Watch subscribes directly, avoiding a
  /// parent setState rebuilding the Watch and triggering signals_flutter's
  /// didUpdateWidget→recompute chain that would break the subscription.
  final _ready = signal(false);

  IconExtractWorkflowViewModel get _vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DialogUtil.width,
      child: Watch((_) {
        if (!_ready.value) {
          return SettingDialogShell(
            title: SettingDialogShell.titleRow(LucideIcons.image, '提取游戏图标'),
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
        final extracting =
            workflowStatus == WorkflowStatus.preparing ||
            workflowStatus == WorkflowStatus.running ||
            workflowStatus == WorkflowStatus.cancelling;
        final error = _vm.errorMessage.value;
        final success = workflowStatus == WorkflowStatus.succeeded;
        final theme = ShadTheme.of(context);

        if (success) {
          final result = _vm.result.value;
          return SettingDialogShell(
            title: SettingDialogShell.titleRow(
              LucideIcons.circleCheck,
              '提取完成',
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
                  '提取完成：成功 ${result?.extracted ?? 0} 个'
                  '${(result?.skipped ?? 0) > 0 ? '，跳过已存在 ${result!.skipped} 个' : ''}。'
                  '图标已缓存到应用数据目录，直接显示在列表页。',
              color: theme.colorScheme.primary,
              icon: LucideIcons.circleCheck,
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
              title: SettingDialogShell.titleRow(LucideIcons.image, '正在提取图标'),
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

        final path = _vm.path.value;
        final configured = path != null && path.trim().isNotEmpty;
        return SettingDialogShell(
          title: SettingDialogShell.titleRow(LucideIcons.image, '提取游戏图标'),
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
                children: [Icon(LucideIcons.play, size: 15), Text('开始提取')],
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
                '从配置的客户端目录的 Data\\<语言> 下 MPQ 归档提取全部图标'
                '（BLP 格式，约 6300 个），不内置在应用中。',
              ),
              Text(
                '客户端目录',
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (configured)
                SettingDialogShell.readonlyPath(context, path)
              else
                SettingDialogShell.mutedHint(
                  context,
                  '尚未配置客户端目录，请先前往设置页「目录设置」中配置。',
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
      }),
    );
  }

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
}
