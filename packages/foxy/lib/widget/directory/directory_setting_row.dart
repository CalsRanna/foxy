import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Directory-config targets: client directory / server directory.
///
/// Centralizes the mapping of both config items to
/// [SetupStatusViewModel] (path/completeness/error/save), shared by the
/// settings-page config rows and setup-wizard steps 1/2.
enum DirectoryConfigTarget {
  clientDir(
    title: '客户端目录',
    icon: LucideIcons.folderCog,
    description:
        '魔兽客户端根目录（含 Data 目录及其语言归档），用于从 MPQ 归档提取游戏图标。'
        '保存时自动检测 MPQ 归档所在位置。',
  ),
  serverDir(
    title: '服务端目录',
    icon: LucideIcons.hardDrive,
    description:
        '服务端根目录（如 AzerothCore）。保存时自动在其中搜索 DBC 文件所在目录，'
        '用于导入/导出 DBC 数据到 foxy 库。',
  );

  final String title;
  final IconData icon;
  final String description;

  const DirectoryConfigTarget({
    required this.title,
    required this.icon,
    required this.description,
  });

  void clearError(SetupStatusViewModel vm) {
    if (this == clientDir) {
      vm.clientDirError.value = null;
    } else {
      vm.serverDirError.value = null;
    }
  }

  bool configuredOf(SetupStatusViewModel vm) =>
      this == clientDir ? vm.isClientDirConfigured : vm.isServerDirConfigured;

  String? errorOf(SetupStatusViewModel vm) =>
      this == clientDir ? vm.clientDirError.value : vm.serverDirError.value;

  String? pathOf(SetupStatusViewModel vm) =>
      this == clientDir ? vm.clientDir.value : vm.serverDir.value;

  Future<bool> save(SetupStatusViewModel vm, String path) =>
      this == clientDir ? vm.saveClientDir(path) : vm.saveServerDir(path);
}

/// Config dialog for a single directory: based on [DirectoryPathForm],
/// with "Cancel / Save".
class DirectoryPathConfigDialog extends StatefulWidget {
  final SetupStatusViewModel vm;
  final DirectoryConfigTarget target;

  const DirectoryPathConfigDialog({
    super.key,
    required this.vm,
    required this.target,
  });

  @override
  State<DirectoryPathConfigDialog> createState() =>
      _DirectoryPathConfigDialogState();
}

/// Inline directory-path form: path input/browse plus an
/// existence-validation error banner.
///
/// Reused by the directory-config dialog and wizard steps 1/2; saving goes
/// through [SetupStatusViewModel]'s validation and persistence, with errors
/// surfaced via the target's error signal.
class DirectoryPathForm extends StatefulWidget {
  final SetupStatusViewModel vm;
  final DirectoryConfigTarget target;

  const DirectoryPathForm({super.key, required this.vm, required this.target});

  @override
  State<DirectoryPathForm> createState() => DirectoryPathFormState();
}

class DirectoryPathFormState extends State<DirectoryPathForm> {
  final controller = StringFieldController();

  DirectoryConfigTarget get target => widget.target;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return SignalBuilder(
      builder: (_) {
        final error = target.errorOf(widget.vm);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 14,
          children: [
            SettingDialogShell.mutedHint(context, target.description),
            Text(
              '目录路径',
              style: theme.textTheme.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SettingDialogShell.pathField(
              controller: controller,
              placeholder: '选择或输入${target.title}路径',
              onBrowse: _browse,
            ),
            if (error != null)
              SettingDialogShell.banner(
                context,
                text: error,
                color: theme.colorScheme.destructive,
                icon: LucideIcons.triangleAlert,
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Clear the previous validation error so none lingers on reopen.
    target.clearError(widget.vm);
    final path = target.pathOf(widget.vm);
    if (path != null) controller.init(path);
  }

  /// Validates and saves the directory config; returns true on success,
  /// errors show in the banner.
  Future<bool> save() => target.save(widget.vm, controller.collect());

  Future<void> _browse() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    controller.init(dir);
  }
}

/// Directory-config item on the settings page: title + description +
/// current path + "Modify" button.
class DirectorySettingRow extends StatelessWidget {
  final SetupStatusViewModel vm;
  final DirectoryConfigTarget target;

  const DirectorySettingRow({
    super.key,
    required this.vm,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    final detailStyle = theme.textTheme.muted.copyWith(
      color: colors.mutedForeground,
      fontSize: 13,
    );
    return SignalBuilder(
      builder: (_) {
        final path = target.pathOf(vm);
        final configured = target.configuredOf(vm);
        final missing = path != null && !configured;
        return Row(
          spacing: 16,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    target.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (path == null)
                    Text(
                      target == DirectoryConfigTarget.clientDir
                          ? '尚未配置 · 用于提取图标和导出 MPQ 补丁'
                          : '尚未配置 · 用于导入和导出 DBC 文件',
                      style: detailStyle,
                    )
                  else
                    Text(
                      path,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: detailStyle,
                    ),
                  if (missing)
                    Text(
                      '目录不存在，请重新设置。',
                      style: detailStyle.copyWith(color: colors.destructive),
                    ),
                ],
              ),
            ),
            ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: () => DialogUtil.show(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    DirectoryPathConfigDialog(vm: vm, target: target),
              ),
              child: Text(path == null ? '配置目录' : '修改目录'),
            ),
          ],
        );
      },
    );
  }
}

class _DirectoryPathConfigDialogState extends State<DirectoryPathConfigDialog> {
  final _formKey = GlobalKey<DirectoryPathFormState>();

  @override
  Widget build(BuildContext context) {
    return SettingDialogShell(
      title: SettingDialogShell.titleRow(
        widget.target.icon,
        '设置${widget.target.title}',
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('取消'),
        ),
        ShadButton(onPressed: _save, child: const Text('保存')),
      ],
      child: DirectoryPathForm(
        key: _formKey,
        vm: widget.vm,
        target: widget.target,
      ),
    );
  }

  Future<void> _save() async {
    final saved = await _formKey.currentState?.save() ?? false;
    if (saved && mounted) Navigator.of(context).maybePop();
  }
}
