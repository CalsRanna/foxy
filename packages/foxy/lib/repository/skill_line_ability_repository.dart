import 'package:foxy/entity/skill_line_ability_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_line_ability_repository.g.dart';

@FoxyRepository(linkKey: ['skillLine'])
class SkillLineAbilityRepository
    with RepositoryMixin, _SkillLineAbilityRepositoryMixin {
  @override
  Future<List<BriefSkillLineAbilityEntity>> getBriefSkillLineAbilities(
    int skillLine, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as sla');
    const fields = [
      'sla.ID',
      'sla.SkillLine',
      'sla.Spell',
      'sla.MinSkillLineRank',
      'sla.AcquireMethod',
      'ds.Name_lang_enUS as spellNameEnUS',
      'ds.Name_lang_zhCN as spellNameZhCN',
      'ds.Description_lang_enUS as spellDescriptionEnUS',
      'ds.Description_lang_zhCN as spellDescriptionZhCN',
      'dsi.TextureFilename as textureFilename',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'foxy.dbc_spell as ds',
      (join) => join.on('sla.Spell', 'ds.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_icon as dsi',
      (join) => join.on('ds.SpellIconID', 'dsi.ID'),
    );
    builder = builder.where('sla.SkillLine', skillLine);
    builder = builder.orderBy('sla.ID').orderBy('sla.SkillLine');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSkillLineAbilityEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countAllSkillLineAbilities() async {
    return laconic.table(_table).count();
  }

  Future<List<SkillLineAbilityEntity>> getAllSkillLineAbilities() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SkillLineAbilityEntity.fromJson(row.toMap()))
        .toList();
  }
}
