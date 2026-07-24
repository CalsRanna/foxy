// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_condition_repository.dart';

mixin _SpellItemEnchantmentConditionRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellItemEnchantmentCondition(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment_condition'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellItemEnchantmentConditionEntity?> getSpellItemEnchantmentCondition(
    int key,
  ) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment_condition'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellItemEnchantmentConditionEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellItemEnchantmentCondition(
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {
    if (spellItemEnchantmentCondition.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(spellItemEnchantmentCondition);
    final json = _prepareWriteJson(spellItemEnchantmentCondition.toJson());
    try {
      await laconic.table('foxy.dbc_spell_item_enchantment_condition').insert([
        json,
      ]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellItemEnchantmentCondition(
    int originalKey,
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {
    await _beforeUpdate(originalKey, spellItemEnchantmentCondition);
    final json = _prepareWriteJson(spellItemEnchantmentCondition.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_item_enchantment_condition'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class SpellItemEnchantmentConditionFilter {
  final String id;

  const SpellItemEnchantmentConditionFilter({this.id = ''});

  factory SpellItemEnchantmentConditionFilter.fromJson(
    Map<String, dynamic> json,
  ) {
    return SpellItemEnchantmentConditionFilter(
      id: json['id']?.toString() ?? '',
    );
  }

  SpellItemEnchantmentConditionFilter copyWith({String? id}) {
    return SpellItemEnchantmentConditionFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
