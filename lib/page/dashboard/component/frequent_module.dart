import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foxy/model/frequent_module.dart';

class FrequentModuleComponent extends StatefulWidget {
  const FrequentModuleComponent({super.key});

  @override
  State<FrequentModuleComponent> createState() =>
      _FrequentModuleComponentState();
}

class _FrequentModuleComponentState extends State<FrequentModuleComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: outline.withOpacity(0.1),
            spreadRadius: 8,
          )
        ],
        color: surface,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '常用的模块',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(children: [
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '生物',
              ),
            ),
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '物品',
              ),
            ),
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '游戏对象',
              ),
            ),
          ]),
          Row(children: [
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '任务',
              ),
            ),
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '对话',
              ),
            ),
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '内建脚本',
              ),
            ),
          ]),
          Row(children: [
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '法术',
              ),
            ),
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '天赋',
              ),
            ),
            Expanded(
              child: _ModuleTile(
                category: _ModuleCategory.database,
                description: '游戏中所有生物的相关数据,包含NPC和怪物.',
                icon: Icon(Icons.people_outlined),
                name: '套装',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _ModuleTiles extends StatelessWidget {
  const _ModuleTiles({super.key, required this.modules});

  final List<FrequentModule> modules;

  @override
  Widget build(BuildContext context) {
    const column = 3;
    final row = modules.length ~/ column;

    return Column(
      children: [
        for (int i = 0; i < row; i++)
          Row(children: [
            for (int j = 0; j < column; j++)
              if (i * row + j < modules.length)
                Expanded(
                  child: _ModuleTile(
                    category: _ModuleCategory.dbc,
                    description: modules[i * row + j].description,
                    icon: Icon(Icons.auto_awesome_outlined),
                    name: modules[i * row + j].name,
                  ),
                ),
          ])
      ],
    );
  }
}

class _ModuleTile extends StatefulWidget {
  const _ModuleTile({
    super.key,
    this.border,
    this.category = _ModuleCategory.database,
    required this.description,
    required this.icon,
    required this.name,
    this.updatedAt,
  });

  final Border? border;
  final _ModuleCategory category;
  final String description;
  final Widget icon;
  final String name;
  final DateTime? updatedAt;

  @override
  State<_ModuleTile> createState() => __ModuleTileState();
}

class __ModuleTileState extends State<_ModuleTile> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surface = colorScheme.surface;
    List<BoxShadow> shadow = [];
    if (hover) {
      shadow = [
        BoxShadow(
          blurRadius: 8,
          color: outline.withOpacity(0.1),
          spreadRadius: 8,
        )
      ];
    }
    BorderSide side = BorderSide(color: outline.withOpacity(0.2));
    Border border = Border(right: side, top: side);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleEnter,
      onExit: handleExit,
      child: Container(
        decoration: BoxDecoration(
          border: widget.border ?? border,
          boxShadow: shadow,
          color: surface,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.icon,
                const SizedBox(width: 16),
                Text(widget.name),
                const Spacer(),
                _CategoryTag(category: widget.category),
              ],
            ),
            const SizedBox(height: 32),
            Text(widget.description)
          ],
        ),
      ),
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
}

class _CategoryTag extends StatelessWidget {
  const _CategoryTag({super.key, required this.category});

  final _ModuleCategory category;

  @override
  Widget build(BuildContext context) {
    return category == _ModuleCategory.database
        ? const Text('Database')
        : const Text('Dbc');
  }
}

class _UpdatedAt extends StatelessWidget {
  const _UpdatedAt({super.key, this.dateTime});

  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    var time = dateTime ?? DateTime.now();
    var now = DateTime.now();
    final different = now.difference(time);
    return switch (different.inSeconds) {
      < 60 => Text('${different.inSeconds} seconds ago'),
      < 60 * 60 => Text('${different.inMinutes} minutes ago'),
      < 60 * 60 * 24 => Text('${different.inHours} hours ago'),
      _ => Text('${different.inDays} days ago'),
    };
  }
}

enum _ModuleCategory { database, dbc }
