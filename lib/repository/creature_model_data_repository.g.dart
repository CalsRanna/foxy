// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_data_repository.dart';

mixin _CreatureModelDataRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureModelData(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_model_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureModelDataEntity?> getCreatureModelData(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_creature_model_data'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelDataEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureModelData(
    CreatureModelDataEntity creatureModelData,
  ) async {
    if (creatureModelData.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureModelData);
    final json = _prepareWriteJson(creatureModelData.toJson());
    try {
      await laconic.table('foxy.dbc_creature_model_data').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureModelData(
    int originalKey,
    CreatureModelDataEntity creatureModelData,
  ) async {
    await _beforeUpdate(originalKey, creatureModelData);
    final json = _prepareWriteJson(creatureModelData.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_model_data'),
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

  Future<void> _beforeStore(CreatureModelDataEntity creatureModelData) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureModelDataEntity creatureModelData,
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
