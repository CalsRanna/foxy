import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  final List<Widget> children;
  const Breadcrumb({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    final seperator = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Text('/'),
    );
    for (var i = 0; i < children.length; i++) {
      if (i < children.length - 1) {
        items.add(
          InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: children[i],
            ),
          ),
        );
        items.add(seperator);
      } else {
        items.add(children[i]);
      }
    }
    return Row(children: items);
  }
}
