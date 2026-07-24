// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_duration_repository.dart';

mixin _SpellDurationRepositoryMixin on RepositoryMixin {
  Future<void> destroySpellDuration(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_spell_duration'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SpellDurationEntity?> getSpellDuration(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_spell_duration'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellDurationEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellDuration(SpellDurationEntity spellDuration) async {
    if (spellDuration.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(spellDuration);
    final json = _prepareWriteJson(spellDuration.toJson());
    try {
      await laconic.table('foxy.dbc_spell_duration').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellDuration(
    int originalKey,
    SpellDurationEntity spellDuration,
  ) async {
    await _beforeUpdate(originalKey, spellDuration);
    final json = _prepareWriteJson(spellDuration.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_spell_duration'),
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

  Future<void> _beforeStore(SpellDurationEntity spellDuration) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    SpellDurationEntity spellDuration,
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

final class SpellDurationFilter {
  final String id;

  const SpellDurationFilter({this.id = ''});

  factory SpellDurationFilter.fromJson(Map<String, dynamic> json) {
    return SpellDurationFilter(id: json['id']?.toString() ?? '');
  }

  SpellDurationFilter copyWith({String? id}) {
    return SpellDurationFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
