import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_rank_repository.g.dart';

@FoxyRepository(SpellRankEntity)
class SpellRankRepository with RepositoryMixin, _SpellRankRepositoryMixin {
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
          'fds.Name_lang_zhCN AS firstSpellName',
          'fds.NameSubtext_lang_zhCN AS firstSpellSubtext',
          'ds.Name_lang_zhCN AS spellName',
          'ds.NameSubtext_lang_zhCN AS spellSubtext',
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
}
