import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 数字输入框。
///
/// 传入 ViewModel 持有的 [NumberFieldController]。类型参数 [T] 标识字段数值类型。
class FoxyNumberInput<T extends num> extends StatelessWidget {
  // RegExp 构造即编译,详情大表单(如 spell 67 个、creature 50 个输入框)
  // 每帧 build 重建会重复编译,提取为 static final 复用。
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
