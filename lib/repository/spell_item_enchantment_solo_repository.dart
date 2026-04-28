import 'package:foxy/model/spell_item_enchantment.dart';
import 'package:foxy/model/spell_item_enchantment_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellItemEnchantmentSoloRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell_item_enchantment';

  Future<List<SpellItemEnchantment>> getSpellItemEnchantments({
    int page = 1,
    SpellItemEnchantmentFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => SpellItemEnchantment.fromJson(e.toMap())).toList();
  }

  Future<int> countSpellItemEnchantments({SpellItemEnchantmentFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellItemEnchantment?> getSpellItemEnchantment(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return SpellItemEnchantment.fromJson(result.toMap());
  }

  Future<void> storeSpellItemEnchantment(SpellItemEnchantment entry) async {
    var json = entry.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateSpellItemEnchantment(SpellItemEnchantment entry) async {
    var json = entry.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', entry.id).update(json);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, SpellItemEnchantmentFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
