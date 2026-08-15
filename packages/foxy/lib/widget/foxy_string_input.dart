import 'package:flutter/material.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// String input.
class FoxyStringInput extends StatelessWidget {
  final StringFieldController controller;
  final String? placeholder;
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
    this.obscureText = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller.controller,
      placeholder: Text(placeholder ?? ''),
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
