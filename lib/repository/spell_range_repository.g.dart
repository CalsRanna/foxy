// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_range_repository.dart';

mixin _SpellRangeRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellRange(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_range'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellRangeEntity?> getSpellRange(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_range'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRangeEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellRange(SpellRangeEntity spellRange) async {
    if (spellRange.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(spellRange);
    final json = _prepareWriteJson(spellRange.toJson());
    try {
      await laconic.table('foxy.dbc_spell_range').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellRange(
    int originalKey,
    SpellRangeEntity spellRange,
  ) async {
    await _beforeUpdate(originalKey, spellRange);
    final json = _prepareWriteJson(spellRange.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_range'),
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

  Future<void> _beforeStore(SpellRangeEntity spellRange) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellRangeEntity spellRange,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class SpellRangeFilter {
  final String id;
  final String name;

  const SpellRangeFilter({this.id = '', this.name = ''});

  factory SpellRangeFilter.fromJson(Map<String, dynamic> json) {
    return SpellRangeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellRangeFilter copyWith({String? id, String? name}) {
    return SpellRangeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
