import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
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
    GetIt.instance.get<RouterFacade>().navigateToMenu(RouterMenu.setting);
    return null;
  }
}

class _NavigateSettingIntent extends Intent {}

class _ScaffoldPageState extends State<ScaffoldPage> {
  final viewModel = GetIt.instance.get<ScaffoldViewModel>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.checkAndImport();
      if (!mounted) return;
      _showDbcDialog();
    });
  }

  void _showDbcDialog() {
    final vm = viewModel;

    // 已导入，无需操作
    if (vm.dbcImported.value) return;

    // 检查失败 / 表结构不兼容：专用恢复对话框，禁止误开「未导入」或自动导入。
    if (vm.dbcCheckError.value != null) {
      _showDbcCheckErrorDialog();
      return;
    }

    // 路径已配置 → 自动导入（显示进度对话框并启动导入）
    if (vm.dbcPath.value != null) {
      vm.startImport();
      showShadDialog(
        opaque: false,
        context: context,
        barrierDismissible: false,
        builder: (ctx) => _DbcImportDialog(vm: viewModel),
      );
      return;
    }

    // 未配置路径 → 显示提醒对话框
    showShadDialog(
      opaque: false,
      context: context,
      builder: (ctx) => ShadDialog.alert(
        title: const Text('DBC 数据未导入'),
        description: const Text(
          '导入 DBC 数据后才能正常使用应用的全部功能，'
          '包括法术、物品、生物等数据的完整展示与编辑。',
        ),
        actions: [
          ShadButton.outline(
            child: const Text('稍后再说'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ShadButton(
            child: const Text('立即导入'),
            onPressed: () {
              Navigator.of(ctx).pop();
              showShadDialog(
                opaque: false,
                context: context,
                barrierDismissible: false,
                builder: (ctx) => _DbcImportDialog(vm: vm),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDbcCheckErrorDialog() {
    final vm = viewModel;
    final message = vm.dbcCheckError.value ?? 'DBC 表检查失败';
    final incompatible = vm.dbcCheckIncompatible.value;
    final theme = ShadTheme.of(context);

    showShadDialog(
      opaque: false,
      context: context,
      builder: (ctx) => ShadDialog.alert(
        title: Text(incompatible ? 'DBC 表结构不兼容' : 'DBC 表检查失败'),
        description: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              incompatible
                  ? '当前数据库中的 DBC 表与应用期望的字段结构不一致。'
                        '可重新检查，或重新导入（以 DBC 为准覆盖库内对应表）。'
                  : '无法完成 DBC 表状态检查。请确认数据库连接正常后重试。',
              style: theme.textTheme.muted.copyWith(fontSize: 13),
            ),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 180),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.destructive.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: theme.colorScheme.destructive.withValues(alpha: 0.2),
                ),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  message,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ShadButton.outline(
            child: const Text('稍后再说'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ShadButton.outline(
            child: const Text('重新检查'),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await vm.checkAndImport();
              if (!mounted) return;
              _showDbcDialog();
            },
          ),
          ShadButton(
            child: Text(incompatible ? '重新导入' : '尝试导入'),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await vm.prepareManualImport(startIfPathReady: true);
              if (!mounted) return;
              showShadDialog(
                opaque: false,
                context: context,
                barrierDismissible: false,
                builder: (importCtx) => _DbcImportDialog(vm: vm),
              );
            },
          ),
        ],
      ),
    );
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

  List<RouterMenu> get _menus {
    final pinned = viewModel.pinnedFeatures.value
        .map((f) => RouterMenu.values.byName(f.routerMenu))
        .toList();
    return [
      RouterMenu.dashboard,
      ...pinned,
      RouterMenu.more,
      RouterMenu.setting,
    ];
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
}

const _kDbcDialogWidth = 480.0;

/// DBC 导入对话框，使用 showShadDialog 自带遮罩，不可关闭
class _DbcImportDialog extends StatefulWidget {
  final ScaffoldViewModel vm;
  const _DbcImportDialog({required this.vm});

  @override
  State<_DbcImportDialog> createState() => _DbcImportDialogState();
}

class _DbcImportDialogState extends State<_DbcImportDialog> {
  ScaffoldViewModel get _vm => widget.vm;
  final _pathController = TextEditingController();
  final _pathFocus = FocusNode();
  void Function()? _unsub;

  @override
  void initState() {
    super.initState();
    _unsub = _vm.dbcImported.subscribe(_onImportedChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pathFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _unsub?.call();
    _pathController.dispose();
    _pathFocus.dispose();
    super.dispose();
  }

  void _onImportedChanged(bool imported) {
    if (imported && mounted) {
      _unsub?.call();
      _unsub = null;
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: _kDbcDialogWidth, child: Watch((_) => _buildBody()));
  }

  Widget _buildBody() {
    final error = _vm.dbcImportError.value;
    final path = _vm.dbcPath.value;
    final importing = _vm.dbcImporting.value;

    if (error != null) {
      return _buildErrorBody(error);
    }
    if (path == null) {
      return _buildPathBody();
    }
    if (importing) {
      return _buildProgressBody();
    }
    // 正在扫描目录 / 准备中
    return _buildProgressBody();
  }

  Widget _buildPathBody() {
    final theme = ShadTheme.of(context);
    final descStyle = theme.textTheme.muted.copyWith(fontSize: 13);

    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcDialogWidth),
      title: Row(
        spacing: 10,
        children: [
          Icon(LucideIcons.folderOpen, size: 20),
          const Text('导入 DBC 数据'),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18,
        children: [
          Text(
            '请选择魔兽世界客户端中 DBC 文件的所在目录\n（包含 Spell.dbc、Faction.dbc 等 .dbc 文件的文件夹）',
            style: descStyle,
          ),
          ShadInput(
            controller: _pathController,
            focusNode: _pathFocus,
            placeholder: const Text('选择或输入 DBC 目录路径...'),
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(LucideIcons.folderSearch, size: 16),
            ),
            trailing: ShadButton.ghost(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              onPressed: _pathController.text.isEmpty
                  ? null
                  : () => _pathController.clear(),
              child: const Icon(LucideIcons.x, size: 14),
            ),
            onSubmitted: (_) => _submitPath(),
          ),
          Row(
            spacing: 8,
            children: [
              ShadButton.outline(
                onPressed: () async {
                  final dir = await getDirectoryPath();
                  if (dir != null) _pathController.text = dir;
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    Icon(LucideIcons.folderOpen, size: 15),
                    Text('浏览...'),
                  ],
                ),
              ),
              const Spacer(),
              ShadButton(
                onPressed: _submitPath,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [Icon(LucideIcons.play, size: 15), Text('开始导入')],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitPath() {
    final path = _pathController.text.trim();
    if (path.isEmpty) return;
    _vm.setDbcPath(path);
  }

  Widget _buildProgressBody() {
    final theme = ShadTheme.of(context);
    final mutedStyle = theme.textTheme.muted.copyWith(fontSize: 12);
    final ratio = _vm.dbcProgress.value;
    final label = _vm.dbcProgressLabel.value;
    final detail = _vm.dbcProgressDetail.value;
    final cancelling = _vm.dbcImportCancelling.value;

    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcDialogWidth),
      title: Row(
        spacing: 10,
        children: [
          const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const Text('正在导入 DBC 数据'),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 14,
        children: [
          if (ratio != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('总体进度', style: mutedStyle),
                Text('${(ratio * 100).toStringAsFixed(0)}%', style: mutedStyle),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: ratio, minHeight: 6),
            ),
          ],
          if (label.isNotEmpty) ...[
            Row(
              spacing: 8,
              children: [
                Icon(
                  LucideIcons.fileInput,
                  size: 15,
                  color: theme.colorScheme.mutedForeground,
                ),
                Expanded(
                  child: Text(label, style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
            if (detail.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: Text(detail, style: mutedStyle),
              ),
          ],
          if (ratio == null && label.isEmpty)
            Text('正在准备...', style: const TextStyle(fontSize: 13)),
          Align(
            alignment: Alignment.centerRight,
            child: ShadButton.outline(
              onPressed: cancelling ? null : _vm.cancelImport,
              child: Text(cancelling ? '正在取消...' : '取消导入'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBody(String error) {
    final theme = ShadTheme.of(context);
    final isCancelled = error.contains('取消');
    return ShadDialog(
      closeIcon: const SizedBox.shrink(),
      constraints: const BoxConstraints(maxWidth: _kDbcDialogWidth),
      title: Row(
        spacing: 10,
        children: [
          Icon(
            isCancelled ? LucideIcons.circleX : LucideIcons.triangleAlert,
            size: 20,
            color: theme.colorScheme.destructive,
          ),
          Text(isCancelled ? 'DBC 导入已取消' : 'DBC 导入失败'),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.destructive.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: theme.colorScheme.destructive.withValues(alpha: 0.2),
              ),
            ),
            child: SelectableText(error, style: const TextStyle(fontSize: 13)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                ShadButton.outline(
                  onPressed: () {
                    _vm.dbcImportError.value = null;
                    Navigator.of(context).maybePop();
                  },
                  child: const Text('关闭'),
                ),
                ShadButton(
                  onPressed: _vm.retryImport,
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
