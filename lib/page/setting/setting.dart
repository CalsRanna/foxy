import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/card.dart';
import 'package:foxy/widget/header.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var children = [_Breadcrumb(), _Header(), _Setting()];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }
}

class _Breadcrumb extends ConsumerWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboard = FoxyBreadcrumbItem(
      onTap: () => navigateDashboard(context, ref),
      child: Text('首页'),
    );
    final children = [
      dashboard,
      FoxyBreadcrumbItem(child: Text('设置')),
    ];
    return FoxyBreadcrumb(children: children);
  }

  void navigateDashboard(BuildContext context, WidgetRef ref) {
    final provider = selectedMenuIndexNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.select(0);
    AutoRouter.of(context).navigate(DashboardRoute());
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('设置'));
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

class _Setting extends StatelessWidget {
  const _Setting();

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
    return FoxyCard(child: padding);
  }
}
