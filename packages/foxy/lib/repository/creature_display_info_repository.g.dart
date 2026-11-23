// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_repository.dart';

final class CreatureDisplayInfoFilter {
  final String id;
  final String modelName;

  const CreatureDisplayInfoFilter({this.id = '', this.modelName = ''});

  factory CreatureDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  CreatureDisplayInfoFilter copyWith({String? id, String? modelName}) {
    return CreatureDisplayInfoFilter(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}

mixin _CreatureDisplayInfoRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_creature_display_info';

  Future<void> destroyCreatureDisplayInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_display_info record not found',
      );
    }
  }

  Future<CreatureDisplayInfoEntity?> getCreatureDisplayInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureDisplayInfo(
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {
    if (creatureDisplayInfo.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureDisplayInfo);
    final json = prepareWriteJson(creatureDisplayInfo.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(creatureDisplayInfo.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureDisplayInfo.copyWith(
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
            'duplicate key in foxy.dbc_creature_display_info',
          );
        }
        rethrow;
      }
    }
    return creatureDisplayInfo.id;
  }

  Future<void> updateCreatureDisplayInfo(
    int originalKey,
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureDisplayInfo);
    final values = creatureDisplayInfo.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(creatureDisplayInfo.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_display_info',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_display_info record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {}

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
