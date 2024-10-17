import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/scaffold/component/left_bar.dart';
import 'package:foxy/page/scaffold/component/status.dart';

@RoutePage()
class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      SizedBox(width: 80, child: LeftBar()),
      const VerticalDivider(thickness: 1, width: 1),
      Expanded(child: AutoRouter())
    ];
    final rightWorkspace = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final bodyChildren = [Expanded(child: rightWorkspace), const Status()];
    return Scaffold(body: Column(children: bodyChildren));
  }
}
