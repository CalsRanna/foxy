/// Shared utilities for generating Dart source literals.
///
/// The Entity, Repository and Filter emitters all write constant values back
/// into Dart source; kept here in one place so each emitter does not maintain
/// its own escaping rules.
library;

import 'package:source_gen/source_gen.dart';

/// Writes the constant [value] as a Dart literal.
///
/// [asType] is the target field type: when `'double'`, integer constants are
/// completed as `1.0` so a `double` field's default never degrades to an int
/// literal.
String dartLiteral(Object? value, {String? asType}) {
  if (value == null) return 'null';
  if (value is String) return dartStringLiteral(value);
  if (value is bool) return '$value';
  if (value is int) return asType == 'double' ? '$value.0' : '$value';
  if (value is double && value.isFinite) {
    final text = value.toString();
    // `1e-7` / `1e+21` are already valid double literals; only pure integer
    // forms need a decimal point.
    return RegExp(r'^-?\d+$').hasMatch(text) ? '$text.0' : text;
  }
  throw InvalidGenerationSourceError(
    'Unsupported literal $value (${value.runtimeType})',
  );
}

/// Writes [value] as a single-quoted Dart string literal (quotes included).
///
/// Also escapes `$`, otherwise `$` in table or column names would become
/// string interpolation in the generated code.
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
