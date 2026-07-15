import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/gem_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GemPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_gem_properties';

  Future<List<BriefGemPropertyEntity>> getBriefGemProperties({
    int page = 1,
    GemPropertyFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Enchant_ID',
      'Maxcount_inv',
      'Maxcount_item',
      'Type',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGemPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GemPropertyEntity>> getGemProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GemPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countGemProperties({GemPropertyFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GemPropertyEntity?> getGemProperty(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return GemPropertyEntity.fromJson(results.first.toMap());
  }

  Future<GemPropertyEntity> createGemProperty() async {
    return GemPropertyEntity(id: await _getNextId());
  }

  Future<int> storeGemProperty(GemPropertyEntity gemProperty) async {
    final id = gemProperty.id > 0 ? gemProperty.id : await _getNextId();
    final stored = gemProperty.copyWith(id: id);
    await _validateEnchantReference(stored, preserveExisting: false);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateGemProperty(GemPropertyEntity gemProperty) async {
    await _validateEnchantReference(gemProperty, preserveExisting: true);
    final json = gemProperty.toJson()..remove('ID');
    await laconic.table(_table).where('ID', gemProperty.id).update(json);
  }

  Future<void> destroyGemProperty(int id) async {
    final references = await laconic
        .table('item_template')
        .where('GemProperties', id)
        .count();
    if (references > 0) {
      throw StateError('宝石属性 $id 仍被 $references 个物品模板引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyGemProperty(int id) async {
    var source = await getGemProperty(id);
    if (source == null) return;
    await storeGemProperty(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveGemProperty(GemPropertyEntity gemProperty) async {
    final existing = gemProperty.id == 0
        ? null
        : await getGemProperty(gemProperty.id);
    if (existing == null) {
      await storeGemProperty(gemProperty);
    } else {
      await updateGemProperty(gemProperty);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('GemProperties ID 已超出 DBC int32 范围');
    }
    return id;
  }

  Future<void> _validateEnchantReference(
    GemPropertyEntity gemProperty, {
    required bool preserveExisting,
  }) async {
    if (gemProperty.enchantId == 0) return;
    final references = await laconic
        .table('foxy.dbc_spell_item_enchantment')
        .where('ID', gemProperty.enchantId)
        .count();
    if (references > 0) return;
    if (preserveExisting) {
      final existing = await getGemProperty(gemProperty.id);
      if (existing?.enchantId == gemProperty.enchantId) return;
    }
    throw StateError('Enchant_ID 引用的法术物品附魔 ${gemProperty.enchantId} 不存在');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GemPropertyFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
