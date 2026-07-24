// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_on_kill_reputation_repository.dart';

mixin _CreatureOnKillReputationRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureOnKillReputation(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_onkill_reputation'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureOnKillReputationEntity?> getCreatureOnKillReputation(
    int key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_onkill_reputation'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureOnKillReputationEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureOnKillReputation(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {
    if (creatureOnKillReputation.creatureID <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(creatureOnKillReputation);
    final json = _prepareWriteJson(creatureOnKillReputation.toJson());
    try {
      await laconic.table('creature_onkill_reputation').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureOnKillReputation(
    int originalKey,
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {
    await _beforeUpdate(originalKey, creatureOnKillReputation);
    final json = _prepareWriteJson(creatureOnKillReputation.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('creature_onkill_reputation'),
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

  Future<void> _beforeStore(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CreatureOnKillReputationEntity creatureOnKillReputation,
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
    return builder.where('creature_id', key);
  }
}
