import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellAreaRepository with RepositoryMixin {
  static const _table = 'spell_area';

  Future<void> copySpellArea(SpellAreaKey key) async {
    throw UnsupportedError('法术区域记录不能自动复制，请新增记录并选择有效区域。');
  }

  Future<int> countSpellAreas(int spell) {
    return laconic.table(_table).where('spell', spell).count();
  }

  Future<SpellAreaEntity> createSpellArea(int spell) async {
    return SpellAreaEntity(spell: spell);
  }

  Future<void> destroySpellArea(SpellAreaKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术区域记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellAreaEntity>> getBriefSpellAreas(
    int spell, {
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'spell',
          'area',
          'quest_start',
          'quest_end',
          'aura_spell',
          'racemask',
          'gender',
          'quest_start_status',
          'quest_end_status',
        ])
        .where('spell', spell)
        .orderBy('area')
        .orderBy('quest_start')
        .orderBy('aura_spell')
        .orderBy('racemask')
        .orderBy('gender')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellAreaEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SpellAreaEntity?> getSpellArea(SpellAreaKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellAreaEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellArea(SpellAreaEntity data) async {
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同法术区域主键组合的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellArea(
    SpellAreaKey originalKey,
    SpellAreaEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术区域记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术区域主键组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellAreaKey key) {
    return builder
        .where('spell', key.spell)
        .where('area', key.area)
        .where('quest_start', key.questStart)
        .where('aura_spell', key.auraSpell)
        .where('racemask', key.racemask)
        .where('gender', key.gender);
  }
}
