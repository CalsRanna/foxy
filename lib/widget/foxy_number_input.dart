import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 数字输入框。
///
/// 有两种用法（二选一）：
/// - **推荐（路线 A）**：传入 VM 持有的 [controller]，与文本框/下拉框保持一致的
///   Listenable 模式。VM 在 `_initControllers` 里写入 `.text`，在 `save` 时自行
///   `int.tryParse`/`double.tryParse` 读取。该模式下输入不会实时回传 VM。
/// - 过渡期保留：传入 [value] + [onChanged]，由 widget 内部持有 controller 并在
///   值变化时回传。剩余模块迁移完成后会移除该模式。
///
/// 类型参数 [T] 标识该字段的数值类型，供调用方与 VM 在保存时据以 parse。
class FoxyNumberInput<T extends num> extends StatefulWidget {
  final TextEditingController? controller;

  final T? value;
  final ValueChanged<T>? onChanged;

  final String? placeholder;
  final bool readOnly;

  const FoxyNumberInput({
    super.key,
    this.controller,
    this.value,
    this.onChanged,
    this.placeholder,
    this.readOnly = false,
  }) : assert(
          controller != null || value != null,
          'FoxyNumberInput 必须提供 controller 或 value',
        );

  @override
  State<FoxyNumberInput<T>> createState() => _FoxyNumberInputState<T>();
}

class _FoxyNumberInputState<T extends num> extends State<FoxyNumberInput<T>> {
  TextEditingController? _internalController;
  bool _isInternal = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController(
        text: _format(widget.value as T),
      );
    }
  }

  @override
  void didUpdateWidget(FoxyNumberInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 仅旧 API（value/onChanged）模式下需要同步内部 controller。
    if (widget.controller == null &&
        widget.value != null &&
        widget.value != oldWidget.value) {
      _effectiveController.text = _format(widget.value as T);
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  String _format(T value) {
    if (T == double) {
      final s = value.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return value.toString();
  }

  T _parse(String text) {
    if (text.isEmpty) return (T == double ? 0.0 : 0) as T;
    if (T == double) {
      final v = double.tryParse(text);
      if (v != null) return v as T;
    } else {
      final v = int.tryParse(text);
      if (v != null) return v as T;
    }
    throw Exception('输入值 "$text" 不是有效数字');
  }

  void _onChanged(String text) {
    if (_isInternal) return;
    if (widget.onChanged == null) return;
    try {
      final v = _parse(text);
      _isInternal = true;
      widget.onChanged!.call(v);
      _isInternal = false;
    } catch (_) {
      // 非法输入暂不处理, save 时由 ViewModel 统一抛异常
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _effectiveController,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: widget.readOnly,
      onChanged: widget.onChanged == null ? null : _onChanged,
    );
  }
}
