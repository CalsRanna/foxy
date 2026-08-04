import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// String input.
class FoxyStringInput extends StatelessWidget {
  final StringFieldController controller;
  final String? placeholder;
  final bool readOnly;
  final bool obscureText;

  /// Maximum input length (aligned with the target column width); null =
  /// unlimited.
  /// MySQL non-strict mode silently truncates overlong values and corrupts
  /// data; long text fields should set this to the column width.
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
