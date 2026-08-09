import 'package:flutter/material.dart';
import 'package:foxy/page/setting/setting_dialog_shell.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/use_case/dbc/check_dbc_reminder_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Startup reminder shown when registered DBC tables were never imported.
///
/// Guides the user to the settings page's DBC management section; the
/// [DbcImportDialog] opened there performs the actual import.
class DbcReminderDialog extends StatelessWidget {
  final DbcReminderCheckResult result;

  const DbcReminderDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final shown = result.missingTables.take(5).join('\n');
    final suffix = result.missingTables.length > 5
        ? '\n...等 ${result.missingTables.length} 张表'
        : '';
    return SettingDialogShell(
      title: settingDialogTitleRow(
        LucideIcons.fileInput,
        '发现未导入的 DBC 数据',
      ),
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
            children: [Icon(LucideIcons.settings, size: 15), Text('前往导入')],
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
            text:
                '检测到 ${result.missingTables.length} 张 DBC 表尚未导入数据库，'
                '相关模块可能无法正常使用。',
            color: theme.colorScheme.primary,
            icon: LucideIcons.fileInput,
          ),
          SelectableText(
            shown + suffix,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          settingDialogMutedHint(
            context,
            '请前往「设置 → DBC 数据管理」导入最新的 DBC 文件。',
          ),
        ],
      ),
    );
  }
}
