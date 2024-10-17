import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:hugeicons/hugeicons.dart';

class LeftBar extends StatelessWidget {
  const LeftBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) => _Tile(index: index),
      itemCount: _Icons.icons.length,
      padding: EdgeInsets.all(8),
      separatorBuilder: (_, index) => SizedBox(height: 8),
    );
  }
}

class _Icons {
  static const icons = [
    HugeIcons.strokeRoundedDashboardCircle,
    HugeIcons.strokeRoundedUserMultiple,
    HugeIcons.strokeRoundedBodyArmor,
    HugeIcons.strokeRoundedCube,
    HugeIcons.strokeRoundedCursorInfo01,
    HugeIcons.strokeRoundedBubbleChat,
    HugeIcons.strokeRoundedCode,
    HugeIcons.strokeRoundedSolarSystem,
    HugeIcons.strokeRoundedNanoTechnology,
    HugeIcons.strokeRoundedLayers01,
    HugeIcons.strokeRoundedMoreHorizontal,
    HugeIcons.strokeRoundedSettings01,
  ];
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
    return IconButton(
      onPressed: () => handlePressed(context, ref),
      icon: icon,
      isSelected: active,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
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
      3 => GameObjectTemplateListRoute(),
      4 => QuestTemplateListRoute(),
      5 => GossipMenuListRoute(),
      6 => SmartScriptListRoute(),
      11 => BasicSettingRoute(),
      _ => DashboardRoute(),
    };
    AutoRouter.of(context).navigate(route);
  }
}
