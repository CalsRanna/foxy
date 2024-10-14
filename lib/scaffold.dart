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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                    ],
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: widget.child)
              ],
            ),
          ),
          const _Indicator(),
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
      Text('Mysql Connected: 8.0.32', style: textStyle),
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
