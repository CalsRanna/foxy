import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FoxyFormItem extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final bool readOnly;
  final Widget? child;

  const FoxyFormItem({
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
    final readonly = FoxyReadonlyInput.resolve(context, readOnly: readOnly);
    // mouseCursor 仍传给 ShadInput 作为兜底；真正生效依赖 wrap 外侧 MouseRegion。
    final input = readonly.wrap(
      ShadInput(
        controller: controller,
        placeholder: Text(placeholder ?? ''),
        readOnly: readOnly,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
      ),
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
