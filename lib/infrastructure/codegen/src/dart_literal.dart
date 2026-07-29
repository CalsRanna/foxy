/// 生成 Dart 源码字面量的共享工具。
///
/// Entity、Repository 和 Filter 三个 emitter 都要把常量值写回 Dart 源码，
/// 统一放在这里，避免各自维护一套转义规则。
library;

/// 把 [value] 写成单引号 Dart 字符串字面量（含引号）。
///
/// 同时转义 `$`，否则表名或列名里的 `$` 会在生成代码里变成字符串插值。
String dartStringLiteral(String value) {
  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r')
      .replaceAll('\t', r'\t');
  return "'$escaped'";
}

/// 把常量 [value] 写成 Dart 字面量。
///
/// [asType] 为目标字段类型：`'double'` 时整数常量补成 `1.0` 形式，
/// 使 `double` 字段的默认值不会退化成 `int` 字面量。
String dartLiteral(Object? value, {String? asType}) {
  if (value == null) return 'null';
  if (value is String) return dartStringLiteral(value);
  if (value is bool) return '$value';
  if (value is int) return asType == 'double' ? '$value.0' : '$value';
  if (value is double && value.isFinite) {
    final text = value.toString();
    // `1e-7`、`1e+21` 本身就是合法 double 字面量，只有纯整数形式需要补小数点。
    return RegExp(r'^-?\d+$').hasMatch(text) ? '$text.0' : text;
  }
  throw StateError('Unsupported literal $value (${value.runtimeType})');
}
