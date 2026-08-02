/// 更新对话框:随 [UpdateViewModel] 状态实时展示。
///
/// 状态流转:检查中 → 发现新版本(可下载)→ 下载中(可取消)→ 已就绪
/// (重启完成更新);检查失败 / 已是最新独立成态。对话框不主动发起检查,
/// 由调用方先触发 `checkManually` / `checkSilently` 再打开本对话框。
library;

import 'package:flutter/material.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class UpdateDialog extends StatefulWidget {
  final UpdateViewModel vm;
  const UpdateDialog({super.key, required this.vm});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  /// 当前版本展示用 signal：Watch 直接订阅,避免父级 setState 重建 Watch
  /// 触发 signals_flutter 的 didUpdateWidget→recompute 链路破坏订阅。
  final _currentVersion = signal<String?>(null);

  UpdateViewModel get _vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kFoxyDialogMaxWidth,
      child: Watch((_) {
        final vm = _vm;
        final checking = vm.checking.value;
        final update = vm.availableUpdate.value;
        final downloading = vm.downloadProgress.value != null;
        final readyToRestart = vm.readyToRestart.value;
        final error = vm.errorMessage.value;
        final upToDate = vm.upToDate.value;
        final theme = ShadTheme.of(context);

        if (checking) {
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.refreshCw, '检查更新'),
            child: SizedBox(
              height: 120,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const Text('正在检查更新…', style: TextStyle(fontSize: 13)),
                    if (_currentVersion.value != null)
                      Text(
                        '当前版本 ${_currentVersion.value}',
                        style: theme.textTheme.muted.copyWith(fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
          );
        }

        if (downloading) {
          final progress = vm.downloadProgress.value ?? 0;
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.download, '正在下载更新'),
            child: settingDialogProgressPanel(
              context,
              ratio: progress,
              label: '正在下载 Foxy ${update?.version ?? ''}',
              detail: '下载完成后需要重启应用以完成更新',
              trailing: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: vm.cancelDownload,
                child: const Text('取消下载'),
              ),
            ),
          );
        }

        if (readyToRestart) {
          return SettingDialogShell(
            title: settingDialogTitleRow(
              LucideIcons.circleCheck,
              '更新已就绪',
              iconColor: theme.colorScheme.primary,
            ),
            actions: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('稍后'),
              ),
              ShadButton(
                onPressed: _confirmRestart,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    Icon(LucideIcons.refreshCw, size: 15),
                    Text('立即重启'),
                  ],
                ),
              ),
            ],
            child: settingDialogBanner(
              context,
              text:
                  '新版本 ${update?.version ?? ''} 已下载并校验完毕。'
                  '点击「立即重启」将关闭 Foxy 并自动完成更新，重启后即为新版本。',
              color: theme.colorScheme.primary,
              icon: LucideIcons.circleCheck,
            ),
          );
        }

        if (update != null) {
          return SettingDialogShell(
            title: settingDialogTitleRow(
              LucideIcons.sparkles,
              '发现新版本 ${update.version}',
              iconColor: theme.colorScheme.primary,
            ),
            actions: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('稍后再说'),
              ),
              ShadButton(
                onPressed: error == null ? _download : null,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    Icon(LucideIcons.download, size: 15),
                    Text('下载并更新'),
                  ],
                ),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                settingDialogMutedHint(
                  context,
                  '当前版本 ${_currentVersion.value ?? '未知'} → '
                  '新版本 ${update.version}（${update.buildNumber}）',
                ),
                _ReleaseNotes(notes: update.notes),
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
        }

        if (error != null) {
          return SettingDialogShell(
            title: settingDialogTitleRow(LucideIcons.triangleAlert, '检查更新失败'),
            actions: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('关闭'),
              ),
              ShadButton(
                onPressed: _retry,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    Icon(LucideIcons.rotateCw, size: 15),
                    Text('重试'),
                  ],
                ),
              ),
            ],
            child: settingDialogBanner(
              context,
              text: error,
              color: theme.colorScheme.destructive,
              icon: LucideIcons.triangleAlert,
            ),
          );
        }

        if (upToDate) {
          return SettingDialogShell(
            title: settingDialogTitleRow(
              LucideIcons.circleCheck,
              '已是最新版本',
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
              text: '当前已是最新版本，无需更新。',
              color: theme.colorScheme.primary,
              icon: LucideIcons.circleCheck,
            ),
          );
        }

        // 兜底：理论不可达（检查尚未触发或状态被重置）。
        return SettingDialogShell(
          title: settingDialogTitleRow(LucideIcons.refreshCw, '检查更新'),
          child: const SizedBox(height: 120),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentVersion();
  }

  Future<void> _loadCurrentVersion() async {
    final version = _vm.currentVersion.value;
    if (version != null) {
      _currentVersion.value = version;
      return;
    }
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      _currentVersion.value = '${info.version}+${info.buildNumber}';
    } catch (_) {
      // 展示层拿不到版本号时仅省略「当前版本」行。
    }
  }

  Future<void> _download() async {
    try {
      await _vm.downloadAndPrepare();
    } catch (_) {
      // 失败经 errorMessage 信号反馈。
    }
  }

  Future<void> _retry() async {
    try {
      await _vm.checkManually();
    } catch (_) {
      // 失败经 errorMessage 信号反馈。
    }
  }

  Future<void> _confirmRestart() async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '重启完成更新',
      description: '更新会关闭并重启 Foxy，请先保存正在编辑的内容。',
      confirmText: '立即重启',
    );
    if (!confirmed || !mounted) return;
    await _vm.restartToApply();
  }
}

/// 更新说明展示块:固定高度区域内滚动。
class _ReleaseNotes extends StatelessWidget {
  final String notes;

  const _ReleaseNotes({required this.notes});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: SingleChildScrollView(
        child: SelectableText(
          notes.isEmpty ? '（本次更新没有说明）' : notes,
          style: const TextStyle(fontSize: 13, height: 1.5),
        ),
      ),
    );
  }
}
