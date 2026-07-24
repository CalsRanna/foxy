import 'package:foxy/entity/brief_spell_rank_entity.dart';
import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SpellRankRepository with RepositoryMixin {
  static const _table = 'spell_ranks';

  Future<void> copySpellRank(SpellRankKey key) async {
    throw UnsupportedError('法术等级记录不能自动复制，请新增记录并选择有效法术。');
  }

  Future<int> countSpellRanks(int spellId) async {
    final firstSpellId = await _getFirstSpellId(spellId);
    if (firstSpellId == null) return 0;
    return laconic.table(_table).where('first_spell_id', firstSpellId).count();
  }

  Future<SpellRankEntity> createSpellRank(int firstSpellId) async {
    return SpellRankEntity(
      firstSpellId: firstSpellId,
      rank: await nextMaxPlusOne(
        _table,
        'rank',
        where: {'first_spell_id': firstSpellId},
      ),
    );
  }

  Future<void> destroySpellRank(SpellRankKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原法术等级记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSpellRankEntity>> getBriefSpellRanks(
    int spellId, {
    int page = 1,
  }) async {
    final firstSpellId = await _getFirstSpellId(spellId);
    if (firstSpellId == null) return [];

    final results = await laconic
        .table('$_table AS sr')
        .select([
          'sr.first_spell_id',
          'sr.spell_id',
          'sr.`rank` AS rank',
          'fds.Name_lang_zhCN as First_Spell_Name_Lang_zhCN',
          'fds.NameSubtext_lang_zhCN as First_Spell_NameSubtext_Lang_zhCN',
          'ds.Name_lang_zhCN as Spell_Name_Lang_zhCN',
          'ds.NameSubtext_lang_zhCN as Spell_NameSubtext_Lang_zhCN',
        ])
        .leftJoin(
          'foxy.dbc_spell AS fds',
          (join) => join.on('sr.first_spell_id', 'fds.ID'),
        )
        .leftJoin(
          'foxy.dbc_spell AS ds',
          (join) => join.on('sr.spell_id', 'ds.ID'),
        )
        .where('sr.first_spell_id', firstSpellId)
        .orderBy('sr.`rank`')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefSpellRankEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<SpellRankEntity?> getSpellRank(SpellRankKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRankEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSpellRank(SpellRankEntity data) async {
    try {
      await laconic.table(_table).insert([_writeJson(data)]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同起始法术与等级的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSpellRank(
    SpellRankKey originalKey,
    SpellRankEntity data,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(_writeJson(data));
      if (matchedRows == 0) {
        throw StateError('原法术等级记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的起始法术与等级组合已存在');
      }
      rethrow;
    }
  }

  Future<int?> _getFirstSpellId(int spellId) async {
    final results = await laconic
        .table(_table)
        .select(['first_spell_id'])
        .where('spell_id', spellId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    final value = results.first.toMap()['first_spell_id'];
    if (value is int) return value == 0 ? null : value;
    if (value is num) return value.toInt() == 0 ? null : value.toInt();
    final parsed = int.tryParse('$value');
    return parsed == 0 ? null : parsed;
  }

  QueryBuilder _whereKey(QueryBuilder builder, SpellRankKey key) {
    return builder
        .where('first_spell_id', key.firstSpellId)
        .where('`rank`', key.rank);
  }

  Map<String, dynamic> _writeJson(SpellRankEntity data) {
    final json = data.toJson();
    json['`rank`'] = json.remove('rank');
    return json;
  }
}
