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
  String get _table => 'foxy.dbc_creature_spell_data';

  Future<void> destroyCreatureSpellData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_spell_data record not found',
      );
    }
  }

  Future<CreatureSpellDataEntity?> getCreatureSpellData(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureSpellDataEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureSpellData(
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
      await trackActivityWrite(
        _table,
        afterKey: activityKey(creatureSpellData.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureSpellData.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.id),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_creature_spell_data',
          );
        }
        rethrow;
      }
    }
    return creatureSpellData.id;
  }

  Future<void> updateCreatureSpellData(
    int originalKey,
    CreatureSpellDataEntity creatureSpellData,
  ) async {
    await _beforeUpdate(originalKey, creatureSpellData);
    final values = creatureSpellData.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(creatureSpellData.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
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

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
