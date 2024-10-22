import 'package:flutter/material.dart';
import 'package:foxy/widget/card.dart';

class Trend extends StatelessWidget {
  const Trend({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
      _Divider(),
      ListTile(title: Text('新建生物 XXX')),
    ];
    return const FoxyCard(title: Text('动态'), child: Column(children: children));
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    return Divider(color: outline.withOpacity(0.2), height: 1);
  }
}
