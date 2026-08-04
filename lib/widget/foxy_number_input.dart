import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Number input.
///
/// Takes the [NumberFieldController] held by the ViewModel. Type parameter
/// [T] identifies the field's numeric type.
class FoxyNumberInput<T extends num> extends StatelessWidget {
  // RegExp construction compiles; big detail forms (e.g. spell with 67,
  // creature with 50 inputs) rebuild every frame, so hoisted to static
  // final for reuse.
  static final _floatRegExp = RegExp(r'[0-9.\-]');
  static final _intRegExp = RegExp(r'[0-9\-]');
  static final _floatFormatter =
      FilteringTextInputFormatter.allow(_floatRegExp);
  static final _intFormatter = FilteringTextInputFormatter.allow(_intRegExp);

  final NumberFieldController<T> controller;
  final String? placeholder;
  final bool readOnly;

  const FoxyNumberInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.readOnly = false,
  });

  bool get _isFloat => T == double;

  @override
  Widget build(BuildContext context) {
    final readonly = FoxyReadonlyInput.resolve(context, readOnly: readOnly);
    return readonly.wrap(
      ShadInput(
        controller: controller.controller,
        placeholder: Text(placeholder ?? ''),
        readOnly: readOnly,
        style: readonly.style,
        decoration: readonly.decoration,
        mouseCursor: readonly.mouseCursor,
        showCursor: readonly.showCursor,
        keyboardType: TextInputType.numberWithOptions(
          decimal: _isFloat,
          signed: true,
        ),
        inputFormatters: [
          _isFloat ? _floatFormatter : _intFormatter,
        ],
      ),
    );
  }
}
