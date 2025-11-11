import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LeftBar extends StatelessWidget {
  const LeftBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> menus = List.generate(
      _Icons.icons.length,
      (index) => _Tile(index: index),
    );
    var column = Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(children: menus),
    );
    return Column(
      children: [
        _Drawer(),
        SizedBox(height: 8),
        Expanded(child: column),
      ],
    );
  }
}

class _Icons {
  static const icons = [
    LucideIcons.layoutDashboard,
    LucideIcons.pawPrint,
    LucideIcons.swords,
    LucideIcons.badgeQuestionMark,
    LucideIcons.shell,
    LucideIcons.ellipsis,
    LucideIcons.settings,
  ];
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final icon = Icon(LucideIcons.menu, size: 20);
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: icon,
    );
    var iconButton = IconButton(
      onPressed: () => handleTap(context),
      icon: padding,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: iconButton,
    );
  }

  void handleTap(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}

class _Tile extends StatelessWidget {
  final int index;
  const _Tile({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final selectedMenuIndex = 0;
    final active = index == selectedMenuIndex;
    final color = active ? primaryContainer : null;
    final icon = Icon(_Icons.icons[index], size: 20);
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: icon,
    );
    var iconButton = IconButton(
      onPressed: () => handlePressed(context),
      icon: padding,
      isSelected: active,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: iconButton,
    );
  }

  void handlePressed(BuildContext context) {
    final route = switch (index) {
      0 => DashboardRoute(),
      1 => CreatureTemplateListRoute(),
      2 => ItemTemplateListRoute(),
      3 => QuestTemplateListRoute(),
      6 => BasicSettingRoute(),
      _ => DashboardRoute(),
    };
    AutoRouter.of(context).navigate(route);
  }
}
