import 'package:flutter/material.dart';

class FoxyHeader extends StatelessWidget {
  final String title;
  const FoxyHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return Text(title, style: textStyle);
  }
}
