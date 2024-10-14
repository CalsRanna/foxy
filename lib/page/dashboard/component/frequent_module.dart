import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class FrequentModuleComponent extends StatefulWidget {
  const FrequentModuleComponent({super.key});

  @override
  State<FrequentModuleComponent> createState() =>
      _FrequentModuleComponentState();
}

class _CategoryTag extends StatelessWidget {
  final _ModuleCategory category;

  const _CategoryTag({required this.category});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.5,
    );
    final text = category == _ModuleCategory.database ? 'Database' : 'Dbc';
    return Text(text, style: style);
  }
}

class _FrequentModuleComponentState extends State<FrequentModuleComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    const creature = _ModuleTile(
      category: _ModuleCategory.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedUserMultiple),
      name: '生物',
    );
    const item = _ModuleTile(
      category: _ModuleCategory.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedBodyArmor),
      name: '物品',
    );
    const gameObject = _ModuleTile(
      category: _ModuleCategory.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedCube),
      name: '游戏对象',
      positions: [_ModuleTileBorderPosition.top],
    );
    const quest = _ModuleTile(
      category: _ModuleCategory.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedCursorInfo01),
      name: '任务',
    );
    const gossip = _ModuleTile(
      category: _ModuleCategory.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedBubbleChat),
      name: '对话',
    );
    const smartScript = _ModuleTile(
      category: _ModuleCategory.database,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedCode),
      name: '内建脚本',
      positions: [_ModuleTileBorderPosition.top],
    );
    const spell = _ModuleTile(
      category: _ModuleCategory.dbc,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedSolarSystem),
      name: '法术',
    );
    const talent = _ModuleTile(
      category: _ModuleCategory.dbc,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedNanoTechnology),
      name: '天赋',
    );
    const itemSet = _ModuleTile(
      category: _ModuleCategory.dbc,
      description: '游戏中所有生物的相关数据,包含NPC和怪物.',
      icon: Icon(HugeIcons.strokeRoundedLayers01),
      name: '套装',
      positions: [_ModuleTileBorderPosition.top],
    );
    const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const title = Text('常用的模块', style: textStyle);
    const row1 = Row(children: [
      Expanded(child: creature),
      Expanded(child: item),
      Expanded(child: gameObject),
    ]);
    const row2 = Row(children: [
      Expanded(child: quest),
      Expanded(child: gossip),
      Expanded(child: smartScript),
    ]);
    const row3 = Row(children: [
      Expanded(child: spell),
      Expanded(child: talent),
      Expanded(child: itemSet),
    ]);
    const padding = Padding(padding: EdgeInsets.all(16.0), child: title);
    const children = [padding, row1, row2, row3];
    const column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final boxShadow = BoxShadow(
      blurRadius: 8,
      color: outline.withOpacity(0.1),
      spreadRadius: 8,
    );
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      boxShadow: [boxShadow],
      color: surface,
    );
    return Container(decoration: boxDecoration, child: column);
  }
}

enum _ModuleCategory { database, dbc }

class _ModuleTile extends StatefulWidget {
  final _ModuleCategory category;

  final String description;
  final Widget icon;
  final String name;
  final List<_ModuleTileBorderPosition> positions;
  const _ModuleTile({
    this.category = _ModuleCategory.database,
    required this.description,
    required this.icon,
    required this.name,
    this.positions = _ModuleTileBorderPosition.values,
  });

  @override
  State<_ModuleTile> createState() => _ModuleTileState();
}

enum _ModuleTileBorderPosition { right, top }

class _ModuleTileState extends State<_ModuleTile> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    final titleChildren = [
      Text(widget.name),
      _CategoryTag(category: widget.category)
    ];
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
      children: [title, const SizedBox(height: 32), Text(widget.description)],
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: container,
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
    final showRight = positions.contains(_ModuleTileBorderPosition.right);
    final showTop = positions.contains(_ModuleTileBorderPosition.top);
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
