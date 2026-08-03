/// 转义 LIKE 模式中的通配符,使筛选值按字面量匹配。
///
/// MySQL 默认以 `\` 为转义符(无需 ESCAPE 子句);laconic 只做参数绑定,
/// 不会替调用方转义 `%`/`_`,用户输入含这些字符(如 `100%`)时会被当作
/// 通配符,导致筛选命中大量无关记录。
///
/// 前置条件:MySQL `NO_BACKSLASH_ESCAPES` 必须为 OFF(默认值)。该模式下
/// `\%` 会退化为「字面反斜杠 + 通配符 %」,过滤退化为近似匹配(全部值均
/// 经参数绑定,无注入风险,仅过滤精度受影响)。
String escapeLike(String value) => value
    .replaceAll('\\', '\\\\')
    .replaceAll('%', '\\%')
    .replaceAll('_', '\\_');

/// 浮点字段解析，语义同 [parseIntField]。
double parseDoubleField(String text, {String field = ''}) {
  final s = text.trim();
  if (s.isEmpty) return 0.0;
  final v = double.tryParse(s);
  if (v == null) {
    final label = field.isEmpty ? '数值' : field;
    throw FormatException('invalid number for "$label": $text');
  }
  return v;
}

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
    throw FormatException('invalid integer for "$label": $text');
  }
  return v;
}
