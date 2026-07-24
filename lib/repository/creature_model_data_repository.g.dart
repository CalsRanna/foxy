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

  Future<void> updateCreatureModelData(
    int originalKey,
    CreatureModelDataEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_model_data'),
        originalKey,
      ).update(entity.toJson());
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
