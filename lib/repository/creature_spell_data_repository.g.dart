// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_spell_data_repository.dart';

mixin _CreatureSpellDataRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureSpellData(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_spell_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureSpellDataEntity?> getCreatureSpellData(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_creature_spell_data'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureSpellDataEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureSpellData(
    CreatureSpellDataEntity creatureSpellData,
  ) async {
    if (creatureSpellData.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureSpellData);
    final json = _prepareWriteJson(creatureSpellData.toJson());
    try {
      await laconic.table('foxy.dbc_creature_spell_data').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureSpellData(
    int originalKey,
    CreatureSpellDataEntity creatureSpellData,
  ) async {
    await _beforeUpdate(originalKey, creatureSpellData);
    final json = _prepareWriteJson(creatureSpellData.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_spell_data'),
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

  Future<void> _beforeStore(CreatureSpellDataEntity creatureSpellData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureSpellDataEntity creatureSpellData,
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

final class CreatureSpellDataFilter {
  final String id;
  final String spell;

  const CreatureSpellDataFilter({this.id = '', this.spell = ''});

  factory CreatureSpellDataFilter.fromJson(Map<String, dynamic> json) {
    return CreatureSpellDataFilter(
      id: json['id']?.toString() ?? '',
      spell: json['spell']?.toString() ?? '',
    );
  }

  CreatureSpellDataFilter copyWith({String? id, String? spell}) {
    return CreatureSpellDataFilter(
      id: id ?? this.id,
      spell: spell ?? this.spell,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spell': spell};
  }
}
