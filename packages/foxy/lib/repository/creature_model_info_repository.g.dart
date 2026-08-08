// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_info_repository.dart';

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

mixin _CreatureModelInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureModelInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_model_info record not found');
    }
  }

  Future<CreatureModelInfoEntity?> getCreatureModelInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelInfoEntity.fromJson(results.first.toMap());
  }

  Future<int> storeCreatureModelInfo(
    CreatureModelInfoEntity creatureModelInfo,
  ) async {
    if (creatureModelInfo.displayId <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(creatureModelInfo);
    final json = prepareWriteJson(creatureModelInfo.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureModelInfo.copyWith(
        displayId: await nextMaxPlusOne(_table, '`DisplayID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.displayId;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in creature_model_info');
        }
        rethrow;
      }
    }
    return creatureModelInfo.displayId;
  }

  Future<void> updateCreatureModelInfo(
    int originalKey,
    CreatureModelInfoEntity creatureModelInfo,
  ) async {
    await _beforeUpdate(originalKey, creatureModelInfo);
    final json = prepareWriteJson(creatureModelInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in creature_model_info');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_model_info record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CreatureModelInfoEntity creatureModelInfo) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureModelInfoEntity creatureModelInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`DisplayID`', key);
  }
}

const _table = 'creature_model_info';
