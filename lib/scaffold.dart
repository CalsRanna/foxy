import 'package:flutter/material.dart';
import 'package:foxy/router/router.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key, required this.child});

  final Widget child;

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final outline = colorScheme.outline.withOpacity(0.85);
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: Icon(
                  Icons.dashboard_outlined,
                  color: index == 0 ? primary : outline,
                ),
                label: const Text('首页'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.people_outline,
                  color: index == 1 ? primary : outline,
                ),
                label: const Text('生物'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.category_outlined,
                  color: index == 2 ? primary : outline,
                ),
                label: const Text('物品'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.explore_outlined,
                  color: index == 3 ? primary : outline,
                ),
                label: const Text('游戏对象'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.emoji_events_outlined,
                  color: index == 4 ? primary : outline,
                ),
                label: const Text('任务'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: index == 5 ? primary : outline,
                ),
                label: const Text('对话'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.data_object_outlined,
                  color: index == 6 ? primary : outline,
                ),
                label: const Text('内建脚本'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.auto_awesome_outlined,
                  color: index == 7 ? primary : outline,
                ),
                label: const Text('法术'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.more_horiz_outlined,
                  color: index == 8 ? primary : outline,
                ),
                label: const Text('更多'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  color: index == 9 ? primary : outline,
                ),
                label: const Text('设置'),
              ),
            ],
            labelType: NavigationRailLabelType.all,
            selectedIndex: index,
            onDestinationSelected: handleSelected,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.child,
            ),
          )
        ],
      ),
    );
  }

  void handleSelected(int value) {
    if (value == index) return;
    if (value == 0) {
      const DashboardRoute().go(context);
    } else if (value == 1) {
      const CreatureTemplatesRoute().go(context);
    } else if (value == 9) {
      const SettingRoute().go(context);
    }
    setState(() {
      index = value;
    });
  }
}
