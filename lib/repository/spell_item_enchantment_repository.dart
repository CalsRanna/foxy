import 'package:foxy/entity/brief_spell_item_enchantment_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellItemEnchantmentRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell_item_enchantment';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copySpellItemEnchantment(int key) async {
    final source = await getSpellItemEnchantment(key);
    if (source == null) {
      throw StateError('原法术附魔不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeSpellItemEnchantment(copied);
    return copied.id;
  }

  Future<int> countSpellItemEnchantments({
    SpellItemEnchantmentFilterEntity? filter,
  }) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<SpellItemEnchantmentEntity> createSpellItemEnchantment() async {
    return SpellItemEnchantmentEntity(id: await _getNextId());
  }

  Future<void> destroySpellItemEnchantment(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术附魔不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellItemEnchantmentEntity>> getBriefSpellItemEnchantments({
    int page = 1,
    SpellItemEnchantmentFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Name_lang_zhCN',
      'Charges',
      'Effect0',
      'Effect1',
      'Effect2',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellItemEnchantmentEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SpellItemEnchantmentEntity?> getSpellItemEnchantment(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getSpellItemEnchantmentLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<SpellItemEnchantmentEntity>> getSpellItemEnchantments() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellItemEnchantmentEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveSpellItemEnchantmentLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    if (spellItemEnchantment.id <= 0) {
      throw StateError('法术附魔 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([spellItemEnchantment.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术附魔 ${spellItemEnchantment.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellItemEnchantment(
    int originalKey,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(spellItemEnchantment.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术附魔不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术附魔 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('SpellItemEnchantment ID 已超出 DBC int32 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
