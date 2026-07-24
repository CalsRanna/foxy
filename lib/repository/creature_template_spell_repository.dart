import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_spell_repository.g.dart';

@FoxyRepository(CreatureTemplateSpellEntity)
class CreatureTemplateSpellRepository
    with RepositoryMixin, _CreatureTemplateSpellRepositoryMixin {
  static const _table = 'creature_template_spell';
  static const maxIndex = 7;
  static const minIndex = 0;
  static const primaryKeyColumns = {'CreatureID', 'Index'};

  Future<CreatureTemplateSpellKey> copyCreatureTemplateSpell(
    CreatureTemplateSpellKey sourceKey,
  ) async {
    final source = await getCreatureTemplateSpell(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCreatureTemplateSpell(source.creatureID);
    final candidate = source.copyWith(index: blank.index);
    await storeCreatureTemplateSpell(candidate);
    return CreatureTemplateSpellKey.fromEntity(candidate);
  }

  Future<int> countCreatureTemplateSpells(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: await getNextIndex(creatureID),
    );
  }

  Future<List<BriefCreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID, {
    int page = 1,
  }) async {
    final results = await laconic
        .table('$_table AS cts')
        .select([
          'cts.CreatureID',
          'cts.`Index`',
          'cts.Spell',
          'cts.VerifiedBuild',
          'ds.Name_lang_zhCN AS spellName',
          'ds.NameSubtext_lang_zhCN AS spellSubtext',
        ])
        .leftJoin(
          'foxy.dbc_spell AS ds',
          (join) => join.on('cts.Spell', 'ds.ID'),
        )
        .where('cts.CreatureID', creatureID)
        .orderBy('cts.CreatureID')
        .orderBy('cts.`Index`')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) => BriefCreatureTemplateSpellEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<int> getNextIndex(int creatureID) async {
    final results = await laconic
        .table(_table)
        .select(['`Index`'])
        .where('CreatureID', creatureID)
        .get();
    return nextAvailableIndex(
      results.map((result) => (result.toMap()['Index'] as num).toInt()),
    );
  }

  static int nextAvailableIndex(Iterable<int> usedIndexes) {
    final used = usedIndexes.toSet();
    for (var index = minIndex; index <= maxIndex; index++) {
      if (!used.contains(index)) return index;
    }
    throw StateError('生物技能槽已满，只允许 $minIndex-$maxIndex');
  }
}
