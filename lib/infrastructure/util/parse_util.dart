/// 表单数字字段解析。
///
/// - 空字符串视为 `0`（与游戏数据默认值一致）
/// - 非法输入（如 `12a`）抛出 [FormatException]，调用方应阻止保存
int parseIntField(String text, {String field = ''}) {
  final s = text.trim();
  if (s.isEmpty) return 0;
  final v = int.tryParse(s);
  if (v == null) {
    final label = field.isEmpty ? '数值' : field;
    throw FormatException('「$label」不是有效整数：$text');
  }
  return v;
}

/// 浮点字段解析，语义同 [parseIntField]。
double parseDoubleField(String text, {String field = ''}) {
  final s = text.trim();
  if (s.isEmpty) return 0.0;
  final v = double.tryParse(s);
  if (v == null) {
    final label = field.isEmpty ? '数值' : field;
    throw FormatException('「$label」不是有效数字：$text');
  }
  return v;
}
