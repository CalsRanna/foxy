import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/page/scaffold/component/left_bar.dart';
import 'package:foxy/page/scaffold/component/status.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:hugeicons/hugeicons.dart';

@RoutePage()
class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      SizedBox(width: 80, child: LeftBar()),
      const VerticalDivider(thickness: 1, width: 1),
      Expanded(child: AutoRouter())
    ];
    final rightWorkspace = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final bodyChildren = [Expanded(child: rightWorkspace), const Status()];
    var scaffold = Scaffold(
      body: Column(children: bodyChildren),
      drawer: _Drawer(),
    );
    if (kIsWeb) return scaffold;
    if (Platform.isAndroid || Platform.isIOS) return scaffold;
    var actions = Actions(
      actions: _ShortcutManager.instance.actions,
      child: scaffold,
    );
    return Shortcuts(
      shortcuts: _ShortcutManager.instance.shortcuts,
      child: actions,
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    var syncAll = ListTile(
      leading: Icon(HugeIcons.strokeRoundedDatabaseSync01),
      onTap: () {},
      subtitle: Text('包含 dbc 和 mpq 文件'),
      title: Text('同步所有文件'),
      trailing: _Shortcut('S'),
    );
    var syncDbc = ListTile(
      leading: Icon(HugeIcons.strokeRoundedFolderSync),
      onTap: () {},
      title: Text('同步 dbc 文件'),
      trailing: _Shortcut('D'),
    );
    var syncMpq = ListTile(
      leading: Icon(HugeIcons.strokeRoundedFileSync),
      onTap: () {},
      title: Text('同步 mpq 文件'),
      trailing: _Shortcut('M'),
    );
    var setting = ListTile(
      leading: Icon(HugeIcons.strokeRoundedSettings01),
      onTap: () => navigateSetting(context),
      title: Text('设置'),
      trailing: _Shortcut(','),
    );
    var exitTile = ListTile(
      leading: Icon(HugeIcons.strokeRoundedCancel01),
      onTap: exitApp,
      title: Text('退出'),
      trailing: _Shortcut('Q'),
    );
    var children = [
      DrawerHeader(margin: EdgeInsets.zero, child: Text('Foxy')),
      syncAll,
      syncDbc,
      syncMpq,
      Divider(height: 1),
      setting,
      exitTile,
    ];
    return Drawer(child: ListView(children: children));
  }

  void exitApp() {
    _ExitAppAction().invoke(_ExitAppIntent());
  }

  void navigateSetting(BuildContext context) {
    _NavigateSettingAction().invoke(_NavigateSettingIntent());
  }
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
    final context = primaryFocus?.context;
    if (context == null) return null;
    final provider = selectedMenuIndexNotifierProvider;
    final container = ProviderScope.containerOf(context);
    final notifier = container.read(provider.notifier);
    notifier.select(11);
    Scaffold.of(context).closeDrawer();
    AutoRouter.of(context).push(const BasicSettingRoute());
    return null;
  }
}

class _NavigateSettingIntent extends Intent {}

class _Shortcut extends StatelessWidget {
  final String keyboardKey;
  const _Shortcut(this.keyboardKey);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) return SizedBox();
    if (Platform.isMacOS) return Text('⌘ $keyboardKey');
    return Text('Ctrl + $keyboardKey');
  }
}

class _ShortcutManager {
  static final _ShortcutManager instance = _ShortcutManager._internal();
  factory _ShortcutManager() => instance;
  _ShortcutManager._internal();

  Map<Type, Action<Intent>> get actions {
    return {
      _SyncAllFilesIntent: _SyncAllFilesAction(),
      _SyncDbcFilesIntent: _SyncDbcFilesAction(),
      _SyncMpqFileIntent: _SyncMpqFileAction(),
      _NavigateSettingIntent: _NavigateSettingAction(),
      _ExitAppIntent: _ExitAppAction(),
    };
  }

  Map<ShortcutActivator, Intent> get shortcuts {
    final keyS = LogicalKeyboardKey.keyS;
    final keyD = LogicalKeyboardKey.keyD;
    final keyM = LogicalKeyboardKey.keyM;
    final comma = LogicalKeyboardKey.comma;
    final keyQ = LogicalKeyboardKey.keyQ;
    final control = Platform.isMacOS ? false : true;
    final meta = Platform.isMacOS ? true : false;
    final keySActivator = SingleActivator(keyS, control: control, meta: meta);
    final keyDActivator = SingleActivator(keyD, control: control, meta: meta);
    final keyMActivator = SingleActivator(keyM, control: control, meta: meta);
    final commaActivator = SingleActivator(comma, control: control, meta: meta);
    final keyQActivator = SingleActivator(keyQ, control: control, meta: meta);
    return {
      keySActivator: _SyncAllFilesIntent(),
      keyDActivator: _SyncDbcFilesIntent(),
      keyMActivator: _SyncMpqFileIntent(),
      commaActivator: _NavigateSettingIntent(),
      keyQActivator: _ExitAppIntent(),
    };
  }
}

class _SyncAllFilesAction extends CallbackAction<_SyncAllFilesIntent> {
  _SyncAllFilesAction() : super(onInvoke: handleInvoke);

  static Object? handleInvoke(_SyncAllFilesIntent intent) {
    print(intent.toString());
    return null;
  }
}

class _SyncAllFilesIntent extends Intent {}

class _SyncDbcFilesAction extends CallbackAction<_SyncDbcFilesIntent> {
  _SyncDbcFilesAction() : super(onInvoke: handleInvoke);

  static Object? handleInvoke(_SyncDbcFilesIntent intent) {
    print(intent.toString());
    return null;
  }
}

class _SyncDbcFilesIntent extends Intent {}

class _SyncMpqFileAction extends CallbackAction<_SyncMpqFileIntent> {
  _SyncMpqFileAction() : super(onInvoke: handleInvoke);

  static Object? handleInvoke(_SyncMpqFileIntent intent) {
    print(intent.toString());
    return null;
  }
}

class _SyncMpqFileIntent extends Intent {}
