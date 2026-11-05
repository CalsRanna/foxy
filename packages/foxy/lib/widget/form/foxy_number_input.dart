import 'package:flutter/material.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Number input.
///
/// Takes the [NumberFieldController] held by the ViewModel. Type parameter
/// [T] identifies the field's numeric type.
class FoxyNumberInput<T extends num> extends StatelessWidget {
  final NumberFieldController<T> controller;
  final String? placeholder;

  const FoxyNumberInput({
    super.key,
    required this.controller,
    this.placeholder,
  });

  bool get _isFloat => T == double;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller.controller,
      placeholder: Text(placeholder ?? ''),
      keyboardType: TextInputType.numberWithOptions(
        decimal: _isFloat,
        signed: true,
      ),
    );
  }
}
