import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/setting/dbc_sync_dialogs.dart';
import 'package:foxy/page/setting/icon_extract_workflow_view_model.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

const _kDialogWidth = 640.0;

class IconExtractDialog extends StatefulWidget {
  final IconExtractWorkflowViewModel vm;
  const IconExtractDialog({super.key, required this.vm});

  @override
  State<IconExtractDialog> createState() => _IconExtractDialogState();
}

class _IconExtractDialogState extends State<IconExtractDialog> {
  IconExtractWorkflowViewModel get _vm => widget.vm;
  final _pathController = StringFieldController();

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
    final path = _vm.path.value;
    if (path != null) _pathController.init(path);
    _ready.value = true;
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  Future<void> _browse() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    _pathController.init(dir);
    _vm.setPath(dir);
  }

  Future<void> _start() async {
    _vm.setPath(_pathController.collect());
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
            title: settingDialogTitleRow(LucideIcons.image, '提取游戏图标'),
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
            title: settingDialogTitleRow(
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
            child: settingDialogBanner(
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
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.image, '正在提取图标'),
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
                      : '取消提取',
                ),
              ),
            ),
          );
        }

        return SettingDialogShell(
          title: settingDialogTitleRow(LucideIcons.image, '提取游戏图标'),
          actions: [
            ShadButton.outline(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('关闭'),
            ),
            ShadButton(
              onPressed:
                  (_vm.path.value == null || _vm.path.value!.trim().isEmpty)
                  ? null
                  : _start,
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
              settingDialogMutedHint(
                context,
                '选择魔兽客户端根目录（含 Data 目录，如 D:\\World of Warcraft）。'
                'foxy 将从 Data\\<语言> 下的 MPQ 归档提取全部图标（BLP 格式，'
                '约 6300 个），不内置在应用中。',
              ),
              Text(
                '客户端目录',
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              settingDialogPathField(
                controller: _pathController,
                placeholder: '选择或输入客户端目录路径',
                onBrowse: _browse,
                onChanged: (value) {
                  _vm.setPath(value);
                },
                onSubmitted: (_) => _start(),
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
