import 'package:foxy/entity/dbc_locale.dart';

/// 宽表 16 语言列 ↔ 编辑器 16 行值 的双向 Codec。
///
/// - 只处理当前字段组的 16 个字符串列。
/// - 不读取/修改 `${columnPrefix}_Flags` 或其它字段。
class DbcLocaleFieldCodec {
  const DbcLocaleFieldCodec._();

  /// 生成 16 个空值行（固定顺序）。
  static List<DbcLocaleFieldValue> empty() {
    return [
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(locale: locale, value: ''),
    ];
  }

  /// 从数据库行解码为固定顺序的 16 个 [DbcLocaleFieldValue]。
  static List<DbcLocaleFieldValue> decode(
    DbcLocaleFieldDefinition field,
    Map<String, dynamic> row,
  ) {
    return [
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(
          locale: locale,
          value: _asString(row[field.columnFor(locale)]),
        ),
    ];
  }

  /// 将 16 行编辑结果编码为仅含当前字段组语言列的更新 Map。
  ///
  /// 拒绝长度不对、重复或顺序非法的数据。
  static Map<String, dynamic> encode(
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> values,
  ) {
    if (values.length != DbcLocale.values.length) {
      throw ArgumentError(
        '期望 ${DbcLocale.values.length} 个语言值，实际 ${values.length}',
      );
    }

    final seen = <int>{};
    final map = <String, dynamic>{};

    for (var i = 0; i < values.length; i++) {
      final item = values[i];
      final expected = DbcLocale.values[i];
      if (item.locale.index != expected.index) {
        throw ArgumentError(
          '语言顺序非法：索引 $i 期望 ${expected.code}，实际 ${item.locale.code}',
        );
      }
      if (!seen.add(item.locale.index)) {
        throw ArgumentError('重复语言槽位: ${item.locale.code}');
      }
      map[field.columnFor(item.locale)] = item.value;
    }

    return map;
  }

  static String _asString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
