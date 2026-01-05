import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FormItem extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final bool readOnly;
  final Widget? child;

  const FormItem({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.readOnly = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading();
    final input = ShadInput(
      controller: controller,
      placeholder: Text(placeholder ?? ''),
      readOnly: readOnly,
    );
    var children = [leading, Expanded(child: child ?? input)];
    return Row(spacing: 16, children: children);
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return SizedBox(width: 96, child: Text(label!, textAlign: TextAlign.end));
  }
}
