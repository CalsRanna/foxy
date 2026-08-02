// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_condition_repository.dart';

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

mixin _SpellItemEnchantmentConditionRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellItemEnchantmentCondition(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_item_enchantment_condition'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_item_enchantment_condition record not found',
      );
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(spellItemEnchantmentCondition);
    final json = prepareWriteJson(spellItemEnchantmentCondition.toJson());
    try {
      await laconic.table('foxy.dbc_spell_item_enchantment_condition').insert([
        json,
      ]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_spell_item_enchantment_condition',
        );
      }
      rethrow;
    }
  }

  Future<void> updateSpellItemEnchantmentCondition(
    int originalKey,
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {
    await _beforeUpdate(originalKey, spellItemEnchantmentCondition);
    final json = prepareWriteJson(spellItemEnchantmentCondition.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_item_enchantment_condition'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_spell_item_enchantment_condition',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_spell_item_enchantment_condition record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellItemEnchantmentConditionEntity spellItemEnchantmentCondition,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
