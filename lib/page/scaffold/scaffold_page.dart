import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/page/scaffold/dbc_import_view_model.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
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
    final context = primaryFocus?.context;
    if (context == null) return null;
    AutoRouter.of(context).push(const BasicSettingRoute());
    return null;
  }
}

class _NavigateSettingIntent extends Intent {}

class _ScaffoldPageState extends State<ScaffoldPage> {
  final viewModel = GetIt.instance.get<ScaffoldViewModel>();
  final dbcImportViewModel = GetIt.instance.get<DbcImportViewModel>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dbcImportViewModel.checkAndImport();
    });
  }

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
    var scaffold = Scaffold(body: topWorkspace);
    if (kIsWeb) return scaffold;
    if (Platform.isAndroid || Platform.isIOS) return scaffold;
    var wrapped = Actions(
      actions: _ShortcutManager.instance.actions,
      child: Shortcuts(
        shortcuts: _ShortcutManager.instance.shortcuts,
        child: scaffold,
      ),
    );

    return Watch((_) {
      if (dbcImportViewModel.dbcImported.value) return wrapped;
      return Stack(
        children: [
          wrapped,
          _DbcImportModal(dbcImportViewModel: dbcImportViewModel),
        ],
      );
    });
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
    var borderSide = BorderSide(color: Colors.grey.withValues(alpha: 0.5));
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
    var iconButtons = viewModel.menus.map(_buildLeftBarTile).toList();
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
    final active = viewModel.activeMenu == menu;
    final backgroundColor = active ? colorScheme.primary : null;
    final iconColor = active ? Colors.white : colorScheme.onSurface;
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(menu.icon, size: 20, color: iconColor),
    );
    var iconButton = IconButton(
      onPressed: () => viewModel.navigatePage(menu),
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
}

/// DBC 导入模态遮罩层
class _DbcImportModal extends StatelessWidget {
  final DbcImportViewModel dbcImportViewModel;
  const _DbcImportModal({required this.dbcImportViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Watch((_) => _buildDialog(context)),
      ),
    );
  }

  Widget _buildDialog(BuildContext context) {
    if (dbcImportViewModel.dbcImportError.value != null) {
      return _ErrorDialog(
        error: dbcImportViewModel.dbcImportError.value!,
        onRetry: dbcImportViewModel.retryImport,
      );
    }
    if (dbcImportViewModel.dbcPath.value == null) {
      return _PathSelectionDialog(
        onSubmit: (path) => dbcImportViewModel.setDbcPath(path),
      );
    }
    return _ProgressDialog(progress: dbcImportViewModel.dbcImportProgress.value);
  }
}

/// 路径选择对话框
class _PathSelectionDialog extends StatelessWidget {
  final ValueChanged<String> onSubmit;
  const _PathSelectionDialog({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: 500),
      title: const Text('DBC 文件路径'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请选择魔兽世界 DBC 文件所在目录（包含 Spell.dbc、Faction.dbc 等文件的文件夹）：'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ShadInput(
                  controller: controller,
                  placeholder: const Text('选择或输入 DBC 目录路径'),
                ),
              ),
              const SizedBox(width: 8),
              ShadButton(
                onPressed: () async {
                  final dir = await getDirectoryPath();
                  if (dir != null) {
                    controller.text = dir;
                  }
                },
                child: const Text('浏览'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ShadButton(
              onPressed: () {
                final path = controller.text.trim();
                if (path.isEmpty) return;
                onSubmit(path);
              },
              child: const Text('确认'),
            ),
          ),
        ],
      ),
    );
  }
}

/// 导入进度对话框
class _ProgressDialog extends StatelessWidget {
  final String progress;
  const _ProgressDialog({required this.progress});

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: 400),
      title: const Text('正在导入 DBC 数据'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            progress,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// 导入错误对话框
class _ErrorDialog extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorDialog({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: 500),
      title: const Text('DBC 导入失败'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(error),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ShadButton(
              onPressed: onRetry,
              child: const Text('重试'),
            ),
          ),
        ],
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
