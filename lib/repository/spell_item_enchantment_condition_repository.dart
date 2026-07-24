import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_item_enchantment_condition_repository.g.dart';

@FoxyRepository(SpellItemEnchantmentConditionEntity)
@FoxyFilter.text('id')
class SpellItemEnchantmentConditionRepository
    with RepositoryMixin, _SpellItemEnchantmentConditionRepositoryMixin {
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
    SpellItemEnchantmentConditionFilter? filter,
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

  Future<List<BriefSpellItemEnchantmentConditionEntity>>
  getBriefSpellItemEnchantmentConditions({
    int page = 1,
    SpellItemEnchantmentConditionFilter? filter,
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

  Future<List<SpellItemEnchantmentConditionEntity>>
  getSpellItemEnchantmentConditions() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellItemEnchantmentConditionEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentConditionFilter? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
