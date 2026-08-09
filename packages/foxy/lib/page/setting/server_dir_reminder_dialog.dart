import 'package:flutter/material.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Startup reminder shown when the server directory is not configured
/// (e.g. an existing installation upgraded before `server_dir`/`dbc_dir`
/// existed).
///
/// Guides the user to the settings page's directory section, where picking
/// the server root auto-detects the DBC directory. A lighter alternative to
/// the first-setup wizard, which keeps covering brand-new installations.
class ServerDirReminderDialog extends StatelessWidget {
  const ServerDirReminderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return SettingDialogShell(
      title: settingDialogTitleRow(LucideIcons.hardDrive, '未配置服务端目录'),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('稍后提醒'),
        ),
        ShadButton(
          onPressed: () {
            Navigator.of(context).maybePop();
            GetIt.instance
                .get<RouterFacade>()
                .navigateToMenu(RouterMenu.setting);
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [Icon(LucideIcons.settings, size: 15), Text('前往设置')],
          ),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          settingDialogBanner(
            context,
            text: '未检测到服务端 DBC 目录配置，DBC 导入/导出功能不可用。',
            color: theme.colorScheme.primary,
            icon: LucideIcons.hardDrive,
          ),
          settingDialogMutedHint(
            context,
            '请前往「设置 → 目录设置」配置服务端目录，'
            '程序会自动搜索 DBC 文件所在位置。',
          ),
        ],
      ),
    );
  }
}
