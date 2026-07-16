import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellItemEnchantmentConditionRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_item_enchantment_condition';

  Future<void> copySpellItemEnchantmentCondition(int id) async {
    final source = await getSpellItemEnchantmentCondition(id);
    if (source == null) return;
    await storeSpellItemEnchantmentCondition(
      source.copyWith(id: await nextMaxPlusOne(_table, 'ID')),
    );
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

  Future<void> destroySpellItemEnchantmentCondition(int id) async {
    final references = await laconic
        .table('foxy.dbc_spell_item_enchantment')
        .where('Condition_ID', id)
        .count();
    if (references > 0) {
      throw StateError('附魔条件 $id 仍被 $references 条法术附魔引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
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
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveSpellItemEnchantmentCondition(
    SpellItemEnchantmentConditionEntity entity,
  ) async {
    final existing = entity.id == 0
        ? null
        : await getSpellItemEnchantmentCondition(entity.id);
    if (existing == null) {
      await storeSpellItemEnchantmentCondition(entity);
    } else {
      await updateSpellItemEnchantmentCondition(entity);
    }
  }

  Future<int> storeSpellItemEnchantmentCondition(
    SpellItemEnchantmentConditionEntity entity,
  ) async {
    final id = entity.id > 0 ? entity.id : await nextMaxPlusOne(_table, 'ID');
    final stored = entity.copyWith(id: id);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateSpellItemEnchantmentCondition(
    SpellItemEnchantmentConditionEntity entity,
  ) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
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
}
