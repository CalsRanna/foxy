import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:hugeicons/hugeicons.dart';

@RoutePage()
class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;
    final textStyle = TextStyle(
      color: onPrimary,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    );
    final children = [
      Text('MPQ File Ready', style: textStyle),
      const SizedBox(width: 16),
      Text('Dbc File Ready', style: textStyle),
      const SizedBox(width: 16),
      const _MysqlStatus(),
    ];
    const edgeInsets = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
    return Container(
      color: primary,
      padding: edgeInsets,
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: children),
    );
  }
}

class _MysqlStatus extends ConsumerWidget {
  const _MysqlStatus();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onPrimary = colorScheme.onPrimary;
    final errorContainer = colorScheme.errorContainer;
    final provider = mysqlVersionProvider;
    final version = ref.watch(provider).valueOrNull ?? '';
    final connected = version.isNotEmpty;
    final color = connected ? onPrimary : errorContainer;
    final text = connected ? 'Mysql Connected: $version' : 'Mysql Disconnected';
    final textStyle = TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    );
    return Text(text, style: textStyle);
  }
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    const icons = [
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
    final leftBar = ListView.separated(
      itemBuilder: (context, index) => _itemBuilder(context, icons, index),
      itemCount: icons.length,
      padding: EdgeInsets.all(8),
      separatorBuilder: (_, index) => SizedBox(height: 8),
    );
    final children = [
      SizedBox(width: 80, child: leftBar),
      const VerticalDivider(thickness: 1, width: 1),
      Expanded(child: AutoRouter())
    ];
    final rightWorkspace = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final bodyChildren = [Expanded(child: rightWorkspace), const _Indicator()];
    return Scaffold(body: Column(children: bodyChildren));
  }

  void handlePressed(int value) {
    setState(() {
      index = value;
    });
    final route = switch (value) {
      0 => DashboardRoute(),
      1 => CreatureTemplateListRoute(),
      _ => DashboardRoute(),
    };
    AutoRouter.of(context).push(route);
  }

  Widget _itemBuilder(BuildContext context, List<IconData> icons, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryContainer = colorScheme.primaryContainer;
    final color = index == this.index ? primaryContainer : null;
    return IconButton(
      onPressed: () => handlePressed(index),
      icon: Icon(icons[index], size: 20),
      isSelected: index == this.index,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
    );
  }
}
