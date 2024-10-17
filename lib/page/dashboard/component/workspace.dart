import 'package:flutter/material.dart';
import 'package:foxy/page/dashboard/component/frequent_module.dart';
import 'package:foxy/page/dashboard/component/introduction.dart';
import 'package:foxy/page/dashboard/component/trend.dart';
import 'package:foxy/page/dashboard/component/version.dart';

class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    const leftChildren = [
      FrequentModuleComponent(),
      SizedBox(height: 16),
      Trend(),
    ];
    const leftColumn = Column(children: leftChildren);
    const rightChildren = [Introduction(), SizedBox(height: 16), Version()];
    const rightColumn = Column(children: rightChildren);
    const children = [
      Expanded(flex: 3, child: leftColumn),
      SizedBox(width: 16),
      Expanded(flex: 1, child: rightColumn)
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
