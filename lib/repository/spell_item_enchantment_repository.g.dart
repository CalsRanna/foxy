// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_repository.dart';

final class SpellItemEnchantmentFilter {
  final String id;
  final String name;

  const SpellItemEnchantmentFilter({this.id = '', this.name = ''});

  factory SpellItemEnchantmentFilter.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellItemEnchantmentFilter copyWith({String? id, String? name}) {
    return SpellItemEnchantmentFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _SpellItemEnchantmentRepositoryMixin on RepositoryMixin {
  Future<int> copySpellItemEnchantment(int key) async {
    final source = await getSpellItemEnchantment(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createSpellItemEnchantment();
    final copied = source.copyWith(id: blank.id);
    await storeSpellItemEnchantment(copied);
    return copied.id;
  }

  Future<int> countSpellItemEnchantments({
    SpellItemEnchantmentFilter? filter,
  }) async {
    return _applyFilter(
      laconic.table('foxy.dbc_spell_item_enchantment'),
      filter,
    ).count();
  }

  Future<SpellItemEnchantmentEntity> createSpellItemEnchantment() async {
    return SpellItemEnchantmentEntity(
      id: await nextMaxPlusOne('foxy.dbc_spell_item_enchantment', '`ID`'),
    );
  }

  Future<void> destroySpellItemEnchantment(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellItemEnchantmentEntity?> getSpellItemEnchantment(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellItemEnchantmentEntity>> getBriefSpellItemEnchantments({
    int page = 1,
    SpellItemEnchantmentFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_spell_item_enchantment').select([
      '`ID`',
      '`Charges`',
      '`Effect0`',
      '`Effect1`',
      '`Effect2`',
      '`Name_lang_zhCN`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellItemEnchantmentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellItemEnchantmentEntity>> getSpellItemEnchantments() async {
    var builder = laconic
        .table('foxy.dbc_spell_item_enchantment')
        .orderBy('`ID`');
    final results = await builder.get();
    return results
        .map((e) => SpellItemEnchantmentEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellItemEnchantment(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    if (spellItemEnchantment.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(spellItemEnchantment);
    final json = prepareWriteJson(spellItemEnchantment.toJson());
    try {
      await laconic.table('foxy.dbc_spell_item_enchantment').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellItemEnchantment(
    int originalKey,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    await _beforeUpdate(originalKey, spellItemEnchantment);
    final json = prepareWriteJson(spellItemEnchantment.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_item_enchantment'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SpellItemEnchantmentFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`Name_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
