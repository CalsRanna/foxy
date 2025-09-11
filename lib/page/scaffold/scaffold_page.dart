import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/page/scaffold/component/status.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:signals/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
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
    var github = IconButton(
      icon: Icon(HugeIcons.strokeRoundedGithub01, size: 20),
      onPressed: launchGithub,
    );
    var headerChildren = [
      Text('Foxy'.toUpperCase(), style: TextStyle(fontSize: 32)),
      const SizedBox(height: 8),
      Text('「做最好的魔兽世界编辑器」'),
      const SizedBox(height: 8),
      github,
    ];
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: headerChildren,
    );
    var header = DrawerHeader(margin: EdgeInsets.zero, child: column);
    var children = [
      header,
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

  void launchGithub() {
    final uri = Uri.parse('https://github.com/CalsRanna/foxy');
    launchUrl(uri, mode: LaunchMode.externalApplication);
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

class _ScaffoldPageState extends State<ScaffoldPage> {
  final viewModel = GetIt.instance.get<ScaffoldViewModel>();

  @override
  Widget build(BuildContext context) {
    var rightColumnChildren = [
      Watch((_) => _buildBreadcrumb()),
      Expanded(child: AutoRouter()),
    ];
    final children = [
      Watch((_) => _buildLeftBar()),
      const VerticalDivider(thickness: 1, width: 1),
      Expanded(child: Column(children: rightColumnChildren)),
    ];
    final topWorkspace = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final bodyChildren = [Expanded(child: topWorkspace), const Status()];
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

  Widget _buildBreadcrumb() {
    var children = <Widget>[];
    for (var page in viewModel.pages.value) {
      var text = Text(viewModel.localPages.value[page] ?? page);
      var item = FoxyBreadcrumbItem(onTap: () {}, child: text);
      if (page == viewModel.pages.value.last) {
        item = FoxyBreadcrumbItem(child: text);
      }
      children.add(item);
    }
    return FoxyBreadcrumb(children: children);
  }

  Widget _buildDrawer() {
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Icon(HugeIcons.strokeRoundedMenu01, size: 20),
    );
    return IconButton(onPressed: () {}, icon: padding);
  }

  Widget _buildLeftBar() {
    var drawer = _buildDrawer();
    var iconButtons = viewModel.menus.map(_buildLeftBarTile).toList();
    var children = [
      const SizedBox(height: 8),
      drawer,
      const SizedBox(height: 12),
      ...iconButtons,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _buildLeftBarTile(String menu) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final active = viewModel.pages.value.last.startsWith(menu);
    final color = active ? primaryContainer : null;
    final icon = viewModel.getIcon(menu);
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(icon, size: 20),
    );
    var iconButton = IconButton(
      onPressed: () => viewModel.navigatePage(context, menu),
      icon: padding,
      isSelected: active,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: iconButton,
    );
  }
}

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
