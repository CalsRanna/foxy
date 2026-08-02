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
  Future<void> destroyCreatureDisplayInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_creature_display_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_creature_display_info record not found',
      );
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

  Future<void> storeCreatureDisplayInfo(
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
      await laconic.table('foxy.dbc_creature_display_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_creature_display_info',
        );
      }
      rethrow;
    }
  }

  Future<void> updateCreatureDisplayInfo(
    int originalKey,
    CreatureDisplayInfoEntity creatureDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureDisplayInfo);
    final json = prepareWriteJson(creatureDisplayInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_creature_display_info'),
        originalKey,
      ).update(json);
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
