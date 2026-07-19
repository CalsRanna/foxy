import 'package:flutter/foundation.dart';

/// 普通数据库 locale 编辑行。
///
/// [originalLocale] 是已有行打开编辑器时的 locale；新增行为 null。即使用户修改
/// [values] 中的 locale，它也保持不变，供领域 Delegate 构造原始强类型 Key。
@immutable
final class DatabaseLocaleRow {
  final String? originalLocale;
  final Map<String, String> values;

  const DatabaseLocaleRow({required this.originalLocale, required this.values});

  factory DatabaseLocaleRow.persisted(Map<String, String> values) {
    return DatabaseLocaleRow(
      originalLocale: values['locale'],
      values: Map.unmodifiable(values),
    );
  }
}

@immutable
final class DatabaseLocaleChanges {
  final List<DatabaseLocaleRow> rows;
  final List<String> deletedLocales;

  const DatabaseLocaleChanges({
    required this.rows,
    required this.deletedLocales,
  });
}
