import 'package:flutter/material.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:foxy/widget/directory/directory_setting_row.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// First-setup wizard for optional game directories and their data tasks.
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
  final _saving = signal(false);
  var _clientSkipped = false;

  final _step1FormKey = GlobalKey<DirectoryPathFormState>();

  final _step2FormKey = GlobalKey<DirectoryPathFormState>();

  String? get _dbcImportPath =>
      _setupVm.isServerDirConfigured && !_setupVm.serverSetupSkipped.value
      ? _setupVm.dbcPath.value
      : null;

  String? get _iconExtractPath =>
      _setupVm.isClientDirConfigured &&
          !_clientSkipped &&
          !_setupVm.iconsExtracted.value
      ? _setupVm.clientDir.value
      : null;

  IconExtractWorkflowViewModel get _iconVm => widget.iconVm;
  DbcImportWorkflowViewModel get _importVm => widget.importVm;
  SetupStatusViewModel get _setupVm => widget.setupVm;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: DialogUtil.width,
        child: SignalBuilder(
          builder: (_) {
            if (!_checked.value) {
              return SettingDialogShell(
                title: '首次设置',
                child: const SizedBox(
                  height: 140,
                  child: Center(child: FoxyLoadingIndicator()),
                ),
              );
            }
            return SettingDialogShell(
              title: '首次设置引导',
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
          },
        ),
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
    if (step == 2) {
      return [
        ShadButton(
          onPressed: _saving.value ? null : _enterApp,
          child: const Text('进入应用'),
        ),
      ];
    }
    if (_saving.value) return const [];
    if (step == 0) {
      return [
        ShadButton.outline(
          onPressed: () => _saveAndAdvance(0, skip: true),
          child: const Text('跳过'),
        ),
        ShadButton(
          onPressed: () => _saveAndAdvance(0),
          child: const Text('下一步'),
        ),
      ];
    }
    return [
      ShadButton.outline(
        onPressed: () => _step.value = 0,
        child: const Text('上一步'),
      ),
      ShadButton.outline(
        onPressed: () => _saveAndAdvance(1, skip: true),
        child: const Text('跳过'),
      ),
      ShadButton(onPressed: () => _saveAndAdvance(1), child: const Text('下一步')),
    ];
  }

  Widget _buildDirectoryStep(int stepIndex) {
    final target = stepIndex == 0
        ? DirectoryConfigTarget.clientDir
        : DirectoryConfigTarget.serverDir;
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

  Widget _buildStep3() {
    final importsDbc = _dbcImportPath != null;
    final extractsIcons = _iconExtractPath != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        const Text(
          '第 3 步：完成设置',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        if (importsDbc)
          SettingDialogShell.mutedHint(
            context,
            '将检查并按需导入 DBC 数据。导入会覆盖 Foxy 数据库中的对应表。',
          ),
        if (extractsIcons)
          SettingDialogShell.mutedHint(context, '将从客户端目录提取游戏图标。'),
        if (!importsDbc && !extractsIcons)
          SettingDialogShell.mutedHint(context, '可随时在设置中配置目录并准备游戏数据。'),
      ],
    );
  }

  Widget _buildStepIndicator() {
    final theme = ShadTheme.of(context);
    final labels = ['客户端目录', '服务端目录', '完成设置'];
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

  /// Loads the config, determines each step's completion, and locates the
  /// first incomplete step.
  Future<void> _check() async {
    try {
      await _setupVm.prepare();
    } catch (_) {
      // A config read failure counts as unconfigured; the wizard starts
      // from the beginning.
    }
    if (!mounted) return;
    _clientSkipped = _setupVm.clientSetupSkipped.value;
    if (!_setupVm.isClientDirConfigured && !_clientSkipped) {
      _step.value = 0;
    } else if (!_setupVm.isServerSetupComplete) {
      _step.value = 1;
    } else {
      _step.value = 2;
    }
    _checked.value = true;
  }

  bool _isStepDone(int index) => switch (index) {
    0 => _setupVm.isClientDirConfigured || _setupVm.clientSetupSkipped.value,
    1 => _setupVm.isServerSetupComplete,
    _ => false,
  };

  Future<void> _saveAndAdvance(int stepIndex, {bool skip = false}) async {
    if (_saving.value) return;
    _saving.value = true;
    try {
      if (skip) {
        await _saveSkip(
          stepIndex == 0 ? _setupVm.skipClientSetup : _setupVm.skipServerSetup,
        );
      } else {
        final formKey = stepIndex == 0 ? _step1FormKey : _step2FormKey;
        if (await formKey.currentState?.save() != true) return;
      }
      if (!mounted) return;
      if (stepIndex == 0) _clientSkipped = skip;
      _step.value = stepIndex + 1;
    } finally {
      _saving.value = false;
    }
  }

  Future<void> _saveSkip(Future<void> Function() save) async {
    try {
      await save();
    } catch (_) {
      // The in-memory choice still applies if the config is read-only.
    }
  }

  Future<void> _enterApp() async {
    if (_saving.value) return;
    _saving.value = true;
    try {
      final dbcPath = _dbcImportPath;
      final clientDir = _iconExtractPath;
      if (dbcPath != null || clientDir != null) {
        await _prepareGameData(dbcPath, clientDir);
      }
      if (mounted) Navigator.of(context).pop();
    } finally {
      _saving.value = false;
    }
  }

  Future<void> _prepareGameData(String? dbcPath, String? clientDir) async {
    final task = signal(
      dbcPath != null ? _SetupTask.checkDbc : _SetupTask.extractIcons,
    );
    final navigator = Navigator.of(context, rootNavigator: true);
    final progressDialog = DialogUtil.show<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _buildProgressDialog(task),
    );
    final errors = <String>[];
    try {
      if (dbcPath != null) {
        await _importVm.checkTables();
        if (mounted &&
            _importVm.errorMessage.value == null &&
            !_importVm.tablesReady) {
          task.value = _SetupTask.importDbc;
          _importVm.setPath(dbcPath);
          try {
            await _importVm.start();
          } catch (_) {
            // The workflow exposes the failure through errorMessage.
          }
        }
        if (_importVm.errorMessage.value case final message?) {
          errors.add(message);
        }
      }
      if (mounted && clientDir != null) {
        task.value = _SetupTask.extractIcons;
        _iconVm.setPath(clientDir);
        try {
          await _iconVm.start();
        } catch (_) {
          // The workflow exposes the failure through errorMessage.
        }
        if (_iconVm.errorMessage.value case final message?) {
          errors.add(message);
        }
      }
    } finally {
      if (navigator.mounted) navigator.pop();
      await progressDialog;
    }
    if (mounted && errors.isNotEmpty) {
      await DialogUtil.show<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => DialogUtil.errorDialog(
          context,
          '${errors.join('\n\n')}\n\n进入应用后可在设置中重试。',
        ),
      );
    }
  }

  Widget _buildProgressDialog(Signal<_SetupTask> task) {
    return PopScope(
      canPop: false,
      child: SignalBuilder(
        builder: (context) {
          if (task.value == _SetupTask.checkDbc) {
            return const SettingDialogShell(
              title: '正在检查 DBC 数据',
              child: SizedBox(
                height: 120,
                child: Center(child: FoxyLoadingIndicator()),
              ),
            );
          }
          final importing = task.value == _SetupTask.importDbc;
          final status = importing
              ? _importVm.status.value
              : _iconVm.status.value;
          final cancelling = status == WorkflowStatus.cancelling;
          return SettingDialogShell(
            title: importing ? '正在导入 DBC' : '正在提取图标',
            child: SettingDialogShell.progressPanel(
              context,
              ratio: importing
                  ? _importVm.progress.value
                  : _iconVm.progress.value,
              label: importing
                  ? _importVm.progressLabel.value
                  : _iconVm.progressLabel.value,
              detail: importing
                  ? _importVm.progressDetail.value
                  : _iconVm.progressDetail.value,
              trailing: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: cancelling
                    ? null
                    : importing
                    ? _importVm.cancel
                    : _iconVm.cancel,
                child: Text(
                  cancelling
                      ? '正在取消…'
                      : importing
                      ? '取消导入'
                      : '取消提取',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum _SetupTask { checkDbc, importDbc, extractIcons }

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
