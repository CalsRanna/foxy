import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/card.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FrequentModuleComponent extends StatelessWidget {
  const FrequentModuleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const title = Text('常用功能', style: textStyle);
    final creature = _Tile(
      category: _Category.database,
      description: '所有生物的相关数据,包含NPC和怪物。',
      icon: Icon(LucideIcons.pawPrint),
      name: '生物',
      onTap: () => handleTap(context, 0),
      positions: [_Position.right],
    );
    final item = _Tile(
      category: _Category.database,
      description: '包含装备，物品信息。',
      icon: Icon(LucideIcons.swords),
      name: '物品',
      onTap: () => handleTap(context, 1),
      positions: [_Position.right],
    );
    final quest = _Tile(
      category: _Category.database,
      description: '任务模板及其它关联的数据，比如奖励，任务对话等等。',
      icon: Icon(LucideIcons.badgeQuestionMark),
      name: '任务',
      onTap: () => handleTap(context, 2),
      positions: [],
    );
    final spell = _Tile(
      category: _Category.dbc,
      description: '角色拥有的法术技能。',
      icon: Icon(LucideIcons.shell),
      name: '法术',
      onTap: () => handleTap(context, 6),
    );
    final gameObject = _Tile(
      category: _Category.database,
      description: '所有可交互的物体，比如陷阱，宝箱等等。',
      icon: Icon(LucideIcons.mapPin),
      name: '游戏对象',
      onTap: () => handleTap(context, 2),
    );
    final gossip = _Tile(
      category: _Category.database,
      description: '和NPC交谈时，对话框中的面板内容及对话选项。',
      icon: Icon(LucideIcons.messageCircle),
      name: '对话',
      onTap: () => handleTap(context, 4),
    );
    final smartScript = _Tile(
      category: _Category.database,
      description: '主要是一些简单的脚本，不需要复杂的代码逻辑。',
      icon: Icon(LucideIcons.code),
      name: '内建脚本',
      onTap: () => handleTap(context, 5),
      positions: [_Position.top],
    );
    final talent = _Tile(
      category: _Category.dbc,
      description: '天赋树中的信息，配合法术一起使用。',
      icon: Icon(LucideIcons.sparkles),
      name: '天赋',
      onTap: () => handleTap(context, 7),
    );
    final itemSet = _Tile(
      category: _Category.dbc,
      description: '套装数据，包含组成部分，套装奖励效果等等。',
      icon: Icon(LucideIcons.layers),
      name: '套装',
      onTap: () => handleTap(context, 8),
      positions: [_Position.top],
    );
    final row1 = Row(
      children: [
        Expanded(child: creature),
        Expanded(child: item),
        Expanded(child: quest),
      ],
    );
    final row2 = Row(
      children: [
        Expanded(child: spell),
        Expanded(child: gossip),
        Expanded(child: smartScript),
      ],
    );
    final row3 = Row(
      children: [
        Expanded(child: gameObject),
        Expanded(child: talent),
        Expanded(child: itemSet),
      ],
    );
    final children = [row1, row2, row3];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    return FoxyCard(title: title, child: column);
  }

  void handleTap(BuildContext context, int index) {
    final menu = switch (index) {
      0 => RouterMenu.creatureTemplate,
      1 => RouterMenu.itemTemplate,
      2 => RouterMenu.questTemplate,
      3 => RouterMenu.gameObjectTemplate,
      4 => RouterMenu.gossipMenu,
      5 => RouterMenu.smartScript,
      _ => RouterMenu.dashboard,
    };
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToMenu(menu);
  }
}

enum _Category { database, dbc }

enum _Position { right, top }

class _Tag extends StatelessWidget {
  final _Category category;

  const _Tag({required this.category});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
    return Text(category.name.toUpperCase(), style: style);
  }
}

class _Tile extends StatefulWidget {
  final _Category category;
  final String description;
  final Widget icon;
  final String name;
  final void Function()? onTap;
  final List<_Position> positions;

  const _Tile({
    this.category = _Category.database,
    required this.description,
    required this.icon,
    required this.name,
    this.onTap,
    this.positions = _Position.values,
  });

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    final titleChildren = [Text(widget.name), _Tag(category: widget.category)];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: titleChildren,
    );
    final children = [
      widget.icon,
      const SizedBox(width: 16),
      Expanded(child: column),
    ];
    final title = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
    var description = SizedBox(height: 72, child: Text(widget.description));
    final containerColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, const SizedBox(height: 16), description],
    );
    final border = _getBorder(outline);
    final shadow = _getShadow(outline);
    final boxDecoration = BoxDecoration(
      border: border,
      boxShadow: shadow,
      color: surface,
    );
    final container = Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(16),
      child: containerColumn,
    );
    final detector = GestureDetector(onTap: widget.onTap, child: container);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: detector,
    );
  }

  void handleEnter(PointerEnterEvent event) {
    setState(() {
      hover = true;
    });
  }

  void handleExit(PointerExitEvent event) {
    setState(() {
      hover = false;
    });
  }

  Border _getBorder(Color outline) {
    BorderSide side = BorderSide(color: outline.withValues(alpha: 0.2));
    final positions = widget.positions;
    final showRight = positions.contains(_Position.right);
    final showTop = positions.contains(_Position.top);
    return Border(
      right: showRight ? side : BorderSide.none,
      top: showTop ? side : BorderSide.none,
    );
  }

  List<BoxShadow> _getShadow(Color outline) {
    if (!hover) return [];
    final shadow = BoxShadow(
      blurRadius: 8,
      color: outline.withValues(alpha: 0.1),
      spreadRadius: 8,
    );
    return [shadow];
  }
}
