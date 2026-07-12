import 'package:flutter/material.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 字符串输入框。
class FoxyStringInput extends StatelessWidget {
  final StringFieldController controller;
  final String? placeholder;
  final bool readOnly;

  const FoxyStringInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final readonly = FoxyReadonlyInput.resolve(
      context,
      readOnly: readOnly,
    );
    return readonly.wrap(
      ShadInput(
        controller: controller.controller,
        placeholder: Text(placeholder ?? ''),
        readOnly: readOnly,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
      ),
    );
  }
}
