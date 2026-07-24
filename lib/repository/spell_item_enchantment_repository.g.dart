// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_repository.dart';

mixin _SpellItemEnchantmentRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellItemEnchantment(int key) async {
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

  Future<void> updateSpellItemEnchantment(
    int originalKey,
    SpellItemEnchantmentEntity spellItemEnchantment,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_item_enchantment'),
        originalKey,
      ).update(spellItemEnchantment.toJson());
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
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
