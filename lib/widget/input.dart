import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? placeholder;
  const Input({super.key, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.25),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: placeholder,
          hintStyle: TextStyle(height: 1.2),
        ),
        style: TextStyle(height: 1.2),
      ),
    );
  }
}
