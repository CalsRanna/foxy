import 'package:flutter/material.dart';
import 'package:foxy/widget/card.dart';

class Trend extends StatelessWidget {
  const Trend({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
      Divider(),
      ListTile(title: Text('新建生物 XXX')),
    ];
    return const FoxyCard(title: Text('动态'), child: Column(children: children));
  }
}
