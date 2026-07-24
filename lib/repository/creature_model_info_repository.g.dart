// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_info_repository.dart';

mixin _CreatureModelInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureModelInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_model_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureModelInfoEntity?> getCreatureModelInfo(int key) async {
    final results = await _whereKey(
      laconic.table('creature_model_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureModelInfo(
    CreatureModelInfoEntity creatureModelInfo,
  ) async {
    if (creatureModelInfo.displayId <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureModelInfo);
    final json = _prepareWriteJson(creatureModelInfo.toJson());
    try {
      await laconic.table('creature_model_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureModelInfo(
    int originalKey,
    CreatureModelInfoEntity creatureModelInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureModelInfo);
    final json = _prepareWriteJson(creatureModelInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_model_info'),
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

  Future<void> _beforeStore(CreatureModelInfoEntity creatureModelInfo) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureModelInfoEntity creatureModelInfo,
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
    return builder.where('DisplayID', key);
  }
}

final class CreatureModelInfoFilter {
  final String id;

  const CreatureModelInfoFilter({this.id = ''});

  factory CreatureModelInfoFilter.fromJson(Map<String, dynamic> json) {
    return CreatureModelInfoFilter(id: json['id']?.toString() ?? '');
  }

  CreatureModelInfoFilter copyWith({String? id}) {
    return CreatureModelInfoFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
