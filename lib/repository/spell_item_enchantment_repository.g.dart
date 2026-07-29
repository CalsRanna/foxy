// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_repository.dart';

mixin _SpellItemEnchantmentRepositoryMixin on RepositoryMixin {
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
