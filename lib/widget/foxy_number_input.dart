import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 数字输入框。
///
/// 传入 VM 持有的 [controller]，与文本框/下拉框保持一致的 Listenable 模式：
/// VM 在 `_initControllers` 里写入 `.text`，在 `save` 时自行 `int.tryParse`/
/// `double.tryParse` 读取。输入不会实时回传 VM。
///
/// 类型参数 [T] 标识该字段的数值类型，供调用方与 VM 在保存时据以 parse。
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

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller,
      placeholder: Text(placeholder ?? ''),
      readOnly: readOnly,
    );
  }
}
