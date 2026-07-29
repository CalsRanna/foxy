// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_immunity_repository.dart';

mixin _CreatureImmunityRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureImmunity(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_immunities'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureImmunityEntity?> getCreatureImmunity(int key) async {
    final results = await _whereKey(
      laconic.table('creature_immunities'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureImmunityEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureImmunity(
    CreatureImmunityEntity creatureImmunity,
  ) async {
    if (creatureImmunity.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureImmunity);
    final json = prepareWriteJson(creatureImmunity.toJson());
    try {
      await laconic.table('creature_immunities').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureImmunity(
    int originalKey,
    CreatureImmunityEntity creatureImmunity,
  ) async {
    await _beforeUpdate(originalKey, creatureImmunity);
    final json = prepareWriteJson(creatureImmunity.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('creature_immunities'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CreatureImmunityEntity creatureImmunity) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureImmunityEntity creatureImmunity,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

final class CreatureImmunityFilter {
  final String id;
  final String comment;

  const CreatureImmunityFilter({this.id = '', this.comment = ''});

  factory CreatureImmunityFilter.fromJson(Map<String, dynamic> json) {
    return CreatureImmunityFilter(
      id: json['id']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }

  CreatureImmunityFilter copyWith({String? id, String? comment}) {
    return CreatureImmunityFilter(
      id: id ?? this.id,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'comment': comment};
  }
}
