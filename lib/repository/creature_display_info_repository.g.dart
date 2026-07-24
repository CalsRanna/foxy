// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_repository.dart';

mixin _CreatureDisplayInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureDisplayInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_display_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureDisplayInfoEntity?> getCreatureDisplayInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_creature_display_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> updateCreatureDisplayInfo(
    int originalKey,
    CreatureDisplayInfoEntity info,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_display_info'),
        originalKey,
      ).update(info.toJson());
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
