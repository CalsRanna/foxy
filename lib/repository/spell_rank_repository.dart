import 'package:foxy/model/spell_rank.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellRankRepository with RepositoryMixin {
  static const _table = 'spell_ranks';

  Future<List<SpellRank>> getBySpellId(int spellId) async {
    try {
      var firstResult = await laconic
          .table(_table)
          .select(['first_spell_id'])
          .where('spell_id', spellId)
          .first();

      var firstSpellId = (firstResult.toMap()['first_spell_id'] ?? 0) as int;
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
      builder = builder.orderBy('sr.rank');
      var results = await builder.get();
      return results.map((e) => SpellRank.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<SpellRank?> find(int firstSpellId, int rank) async {
    try {
      var result = await laconic
          .table(_table)
          .where('first_spell_id', firstSpellId)
          .where('rank', rank)
          .first();
      return SpellRank.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(SpellRank data) async {
    var json = data.toJson();
    json['`rank`'] = json.remove('rank');
    await laconic.table(_table).insert([json]);
  }

  Future<void> update(SpellRank oldData, SpellRank newData) async {
    var json = newData.toJson();
    json.remove('first_spell_id');
    json['`rank`'] = json.remove('rank');
    await laconic
        .table(_table)
        .where('first_spell_id', oldData.firstSpellId)
        .where('`rank`', oldData.rank)
        .update(json);
  }

  Future<void> delete(int firstSpellId, int rank) async {
    await laconic
        .table(_table)
        .where('first_spell_id', firstSpellId)
        .where('`rank`', rank)
        .delete();
  }

  Future<SpellRank> copy(SpellRank data) async {
    var json = data.toJson();
    var maxSpellIdResult = await laconic
        .table(_table)
        .select(['MAX(spell_id) AS maxSpellId'])
        .where('first_spell_id', data.firstSpellId)
        .first();
    var maxRankResult = await laconic
        .table(_table)
        .select(['MAX(`rank`) AS maxRank'])
        .where('first_spell_id', data.firstSpellId)
        .first();
    var maxSpellId = (maxSpellIdResult.toMap()['maxSpellId'] ?? 0) as int;
    var maxRank = (maxRankResult.toMap()['maxRank'] ?? 0) as int;
    json['spell_id'] = maxSpellId + 1;
    json['rank'] = maxRank + 1;
    json['`rank`'] = json.remove('rank');
    await laconic.table(_table).insert([json]);
    return SpellRank.fromJson(json);
  }
}
