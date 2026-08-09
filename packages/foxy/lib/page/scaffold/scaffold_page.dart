import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/page/setting/dbc_reminder_dialog.dart';
import 'package:foxy/page/setting/server_dir_reminder_dialog.dart';
import 'package:foxy/page/setting/setup_wizard_dialog.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/use_case/dbc/check_dbc_reminder_use_case.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/feature_state_view_model.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/window_button.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

@RoutePage()
class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ExitAppAction extends CallbackAction<_ExitAppIntent> {
  _ExitAppAction() : super(onInvoke: handleInvoke);

  static Object? handleInvoke(_ExitAppIntent intent) {
    exit(0);
  }
}

class _ExitAppIntent extends Intent {}

class _NavigateSettingAction extends CallbackAction<_NavigateSettingIntent> {
  _NavigateSettingAction() : super(onInvoke: handleInvoke);

  static Object? handleInvoke(_NavigateSettingIntent intent) {
    GetIt.instance.get<RouterFacade>().navigateToMenu(RouterMenu.setting);
    return null;
  }
}

class _NavigateSettingIntent extends Intent {}

class _ScaffoldPageState extends State<ScaffoldPage> {
  final featureState = GetIt.instance.get<FeatureStateViewModel>();
  final setupViewModel = GetIt.instance.get<SetupStatusViewModel>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  List<RouterMenu> get _menus {
    final pinned = featureState.pinnedFeatures.value
        .map((f) => RouterMenu.values.byName(f.routerMenu))
        .toList();
    return [
      RouterMenu.dashboard,
      ...pinned,
      RouterMenu.more,
      RouterMenu.setting,
    ];
  }

  @override
  Widget build(BuildContext context) {
    var rightColumnChildren = [
      Watch((_) => _buildBreadcrumb()),
      Expanded(child: AutoRouter()),
    ];
    final children = [
      Watch((_) => _buildLeftBar()),
      VerticalDivider(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        thickness: 1,
        width: 1,
      ),
      Expanded(child: Column(children: rightColumnChildren)),
    ];
    final topWorkspace = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    var scaffold = Scaffold(body: topWorkspace);
    if (kIsWeb) return scaffold;
    if (Platform.isAndroid || Platform.isIOS) return scaffold;
    return Actions(
      actions: _ShortcutManager.instance.actions,
      child: Shortcuts(
        shortcuts: _ShortcutManager.instance.shortcuts,
        child: scaffold,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkSetup());
  }

  Widget _buildBreadcrumb() {
    final nodes = routerFacade.path.value;
    var children = <Widget>[];
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final isLast = i == nodes.length - 1;
      var text = Text(node.label);
      if (!isLast) {
        final index = i;
        var item = ShadBreadcrumbLink(
          onPressed: () => routerFacade.navigateToBreadcrumb(index),
          child: text,
        );
        children.add(item);
      } else {
        children.add(text);
      }
    }
    var borderSide = BorderSide(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: borderSide)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: Row(
          children: [
            ShadBreadcrumb(children: children),
            Spacer(),
            WindowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftBar() {
    var iconButtons = _menus.map(_buildLeftBarTile).toList();
    var children = [
      const SizedBox(height: 16),
      Text('FOXY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      const SizedBox(height: 12),
      ...iconButtons,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _buildLeftBarTile(RouterMenu menu) {
    final colorScheme = Theme.of(context).colorScheme;
    final active = routerFacade.activeMenu == menu;
    final backgroundColor = active ? colorScheme.primary : null;
    final iconColor = active ? Colors.white : colorScheme.onSurface;
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(menu.icon, size: 16, color: iconColor),
    );
    var iconButton = IconButton(
      onPressed: () => routerFacade.navigateToMenu(menu),
      icon: padding,
      isSelected: active,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: iconButton,
    );
  }

  /// Enforces the first-setup check: when incomplete (either directory
  /// unconfigured or icons not extracted), opens the non-dismissable
  /// three-step wizard; completed steps are detected and skipped inside
  /// the wizard.
  ///
  /// Exception: when the client directory is already configured but the
  /// server directory is missing (e.g. an existing installation upgraded
  /// before `server_dir` existed), a lighter dismissable reminder opens
  /// instead, guiding the user to the settings page. First-install and
  /// icons-only paths behave exactly as before.
  Future<void> _checkSetup() async {
    try {
      await setupViewModel.prepare();
    } catch (_) {
      // A config read failure counts as incomplete; the wizard will show
      // again.
    }
    if (!mounted) return;
    if (!setupViewModel.isSetupComplete) {
      if (!setupViewModel.isClientDirConfigured) {
        _showSetupWizard();
        return;
      }
      if (!setupViewModel.isServerDirConfigured) {
        _showServerDirReminderDialog();
        return;
      }
      _showSetupWizard();
      return;
    }
    await _checkDbcReminder();
  }

  /// Startup reminder for DBC tables that were never imported (e.g. after
  /// an upgrade adds new definitions). Best-effort: any failure is silently
  /// ignored so it never disturbs startup.
  Future<void> _checkDbcReminder() async {
    try {
      final reminder =
          await GetIt.instance.get<CheckDbcReminderUseCase>().execute();
      if (!mounted || !reminder.shouldRemind) return;
      _showDbcReminderDialog(reminder);
    } catch (_) {
      // The reminder is best-effort; failures must not affect startup.
    }
  }

  void _showDbcReminderDialog(DbcReminderCheckResult result) {
    showFoxyDialog(
      context: context,
      builder: (ctx) => DbcReminderDialog(result: result),
    );
  }

  void _showServerDirReminderDialog() {
    showFoxyDialog(
      context: context,
      builder: (ctx) => const ServerDirReminderDialog(),
    );
  }

  void _showSetupWizard() {
    showFoxyDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => SetupWizardDialog(
        setupVm: setupViewModel,
        importVm: GetIt.instance.get<DbcImportWorkflowViewModel>(),
        iconVm: GetIt.instance.get<IconExtractWorkflowViewModel>(),
      ),
    );
  }
}

class _ShortcutManager {
  static final _ShortcutManager instance = _ShortcutManager._internal();
  factory _ShortcutManager() => instance;
  _ShortcutManager._internal();

  Map<Type, Action<Intent>> get actions {
    return {
      _NavigateSettingIntent: _NavigateSettingAction(),
      _ExitAppIntent: _ExitAppAction(),
    };
  }

  Map<ShortcutActivator, Intent> get shortcuts {
    final comma = LogicalKeyboardKey.comma;
    final keyQ = LogicalKeyboardKey.keyQ;
    final control = Platform.isMacOS ? false : true;
    final meta = Platform.isMacOS ? true : false;
    final commaActivator = SingleActivator(comma, control: control, meta: meta);
    final keyQActivator = SingleActivator(keyQ, control: control, meta: meta);
    return {
      commaActivator: _NavigateSettingIntent(),
      keyQActivator: _ExitAppIntent(),
    };
  }
}
