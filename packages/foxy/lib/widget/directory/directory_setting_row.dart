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
    description:
        '魔兽客户端根目录（含 Data 目录及其语言归档），用于从 MPQ 归档提取游戏图标。'
        '保存时自动检测 MPQ 归档所在位置。',
  ),
  serverDir(
    title: '服务端目录',
    description:
        '服务端根目录（如 AzerothCore）。保存时自动在其中搜索 DBC 文件所在目录，'
        '用于导入/导出 DBC 数据到 foxy 库。',
  );

  static const groupLabel = '目录设置';

  final String title;
  final String description;

  const DirectoryConfigTarget({required this.title, required this.description});

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

  Future<bool> save(
    BuildContext context,
    SetupStatusViewModel vm,
    String path,
  ) async {
    try {
      final saved = await (this == clientDir
          ? vm.saveClientDir(path)
          : vm.saveServerDir(path));
      if (!saved && context.mounted) {
        final error = errorOf(vm);
        if (error != null) DialogUtil.instance.error(error);
      }
      return saved;
    } catch (error) {
      if (context.mounted) {
        DialogUtil.instance.error('保存目录失败：${FoxyExceptions.message(error)}');
      }
      return false;
    }
  }
}

/// Directory-path input and browse form for setup wizard steps 1/2.
class DirectoryPathForm extends StatefulWidget {
  final SetupStatusViewModel vm;
  final DirectoryConfigTarget target;

  const DirectoryPathForm({super.key, required this.vm, required this.target});

  @override
  State<DirectoryPathForm> createState() => DirectoryPathFormState();
}

class DirectoryPathFormState extends State<DirectoryPathForm> {
  final controller = StringFieldController();
  bool _saving = false;

  DirectoryConfigTarget get target => widget.target;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 14,
      children: [
        SettingDialogShell.mutedHint(context, target.description),
        Text(
          '目录路径',
          style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
        ),
        SettingDialogShell.pathField(
          controller: controller,
          placeholder: '选择或输入${target.title}路径',
          onBrowse: _browse,
        ),
      ],
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

  /// Validates and saves the directory config, returning true on success.
  Future<bool> save() async {
    if (_saving) return false;
    _saving = true;
    try {
      return await target.save(context, widget.vm, controller.collect());
    } finally {
      _saving = false;
    }
  }

  Future<void> _browse() async {
    final dir = await getDirectoryPath();
    if (dir == null || !mounted) return;
    controller.init(dir);
  }
}

/// Directory-config item on the settings page: title + description +
/// current path + "Modify" button.
class DirectorySettingRow extends StatefulWidget {
  final SetupStatusViewModel vm;
  final DirectoryConfigTarget target;

  const DirectorySettingRow({
    super.key,
    required this.vm,
    required this.target,
  });

  @override
  State<DirectorySettingRow> createState() => _DirectorySettingRowState();
}

class _DirectorySettingRowState extends State<DirectorySettingRow> {
  bool _selecting = false;

  @override
  Widget build(BuildContext context) {
    final vm = widget.vm;
    final target = widget.target;
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
              onPressed: _selecting ? null : _selectDirectory,
              child: Text('浏览目录'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDirectory() async {
    if (_selecting) return;
    setState(() => _selecting = true);
    final vm = widget.vm;
    final target = widget.target;
    try {
      final path = await getDirectoryPath(
        initialDirectory: target.configuredOf(vm) ? target.pathOf(vm) : null,
      );
      if (path == null || !mounted) return;
      await target.save(context, vm, path);
    } catch (error) {
      if (mounted) {
        DialogUtil.instance.error('选择目录失败：${FoxyExceptions.message(error)}');
      }
    } finally {
      if (mounted) setState(() => _selecting = false);
    }
  }
}
