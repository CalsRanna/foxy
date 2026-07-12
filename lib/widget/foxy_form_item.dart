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
    this.label,
    this.placeholder,
    this.readOnly = false,
    required Widget this.child,
  }) : controller = null;

  /// 其他模块迁移到显式输入组件之前保留的兼容入口。
  @Deprecated('请通过 FoxyFormItem.child 显式传入输入组件')
  const FoxyFormItem.legacy({
    super.key,
    required this.controller,
    this.label,
    this.placeholder,
    this.readOnly = false,
  }) : child = null;

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading();
    final content = child ?? _buildLegacyInput(context);
    return Row(
      spacing: 16,
      children: [
        leading,
        Expanded(child: content),
      ],
    );
  }

  Widget _buildLegacyInput(BuildContext context) {
    final readonly = FoxyReadonlyInput.resolve(context, readOnly: readOnly);
    // mouseCursor 仍传给 ShadInput 作为兜底；真正生效依赖 wrap 外侧 MouseRegion。
    return readonly.wrap(
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
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return SizedBox(width: 96, child: Text(label!, textAlign: TextAlign.end));
  }
}
