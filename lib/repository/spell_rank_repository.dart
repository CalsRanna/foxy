import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellRankRepository with RepositoryMixin {
  static const _table = 'spell_ranks';

  Future<List<BriefSpellRankEntity>> getBriefSpellRanks(int spellId) async {
    var firstResults = await laconic
        .table(_table)
        .select(['first_spell_id'])
        .where('spell_id', spellId)
        .limit(1)
        .get();
    if (firstResults.isEmpty) return [];
    var firstSpellId =
        (firstResults.first.toMap()['first_spell_id'] ?? 0) as int;
    if (firstSpellId == 0) return [];

    var builder = laconic.table('$_table AS sr');
    const fields = [
      'sr.*',
      'fds.Name_lang_zhCN as First_Spell_Name_Lang_zhCN',
      'fds.NameSubtext_lang_zhCN as First_Spell_NameSubtext_Lang_zhCN',
      'ds.Name_lang_zhCN as Spell_Name_Lang_zhCN',
      'ds.NameSubtext_lang_zhCN as Spell_NameSubtext_Lang_zhCN',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell AS fds',
      (join) => join.on('sr.first_spell_id', 'fds.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell AS ds',
      (join) => join.on('sr.spell_id', 'ds.ID'),
    );
    builder = builder.where('sr.first_spell_id', firstSpellId);
    builder = builder.orderBy('sr.`rank`');
    var results = await builder.get();
    return results
        .map((e) => BriefSpellRankEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellRankEntity?> getSpellRank(int firstSpellId, int rank) async {
    var results = await laconic
        .table(_table)
        .where('first_spell_id', firstSpellId)
        .where('`rank`', rank)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellRankEntity.fromJson(results.first.toMap());
  }

  Future<SpellRankEntity> createSpellRank(int firstSpellId) async {
    return SpellRankEntity(firstSpellId: firstSpellId);
  }

  Future<void> storeSpellRank(SpellRankEntity data) async {
    var json = data.toJson();
    json['`rank`'] = json.remove('rank');
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateSpellRank(
    int firstSpellId,
    int rank,
    SpellRankEntity data,
  ) async {
    var json = data.toJson();
    json['`rank`'] = json.remove('rank');
    await laconic
        .table(_table)
        .where('first_spell_id', firstSpellId)
        .where('`rank`', rank)
        .update(json);
  }

  Future<void> destroySpellRank(int firstSpellId, int rank) async {
    await laconic
        .table(_table)
        .where('first_spell_id', firstSpellId)
        .where('`rank`', rank)
        .delete();
  }

  Future<void> copySpellRank(int firstSpellId, int rank) async {
    throw UnsupportedError('法术等级记录不能自动复制，请新增记录并选择有效法术。');
  }

  Future<void> saveSpellRank(SpellRankEntity data) async {
    var existing = await getSpellRank(data.firstSpellId, data.rank);
    if (existing != null) {
      await updateSpellRank(data.firstSpellId, data.rank, data);
    } else {
      await storeSpellRank(data);
    }
  }
}
