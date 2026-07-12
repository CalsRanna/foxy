import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 数字输入框。
///
/// 传入 VM 持有的 [controller]，与文本框/下拉框保持一致的 Listenable 模式：
/// VM 在 `_initControllers` 里写入 `.text`，在 `save` 时用 [parseIntField]/
/// [parseDoubleField] 读取。输入不会实时回传 VM。
///
/// 类型参数 [T] 标识该字段的数值类型。键盘与输入过滤尽量约束为数字，
/// 但最终合法性仍由 ViewModel 在保存时校验（非法输入必须阻止保存）。
class FoxyNumberInput<T extends num> extends StatelessWidget {
  final TextEditingController controller;
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
    return ShadInput(
      controller: controller,
      placeholder: Text(placeholder ?? ''),
      readOnly: readOnly,
      keyboardType: TextInputType.numberWithOptions(
        decimal: _isFloat,
        signed: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          _isFloat ? RegExp(r'[0-9.\-]') : RegExp(r'[0-9\-]'),
        ),
      ],
    );
  }
}
