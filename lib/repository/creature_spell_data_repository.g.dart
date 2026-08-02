// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_spell_data_repository.dart';

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

mixin _CreatureSpellDataRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureSpellData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_spell_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_spell_data record not found',
      );
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureSpellData);
    final json = prepareWriteJson(creatureSpellData.toJson());
    try {
      await laconic.table('foxy.dbc_creature_spell_data').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_spell_data',
        );
      }
      rethrow;
    }
  }

  Future<void> updateCreatureSpellData(
    int originalKey,
    CreatureSpellDataEntity creatureSpellData,
  ) async {
    await _beforeUpdate(originalKey, creatureSpellData);
    final json = prepareWriteJson(creatureSpellData.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_spell_data'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_spell_data',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_spell_data record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CreatureSpellDataEntity creatureSpellData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureSpellDataEntity creatureSpellData,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
