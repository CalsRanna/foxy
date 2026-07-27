import 'package:flutter/material.dart';

/// 表单行：左侧标签 + 右侧输入组件。
///
/// 只负责布局，不创建输入框、不持有 Controller。
class FoxyFormItem extends StatelessWidget {
  static const _maxLabelWidth = 12;

  final String? label;
  final Widget child;

  const FoxyFormItem({super.key, this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    assert(
      _labelWidth(label) <= _maxLabelWidth,
      'FoxyFormItem label must not exceed the width of 6 Chinese characters: '
      '$label',
    );
    return Row(
      spacing: 16,
      children: [
        _buildLeading(),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return SizedBox(width: 96, child: Text(label!, textAlign: TextAlign.end));
  }

  static int _labelWidth(String? label) {
    if (label == null) return 0;
    return label.runes.fold(0, (width, rune) {
      if (_isWhitespace(rune)) return width;
      return width + (_isWideCharacter(rune) ? 2 : 1);
    });
  }

  static bool _isWhitespace(int rune) {
    return rune == 0x20 || rune == 0x09 || rune == 0x0A || rune == 0x0D;
  }

  static bool _isWideCharacter(int rune) {
    return (rune >= 0x3400 && rune <= 0x4DBF) ||
        (rune >= 0x4E00 && rune <= 0x9FFF) ||
        (rune >= 0xF900 && rune <= 0xFAFF) ||
        (rune >= 0x20000 && rune <= 0x2FA1F) ||
        (rune >= 0x3000 && rune <= 0x303F) ||
        (rune >= 0xFF01 && rune <= 0xFF60);
  }
}
