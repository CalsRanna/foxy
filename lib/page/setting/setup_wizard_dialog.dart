import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foxy/page/setting/directory_setting_row.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

const _kWizardWidth = 640.0;

/// 首次设置引导：不可关闭的三步向导。
///
/// 步骤 1/2 配置两个目录（客户端目录、服务端 DBC 目录），步骤 3 顺序执行
/// DBC 导入与图标提取。打开时按完成度跳过已完成步骤，全部完成前对话框
/// 不可关闭（遮罩、关闭按钮、Esc 均无效），唯一出口是「进入应用」。
class SetupWizardDialog extends StatefulWidget {
  final SetupStatusViewModel setupVm;
  final DbcImportWorkflowViewModel importVm;
  final IconExtractWorkflowViewModel iconVm;

  const SetupWizardDialog({
    super.key,
    required this.setupVm,
    required this.importVm,
    required this.iconVm,
  });

  @override
  State<SetupWizardDialog> createState() => _SetupWizardDialogState();
}

class _SetupWizardDialogState extends State<SetupWizardDialog> {
  final _step = signal(0);
  final _checked = signal(false);

  /// 打开时 checkTables 的快照结果；步骤 3 的实时状态直接读工作流 VM。
  bool _importDoneAtCheck = false;

  final _step1FormKey = GlobalKey<DirectoryPathFormState>();

  final _step2FormKey = GlobalKey<DirectoryPathFormState>();
  IconExtractWorkflowViewModel get _iconVm => widget.iconVm;

