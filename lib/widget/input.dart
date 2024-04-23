import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key, this.controller, this.placeholder});

  final TextEditingController? controller;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.25),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration.collapsed(
          hintText: placeholder ?? '请输入',
          hintStyle: const TextStyle(height: 1.2),
        ),
        style: const TextStyle(height: 1.2),
      ),
    );
  }
}
