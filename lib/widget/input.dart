import 'package:flutter/material.dart';

class FoxyInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;

  const FoxyInput({
    super.key,
    this.controller,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline;
    final surfaceContainer = colorScheme.surfaceContainer;
    final boxDecoration = BoxDecoration(
      border: Border.all(color: outline.withOpacity(0.25)),
      borderRadius: BorderRadius.circular(8),
      color: readOnly ? surfaceContainer : null,
    );
    final inputDecoration = InputDecoration.collapsed(
      hintText: placeholder ?? '请输入',
      hintStyle: const TextStyle(height: 1.2),
    );
    final textField = TextField(
      controller: controller,
      decoration: inputDecoration,
      readOnly: readOnly,
      style: const TextStyle(height: 1.2),
    );
    const edgeInsets = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
    return Container(
      decoration: boxDecoration,
      padding: edgeInsets,
      child: textField,
    );
  }
}
