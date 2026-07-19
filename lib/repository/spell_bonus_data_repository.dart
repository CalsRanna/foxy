import 'package:foxy/entity/brief_spell_bonus_data_entity.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/entity/spell_bonus_data_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellBonusDataRepository with RepositoryMixin {
  static const _table = 'spell_bonus_data';

  Future<void> copySpellBonusData(SpellBonusDataKey key) async {
    throw UnsupportedError('法术加成记录不能自动复制，请为有效法术新增记录。');
  }

  Future<int> countSpellBonusDatas() {
    return laconic.table(_table).count();
  }

  Future<SpellBonusDataEntity> createSpellBonusData([int? entry]) async {
    return SpellBonusDataEntity(
      entry: entry ?? await nextMaxPlusOne(_table, 'entry'),
    );
  }

  Future<void> destroySpellBonusData(SpellBonusDataKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术奖励系数不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellBonusDataEntity>> getBriefSpellBonusDatas({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'entry',
          'direct_bonus',
          'dot_bonus',
          'ap_bonus',
          'ap_dot_bonus',
          'comments',
        ])
        .orderBy('entry')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellBonusDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SpellBonusDataEntity?> getSpellBonusData(SpellBonusDataKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellBonusDataEntity.fromJson(results.first.toMap());
  }

  Future<List<SpellBonusDataEntity>> getSpellBonusDatas() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => SpellBonusDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeSpellBonusData(SpellBonusDataEntity data) async {
    if (data.entry <= 0) {
      throw StateError('法术奖励系数 entry 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([data.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('法术奖励系数 ${data.entry} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSpellBonusData(
    SpellBonusDataKey originalKey,
    SpellBonusDataEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(data.toJson());
      if (matchedRows == 0) {
        throw StateError('原法术奖励系数不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的法术奖励系数 entry 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellBonusDataKey key) {
    return builder.where('entry', key.entry);
  }
}
