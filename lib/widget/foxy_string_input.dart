import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 字符串输入框。
class FoxyStringInput extends StatelessWidget {
  final StringFieldController controller;
  final String? placeholder;
  final bool readOnly;
  final bool obscureText;

  /// 输入长度上限(与目标列宽对齐);null = 不限。
  /// MySQL 非严格模式会静默截断超长值写坏数据,长文本字段应按列宽设置。
  final int? maxLength;

  const FoxyStringInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final readonly = FoxyReadonlyInput.resolve(context, readOnly: readOnly);
    return readonly.wrap(
      ShadInput(
        controller: controller.controller,
        placeholder: Text(placeholder ?? ''),
        readOnly: readOnly,
        obscureText: obscureText,
        maxLength: maxLength,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
      ),
    );
  }
}
