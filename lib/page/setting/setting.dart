import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/card.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      SizedBox(width: 120, child: _Menu()),
      const VerticalDivider(thickness: 1, width: 1),
      const SizedBox(width: 16),
      Expanded(child: AutoRouter()),
    ];
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final padding = Padding(padding: const EdgeInsets.all(16.0), child: row);
    return ListView(
      padding: EdgeInsets.all(16),
      children: [FoxyCard(child: padding)],
    );
  }
}

class _Menu extends StatefulWidget {
  const _Menu();

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final basic = ListTile(
      onTap: () => handleTap(0),
      selected: index == 0,
      selectedTileColor: primaryContainer,
      title: const Text('基本设置'),
    );
    final software = ListTile(
      onTap: () => handleTap(1),
      selected: index == 1,
      selectedTileColor: primaryContainer,
      title: const Text('软件设置'),
    );
    final changelog = ListTile(
      onTap: () => handleTap(2),
      selected: index == 2,
      selectedTileColor: primaryContainer,
      title: const Text('更新日志'),
    );
    return Column(children: [basic, software, changelog]);
  }

  void handleTap(int value) {
    setState(() {
      index = value;
    });
    final route = switch (value) {
      0 => BasicSettingRoute(),
      _ => DashboardRoute(),
    };
    AutoRouter.of(context).navigate(route);
  }
}
