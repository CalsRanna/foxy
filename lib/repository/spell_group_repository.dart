import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellGroupRepository with RepositoryMixin {
  static const _table = 'spell_group';

  Future<SpellGroupKey> copySpellGroup(SpellGroupKey key) async {
    final source = await getSpellGroup(key);
    if (source == null) {
      throw StateError('原法术组记录不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'id'));
    await storeSpellGroup(copied);
    return SpellGroupKey.fromEntity(copied);
  }

  Future<int> countSpellGroups(int spellId) {
    return laconic.table(_table).where('spell_id', spellId).count();
  }

  Future<SpellGroupEntity> createSpellGroup(int spellId) async {
    return SpellGroupEntity(
      id: await nextMaxPlusOne(_table, 'id'),
      spellId: spellId,
    );
  }

  Future<void> destroySpellGroup(SpellGroupKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术组记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellGroupEntity>> getBriefSpellGroups(
    int spellId, {
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['id', 'spell_id'])
        .where('spell_id', spellId)
        .orderBy('id')
        .orderBy('spell_id')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellGroupEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SpellGroupEntity?> getSpellGroup(SpellGroupKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellGroupEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellGroup(SpellGroupEntity data) async {
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同法术组与法术 ID 的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellGroup(
    SpellGroupKey originalKey,
    SpellGroupEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术组记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术组与法术 ID 组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellGroupKey key) {
    return builder.where('id', key.id).where('spell_id', key.spellId);
  }
}
