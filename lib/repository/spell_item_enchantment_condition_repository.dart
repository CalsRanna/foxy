import 'package:foxy/entity/brief_spell_item_enchantment_condition_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellItemEnchantmentConditionRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_item_enchantment_condition';

  Future<int> copySpellItemEnchantmentCondition(int key) async {
    final source = await getSpellItemEnchantmentCondition(key);
    if (source == null) {
      throw StateError('原法术附魔条件不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpellItemEnchantmentCondition(copied);
    return copied.id;
  }

  Future<int> countSpellItemEnchantmentConditions({
    SpellItemEnchantmentConditionFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellItemEnchantmentConditionEntity>
  createSpellItemEnchantmentCondition() async {
    return SpellItemEnchantmentConditionEntity(
      id: await nextMaxPlusOne(_table, 'ID'),
    );
  }

  Future<void> destroySpellItemEnchantmentCondition(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术附魔条件不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellItemEnchantmentConditionEntity>>
  getBriefSpellItemEnchantmentConditions({
    int page = 1,
    SpellItemEnchantmentConditionFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select(const ['ID']);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (row) =>
              BriefSpellItemEnchantmentConditionEntity.fromJson(row.toMap()),
        )
        .toList();
  }

  Future<SpellItemEnchantmentConditionEntity?> getSpellItemEnchantmentCondition(
    int key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentConditionEntity.fromJson(results.first.toMap());
  }

  Future<List<SpellItemEnchantmentConditionEntity>>
  getSpellItemEnchantmentConditions() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellItemEnchantmentConditionEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeSpellItemEnchantmentCondition(
    SpellItemEnchantmentConditionEntity entity,
  ) async {
    if (entity.id <= 0) {
      throw StateError('法术附魔条件 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术附魔条件 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellItemEnchantmentCondition(
    int originalKey,
    SpellItemEnchantmentConditionEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术附魔条件不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术附魔条件 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentConditionFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
