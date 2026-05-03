import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FoxyNumberInput<T extends num> extends StatefulWidget {
  final T value;
  final ValueChanged<T>? onChanged;
  final String? placeholder;
  final bool readOnly;

  const FoxyNumberInput({
    super.key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  State<FoxyNumberInput<T>> createState() => _FoxyNumberInputState<T>();
}

class _FoxyNumberInputState<T extends num> extends State<FoxyNumberInput<T>> {
  late final TextEditingController _controller;
  bool _isInternal = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
  }

  @override
  void didUpdateWidget(FoxyNumberInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInternal) return;
    if (widget.value != oldWidget.value) {
      _controller.text = _format(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
    try {
      final v = _parse(text);
      _isInternal = true;
      widget.onChanged?.call(v);
      _isInternal = false;
    } catch (_) {
      // 非法输入暂不处理, save 时由 ViewModel 统一抛异常
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _controller,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: widget.readOnly,
      onChanged: _onChanged,
    );
  }
}