  /// 导入子任务是否已完成：库内表已就绪（快照）或本次会话导入成功。
  bool get _importCompleted =>
      _importDoneAtCheck ||
      _importVm.status.value == WorkflowStatus.succeeded;
  DbcImportWorkflowViewModel get _importVm => widget.importVm;
  SetupStatusViewModel get _setupVm => widget.setupVm;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: _kWizardWidth,
        child: Watch((_) {
          if (!_checked.value) {
            return SettingDialogShell(
              title: settingDialogTitleRow(LucideIcons.wandSparkles, '首次设置'),
              child: const SizedBox(
                height: 140,
                child: Center(
                  child: SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            );
          }
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.wandSparkles, '首次设置引导'),
            actions: _buildActions(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 18,
              children: [
                _buildStepIndicator(),
                switch (_step.value) {
                  0 => _buildDirectoryStep(0),
                  1 => _buildDirectoryStep(1),
                  _ => _buildStep3(),
                },
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  List<Widget> _buildActions() {
    final step = _step.value;
    final importStatus = _importVm.status.value;
    final iconStatus = _iconVm.status.value;
    final importRunning = _isActive(importStatus);
    final iconRunning = _isActive(iconStatus);

    if (step == 0) {
      return [
        ShadButton(
          onPressed: () => _saveAndAdvance(0),
          child: const Text('下一步'),
        ),
      ];
    }
    if (step == 1) {
      return [
        ShadButton.outline(
          onPressed: () => _step.value = 0,
          child: const Text('上一步'),
        ),
        ShadButton(
          onPressed: () => _saveAndAdvance(1),
          child: const Text('下一步'),
        ),
      ];
    }
    // 步骤 3：任务运行中只展示取消按钮，不允许上一步/退出。
    if (importRunning || iconRunning) return const [];
    if (_importCompleted && iconStatus == WorkflowStatus.succeeded) {
      return [
        ShadButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('进入应用'),
        ),
      ];
    }
    if (importStatus == WorkflowStatus.failed) {
      return [
        ShadButton.outline(
          onPressed: _retryImport,
          child: const Text('重试'),
        ),
        ShadButton.destructive(
          onPressed: _exitApp,
          child: const Text('退出应用'),
        ),
      ];
    }
    if (iconStatus == WorkflowStatus.failed) {
      return [
        ShadButton.outline(
          onPressed: _retryIconExtract,
          child: const Text('重试'),
        ),
        ShadButton.destructive(
          onPressed: _exitApp,
          child: const Text('退出应用'),
        ),
      ];
    }
    return [
      ShadButton.outline(
        onPressed: () => _step.value = 1,
        child: const Text('上一步'),
      ),
      ShadButton(
        onPressed: _startImport,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [Icon(LucideIcons.play, size: 15), Text('开始导入')],
        ),
      ),
    ];
  }

  Widget _buildDirectoryStep(int stepIndex) {
    final target =
        stepIndex == 0
            ? DirectoryConfigTarget.clientDir
            : DirectoryConfigTarget.dbcPath;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Text(
          '第 ${stepIndex + 1} 步：设置${target.title}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        DirectoryPathForm(
          key: stepIndex == 0 ? _step1FormKey : _step2FormKey,
          vm: _setupVm,
          target: target,
        ),
      ],
    );
  }

  Widget _buildIconCard(WorkflowStatus status, bool iconSucceeded) {
    final theme = ShadTheme.of(context);
    final clientDir = _setupVm.clientDir.value;
    final running = _isActive(status);
    final failed = status == WorkflowStatus.failed;
    final error = _iconVm.errorMessage.value;
    final cancelling = status == WorkflowStatus.cancelling;

    return _buildSubtaskCard(
      icon: LucideIcons.image,
      title: '提取游戏图标',
      child: switch ((running, iconSucceeded, failed)) {
        (true, _, _) => settingDialogProgressPanel(
            context,
            ratio: _iconVm.progress.value,
            label: _iconVm.progressLabel.value,
            detail: _iconVm.progressDetail.value,
            trailing: ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: cancelling ? null : _iconVm.cancel,
              child: Text(cancelling ? '正在取消…' : '取消提取'),
            ),
          ),
        (_, true, _) => settingDialogBanner(
            context,
            text: '提取完成：图标已缓存到应用数据目录，直接显示在列表页。',
            color: theme.colorScheme.primary,
            icon: LucideIcons.circleCheck,
          ),
        (_, _, true) => settingDialogBanner(
            context,
            text: error ?? '提取失败',
            color: theme.colorScheme.destructive,
            icon: LucideIcons.triangleAlert,
          ),
        _ => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              settingDialogMutedHint(
                context,
                _importCompleted
                    ? '自动开始提取图标（约 6300 个，BLP 原始格式），完成后显示在列表页。'
                    : '导入完成后自动开始提取图标。',
              ),
              if (clientDir != null)
                settingDialogMutedHint(context, '客户端目录：$clientDir'),
            ],
          ),
      },
    );
  }

  Widget _buildImportCard(WorkflowStatus status) {
    final theme = ShadTheme.of(context);
    final dbcPath = _setupVm.dbcPath.value;
    final running = _isActive(status);
    final failed = status == WorkflowStatus.failed;
    final error = _importVm.errorMessage.value;
    final cancelling = status == WorkflowStatus.cancelling;

    return _buildSubtaskCard(
      icon: LucideIcons.fileInput,
      title: '导入 DBC 数据',
      child: switch ((running, _importCompleted, failed)) {
        (true, _, _) => settingDialogProgressPanel(
            context,
            ratio: _importVm.progress.value,
            label: _importVm.progressLabel.value,
            detail: _importVm.progressDetail.value,
            trailing: ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: cancelling ? null : _importVm.cancel,
              child: Text(cancelling ? '正在取消…' : '取消导入'),
            ),
          ),
        (_, true, _) => settingDialogBanner(
            context,
            text:
                '导入完成：写入 ${_importVm.result.value?.completed ?? 0} 个文件'
                '${(_importVm.result.value?.skipped ?? 0) > 0 ? '，跳过 ${_importVm.result.value!.skipped} 个' : ''}。',
            color: theme.colorScheme.primary,
            icon: LucideIcons.circleCheck,
          ),
        (_, _, true) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              settingDialogBanner(
                context,
                text: error ?? '导入失败',
                color: theme.colorScheme.destructive,
                icon: LucideIcons.triangleAlert,
              ),
              settingDialogMutedHint(
                context,
                '导入以 DBC 为准，将覆盖 foxy 库中对应表的数据。可重试。',
              ),
            ],
          ),
        _ => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              settingDialogMutedHint(
                context,
                '导入以 DBC 为准：将覆盖 foxy 库中对应表的数据；若需保留库内数据请先自行备份。',
              ),
              if (dbcPath != null)
                settingDialogMutedHint(context, '服务端 DBC 目录：$dbcPath'),
            ],
          ),
      },
    );
  }

  Widget _buildStep3() {
    final importStatus = _importVm.status.value;
    final iconStatus = _iconVm.status.value;
    final iconSucceeded = iconStatus == WorkflowStatus.succeeded;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        Text(
          '第 3 步：导入 DBC 数据并提取游戏图标',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        _buildImportCard(importStatus),
        _buildIconCard(iconStatus, iconSucceeded),
      ],
    );
  }

  Widget _buildStepIndicator() {
    final theme = ShadTheme.of(context);
    final labels = ['客户端目录', '服务端 DBC 目录', '导入与提取'];
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++) ...[
          if (i > 0)
            Expanded(
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: theme.colorScheme.border,
              ),
            ),
          _StepChip(
            index: i,
            label: labels[i],
            done: _isStepDone(i),
            active: _step.value == i,
          ),
        ],
      ],
    );
  }

  Widget _buildSubtaskCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 8,
            children: [
              Icon(icon, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.75)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          child,
        ],
      ),
    );
  }

  /// 加载配置并判定各步骤完成度，定位到第一个未完成步骤。
  Future<void> _check() async {
    try {
      await _setupVm.prepare();
    } catch (_) {
      // 配置读取失败按未配置处理，引导从头开始。
    }
    await _importVm.checkTables();
    if (!mounted) return;
    _importDoneAtCheck = _importVm.tablesReady;
    _step.value = !_setupVm.isClientDirConfigured
        ? 0
        : !_setupVm.isDbcPathConfigured
        ? 1
        : 2;
    _checked.value = true;
    // 目录已就绪且 DBC 已导入、仅缺图标 → 直接衔接提取。
    if (_step.value == 2 && _importDoneAtCheck) {
      await _startIconExtract();
    }
  }

  void _exitApp() => exit(0);

  bool _isStepDone(int index) => switch (index) {
        0 => _setupVm.isClientDirConfigured,
        1 => _setupVm.isDbcPathConfigured,
        _ => _importCompleted && _iconVm.status.value == WorkflowStatus.succeeded,
      };

  Future<void> _retryIconExtract() async {
    try {
      await _iconVm.retry();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
  }

  Future<void> _retryImport() async {
    try {
      await _importVm.retry();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
    if (!mounted) return;
    if (_importVm.status.value == WorkflowStatus.succeeded) {
      await _startIconExtract();
    }
  }

  Future<void> _saveAndAdvance(int stepIndex) async {
    final formKey = stepIndex == 0 ? _step1FormKey : _step2FormKey;
    final saved = await formKey.currentState?.save() ?? false;
    if (!saved || !mounted) return;
    _step.value = stepIndex + 1;
  }

  Future<void> _startIconExtract() async {
    final path = _setupVm.clientDir.value;
    if (path == null || _iconVm.isRunning) return;
    _iconVm.setPath(path);
    try {
      await _iconVm.start();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
  }

  Future<void> _startImport() async {
    final path = _setupVm.dbcPath.value;
    if (path == null || _importVm.isRunning) return;
    _importVm.setPath(path);
    try {
      await _importVm.start();
    } catch (_) {
      // The workflow exposes the failure through errorMessage.
    }
    if (!mounted) return;
    if (_importVm.status.value == WorkflowStatus.succeeded) {
      await _startIconExtract();
    }
  }

  static bool _isActive(WorkflowStatus status) =>
      status == WorkflowStatus.preparing ||
      status == WorkflowStatus.running ||
      status == WorkflowStatus.cancelling;
}

class _StepChip extends StatelessWidget {
  final int index;
  final String label;
  final bool done;
  final bool active;

  const _StepChip({
    required this.index,
    required this.label,
    required this.done,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final Color badgeColor;
    final Color? badgeForeground;
    if (done) {
      badgeColor = colorScheme.primary;
      badgeForeground = colorScheme.onPrimary;
    } else if (active) {
      badgeColor = colorScheme.primary.withValues(alpha: 0.15);
      badgeForeground = colorScheme.primary;
    } else {
      badgeColor = colorScheme.surfaceContainerHighest;
      badgeForeground = colorScheme.onSurface.withValues(alpha: 0.55);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: done
              ? Icon(LucideIcons.check, size: 14, color: badgeForeground)
              : Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: badgeForeground,
                  ),
                ),
        ),
        Text(
          label,
          style: theme.textTheme.muted.copyWith(
            fontSize: 12,
            color: active
                ? colorScheme.onSurface
                : colorScheme.onSurface.withValues(alpha: 0.55),
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
