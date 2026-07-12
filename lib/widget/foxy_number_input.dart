import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 数字输入框。
///
/// 传入 ViewModel 持有的 [NumberFieldController]。类型参数 [T] 标识字段数值类型。
class FoxyNumberInput<T extends num> extends StatelessWidget {
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
          FilteringTextInputFormatter.allow(
            _isFloat ? RegExp(r'[0-9.\-]') : RegExp(r'[0-9\-]'),
          ),
        ],
      ),
    );
  }
}
