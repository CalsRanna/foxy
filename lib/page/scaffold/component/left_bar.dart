import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:window_manager/window_manager.dart';

class LeftBar extends StatelessWidget {
  const LeftBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> menus = List.generate(
      _Icons.icons.length,
      (index) => _Tile(index: index),
    );
    final column = Column(children: [_Drawer(), ...menus]);
    final edgeInsets = MediaQuery.paddingOf(context);
    var singleChildScrollView = SingleChildScrollView(
      padding: EdgeInsets.only(left: edgeInsets.left + 8, right: 8),
      child: column,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) => windowManager.startDragging(),
      child: singleChildScrollView,
    );
  }
}

class _Icons {
  static const icons = [
    HugeIcons.strokeRoundedDashboardCircle,
    HugeIcons.strokeRoundedUserMultiple,
    HugeIcons.strokeRoundedBodyArmor,
    HugeIcons.strokeRoundedCursorInfo01,
    HugeIcons.strokeRoundedSolarSystem,
    HugeIcons.strokeRoundedMoreHorizontal,
    HugeIcons.strokeRoundedSettings01,
  ];
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final icon = Icon(HugeIcons.strokeRoundedMenu01, size: 20);
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: icon,
    );
    var iconButton = IconButton(
      onPressed: () => handleTap(context),
      icon: padding,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: iconButton,
    );
  }

  void handleTap(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}

class _Tile extends ConsumerWidget {
  final int index;
  const _Tile({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final provider = selectedMenuIndexNotifierProvider;
    final selectedMenuIndex = ref.watch(provider);
    final active = index == selectedMenuIndex;
    final color = active ? primaryContainer : null;
    final icon = Icon(_Icons.icons[index], size: 20);
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: icon,
    );
    var iconButton = IconButton(
      onPressed: () => handlePressed(context, ref),
      icon: padding,
      isSelected: active,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: iconButton,
    );
  }

  void handlePressed(BuildContext context, WidgetRef ref) {
    final provider = selectedMenuIndexNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.select(index);
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
