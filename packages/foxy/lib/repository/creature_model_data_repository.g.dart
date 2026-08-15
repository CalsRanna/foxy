// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_data_repository.dart';

final class CreatureModelDataFilter {
  final String id;
  final String modelName;

  const CreatureModelDataFilter({this.id = '', this.modelName = ''});

  factory CreatureModelDataFilter.fromJson(Map<String, dynamic> json) {
    return CreatureModelDataFilter(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  CreatureModelDataFilter copyWith({String? id, String? modelName}) {
    return CreatureModelDataFilter(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}

mixin _CreatureModelDataRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_creature_model_data';

  Future<void> destroyCreatureModelData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_model_data record not found',
      );
    }
  }

  Future<CreatureModelDataEntity?> getCreatureModelData(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelDataEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureModelData(
    CreatureModelDataEntity creatureModelData,
  ) async {
    if (creatureModelData.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureModelData);
    final json = prepareWriteJson(creatureModelData.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureModelData.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_creature_model_data',
          );
        }
        rethrow;
      }
    }
    return creatureModelData.id;
  }

  Future<void> updateCreatureModelData(
    int originalKey,
    CreatureModelDataEntity creatureModelData,
  ) async {
    await _beforeUpdate(originalKey, creatureModelData);
    final json = prepareWriteJson(creatureModelData.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_model_data',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_model_data record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CreatureModelDataEntity creatureModelData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureModelDataEntity creatureModelData,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
