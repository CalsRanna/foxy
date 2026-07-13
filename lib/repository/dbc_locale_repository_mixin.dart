import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';

/// DBC 宽表本地化字段的加载/局部更新实现。
///
/// 各 DBC Repository 混入本 mixin，并对外暴露本表命名的
/// `get*Locales` / `save*Locales` 方法；页面不得绕过 Repository 直接操作 Laconic。
mixin DbcLocaleRepositoryMixin on RepositoryMixin {
  /// 全限定表名，如 `foxy.dbc_spell`。
  String get dbcLocaleTableName;

  /// 去掉 `foxy.` 前缀后的表名，与 [DbcLocaleFieldDefinition.tableName] 对齐。
  String get _unqualifiedDbcTableName {
    final name = dbcLocaleTableName;
    const prefix = 'foxy.';
    return name.startsWith(prefix) ? name.substring(prefix.length) : name;
  }

  /// 加载指定记录上某个本地化字段的 16 个语言值。
  ///
  /// 记录不存在时抛出 [StateError]，避免用空值掩盖错误 ID。
  Future<List<DbcLocaleFieldValue>> loadDbcLocaleField(
    int id,
    DbcLocaleFieldDefinition field,
  ) async {
    _ensureFieldBelongsToTable(field);
    final results = await laconic
        .table(dbcLocaleTableName)
        .select(field.columnNames)
        .where('ID', id)
        .limit(1)
        .get();
    if (results.isEmpty) {
      throw StateError('DBC 记录不存在: $dbcLocaleTableName ID=$id');
    }
    return DbcLocaleFieldCodec.decode(field, results.first.toMap());
  }

  /// 局部更新指定本地化字段的 16 个语言列（不改 Flags 与其它字段）。
  ///
  /// 更新前校验字段属于本表且记录存在；laconic 的 update 不返回受影响行数，
  /// 因此以存在性检查代替 0 行 UPDATE 的静默成功。
  Future<void> storeDbcLocaleField(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> values,
  ) async {
    _ensureFieldBelongsToTable(field);
    await _ensureRecordExists(id);
    final update = DbcLocaleFieldCodec.encode(field, values);
    await laconic.table(dbcLocaleTableName).where('ID', id).update(update);
  }

  void _ensureFieldBelongsToTable(DbcLocaleFieldDefinition field) {
    final expected = _unqualifiedDbcTableName;
    if (field.tableName != expected && field.tableName != dbcLocaleTableName) {
      throw ArgumentError(
        '字段 ${field.columnPrefix} 属于表 ${field.tableName}，'
        '与当前 Repository 表 $dbcLocaleTableName 不匹配',
      );
    }
  }

  Future<void> _ensureRecordExists(int id) async {
    final count = await laconic
        .table(dbcLocaleTableName)
        .where('ID', id)
        .count();
    if (count == 0) {
      throw StateError('DBC 记录不存在，无法保存本地化: $dbcLocaleTableName ID=$id');
    }
  }
}
