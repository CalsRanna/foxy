import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellItemEnchantmentSoloRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_item_enchantment';

  Future<List<BriefSpellItemEnchantmentEntity>> getBriefSpellItemEnchantments({
    int page = 1,
    SpellItemEnchantmentFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Name_lang_zhCN',
      'Charges',
      'Effect0',
      'Effect1',
      'Effect2',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellItemEnchantmentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellItemEnchantmentEntity>> getSpellItemEnchantments() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => SpellItemEnchantmentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countSpellItemEnchantments({
    SpellItemEnchantmentFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellItemEnchantmentEntity?> getSpellItemEnchantment(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentEntity.fromJson(results.first.toMap());
  }

  Future<SpellItemEnchantmentEntity> createSpellItemEnchantment() async {
    return const SpellItemEnchantmentEntity();
  }

  Future<int> storeSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    var json = spellItemEnchantment.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    var json = spellItemEnchantment.toJson();
    json.remove('ID');
    await laconic
        .table(_table)
        .where('ID', spellItemEnchantment.id)
        .update(json);
  }

  Future<void> destroySpellItemEnchantment(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copySpellItemEnchantment(int id) async {
    var source = await getSpellItemEnchantment(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    if (spellItemEnchantment.id == 0) {
      await storeSpellItemEnchantment(spellItemEnchantment);
      return;
    }
    var existing = await getSpellItemEnchantment(spellItemEnchantment.id);
    if (existing != null) {
      await updateSpellItemEnchantment(spellItemEnchantment);
    } else {
      await laconic.table(_table).insert([spellItemEnchantment.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
