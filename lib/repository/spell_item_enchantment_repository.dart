import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellItemEnchantmentRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_spell_item_enchantment';
  static const _spellEffects = [53, 54, 92, 156];

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefSpellItemEnchantmentEntity>> getBriefSpellItemEnchantments({
    int page = 1,
    SpellItemEnchantmentFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select(const [
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

  Future<List<SpellItemEnchantmentEntity>> getSpellItemEnchantments() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellItemEnchantmentEntity.fromJson(row.toMap()))
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
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentEntity.fromJson(results.first.toMap());
  }

  Future<SpellItemEnchantmentEntity> createSpellItemEnchantment() async {
    return SpellItemEnchantmentEntity(id: await _getNextId());
  }

  Future<int> storeSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    final id = spellItemEnchantment.id > 0
        ? spellItemEnchantment.id
        : await _getNextId();
    final stored = spellItemEnchantment.copyWith(id: id);
    await _validateReferences(stored);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    await _validateReferences(spellItemEnchantment);
    final json = spellItemEnchantment.toJson()..remove('ID');
    await laconic
        .table(_table)
        .where('ID', spellItemEnchantment.id)
        .update(json);
  }

  Future<void> destroySpellItemEnchantment(int id) async {
    final references = await _countReferences(id);
    if (references > 0) {
      throw StateError('法术附魔 $id 仍被 $references 条数据引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copySpellItemEnchantment(int id) async {
    final source = await getSpellItemEnchantment(id);
    if (source == null) return;
    await storeSpellItemEnchantment(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    final existing = spellItemEnchantment.id == 0
        ? null
        : await getSpellItemEnchantment(spellItemEnchantment.id);
    if (existing == null) {
      await storeSpellItemEnchantment(spellItemEnchantment);
    } else {
      await updateSpellItemEnchantment(spellItemEnchantment);
    }
  }

  Future<List<DbcLocaleFieldValue>> getSpellItemEnchantmentLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveSpellItemEnchantmentLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0xffff) {
      throw StateError('SpellItemEnchantment ID 已超出客户端可引用范围');
    }
    return id;
  }

  Future<void> _validateReferences(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    if (spellItemEnchantment.srcItemId == 0) return;
    final count = await laconic
        .table('item_template')
        .where('entry', spellItemEnchantment.srcItemId)
        .count();
    if (count == 0) {
      throw StateError(
        'Src_itemID 引用的物品 ${spellItemEnchantment.srcItemId} 不存在',
      );
    }
  }

  Future<int> _countReferences(int id) async {
    final socketBonus = await laconic
        .table('item_template')
        .where('socketBonus', id)
        .count();
    final gems = await laconic
        .table('foxy.dbc_gem_properties')
        .where('Enchant_ID', id)
        .count();
    final procData = await laconic
        .table('spell_enchant_proc_data')
        .where('entry', id)
        .count();
    final spell0 = await laconic
        .table('foxy.dbc_spell')
        .whereIn('Effect0', _spellEffects)
        .where('EffectMiscValue0', id)
        .count();
    final spell1 = await laconic
        .table('foxy.dbc_spell')
        .whereIn('Effect1', _spellEffects)
        .where('EffectMiscValue1', id)
        .count();
    final spell2 = await laconic
        .table('foxy.dbc_spell')
        .whereIn('Effect2', _spellEffects)
        .where('EffectMiscValue2', id)
        .count();
    return socketBonus +
        gems +
        procData +
        spell0 +
        spell1 +
        spell2 +
        await _countRandomPropertyReferences(id) +
        await _countRandomSuffixReferences(id);
  }

  Future<int> _countRandomPropertyReferences(int id) async {
    final enchantment0 = await _countColumnReference(
      'foxy.dbc_item_random_properties',
      'Enchantment0',
      id,
    );
    final enchantment1 = await _countColumnReference(
      'foxy.dbc_item_random_properties',
      'Enchantment1',
      id,
    );
    final enchantment2 = await _countColumnReference(
      'foxy.dbc_item_random_properties',
      'Enchantment2',
      id,
    );
    final enchantment3 = await _countColumnReference(
      'foxy.dbc_item_random_properties',
      'Enchantment3',
      id,
    );
    final enchantment4 = await _countColumnReference(
      'foxy.dbc_item_random_properties',
      'Enchantment4',
      id,
    );
    return enchantment0 +
        enchantment1 +
        enchantment2 +
        enchantment3 +
        enchantment4;
  }

  Future<int> _countRandomSuffixReferences(int id) async {
    final enchantment0 = await _countColumnReference(
      'foxy.dbc_item_random_suffix',
      'Enchantment0',
      id,
    );
    final enchantment1 = await _countColumnReference(
      'foxy.dbc_item_random_suffix',
      'Enchantment1',
      id,
    );
    final enchantment2 = await _countColumnReference(
      'foxy.dbc_item_random_suffix',
      'Enchantment2',
      id,
    );
    final enchantment3 = await _countColumnReference(
      'foxy.dbc_item_random_suffix',
      'Enchantment3',
      id,
    );
    final enchantment4 = await _countColumnReference(
      'foxy.dbc_item_random_suffix',
      'Enchantment4',
      id,
    );
    return enchantment0 +
        enchantment1 +
        enchantment2 +
        enchantment3 +
        enchantment4;
  }

  Future<int> _countColumnReference(String table, String column, int id) {
    return laconic.table(table).where(column, id).count();
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
