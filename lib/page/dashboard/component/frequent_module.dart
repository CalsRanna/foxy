import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/card.dart';
import 'package:hugeicons/hugeicons.dart';

class FrequentModuleComponent extends StatelessWidget {
  const FrequentModuleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const title = Text('常用的模块', style: textStyle);
    final creature = _Tile(
      category: _Category.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedUserMultiple),
      name: '生物',
      onTap: () => handleTap(context, 0),
      positions: [_Position.right],
    );
    final item = _Tile(
      category: _Category.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedBodyArmor),
      name: '物品',
      onTap: () => handleTap(context, 1),
      positions: [_Position.right],
    );
    final gameObject = _Tile(
      category: _Category.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedCube),
      name: '游戏对象',
      onTap: () => handleTap(context, 2),
      positions: [],
    );
    final quest = _Tile(
      category: _Category.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedCursorInfo01),
      name: '任务',
      onTap: () => handleTap(context, 3),
    );
    final gossip = _Tile(
      category: _Category.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedBubbleChat),
      name: '对话',
      onTap: () => handleTap(context, 4),
    );
    final smartScript = _Tile(
      category: _Category.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedCode),
      name: '内建脚本',
      onTap: () => handleTap(context, 5),
      positions: [_Position.top],
    );
    final spell = _Tile(
      category: _Category.dbc,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedSolarSystem),
      name: '法术',
      onTap: () => handleTap(context, 6),
    );
    final talent = _Tile(
      category: _Category.dbc,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedNanoTechnology),
      name: '天赋',
      onTap: () => handleTap(context, 7),
    );
    final itemSet = _Tile(
      category: _Category.dbc,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedLayers01),
      name: '套装',
      onTap: () => handleTap(context, 8),
      positions: [_Position.top],
    );
    final row1 = Row(children: [
      Expanded(child: creature),
      Expanded(child: item),
      Expanded(child: gameObject),
    ]);
    final row2 = Row(children: [
      Expanded(child: quest),
      Expanded(child: gossip),
      Expanded(child: smartScript),
    ]);
    final row3 = Row(children: [
      Expanded(child: spell),
      Expanded(child: talent),
      Expanded(child: itemSet),
    ]);
    final children = [row1, row2, row3];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    return ArcaneCard(title: title, child: column);
  }

  void handleTap(BuildContext context, int index) {
    final provider = selectedMenuIndexNotifierProvider;
    final container = ProviderScope.containerOf(context);
    final notifier = container.read(provider.notifier);
    notifier.select(index + 1);
    final route = switch (index) {
      0 => CreatureTemplateListRoute(),
      1 => ItemTemplateListRoute(),
      2 => GameObjectTemplateListRoute(),
      3 => QuestTemplateListRoute(),
      4 => GossipMenuListRoute(),
      5 => SmartScriptListRoute(),
      _ => DashboardRoute(),
    };
    AutoRouter.of(context).navigate(route);
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final containerColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, const SizedBox(height: 16), Text(widget.description)],
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
    BorderSide side = BorderSide(color: outline.withOpacity(0.2));
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
      color: outline.withOpacity(0.1),
      spreadRadius: 8,
    );
    return [shadow];
  }
}
