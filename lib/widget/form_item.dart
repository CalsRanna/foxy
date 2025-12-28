import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FormItem extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final bool readOnly;

  const FormItem({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading();
    final input = ShadInput(
      controller: controller,
      placeholder: Text(placeholder ?? ''),
      readOnly: readOnly,
      trailing: ShadIconButton.ghost(
        height: 20,
        width: 20,
        icon: Icon(LucideIcons.globe, size: 12),
      ),
    );
    var children = [leading, Expanded(child: input)];
    return Row(spacing: 16, children: children);
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return SizedBox(width: 96, child: Text(label!, textAlign: TextAlign.end));
  }
}
