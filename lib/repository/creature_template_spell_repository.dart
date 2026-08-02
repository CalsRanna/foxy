import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_spell_repository.g.dart';

@FoxyRepository(CreatureTemplateSpellEntity, linkKey: ['creatureID'])
class CreatureTemplateSpellRepository
    with RepositoryMixin, _CreatureTemplateSpellRepositoryMixin {
  static const _table = 'creature_template_spell';
  static const maxIndex = 7;
  static const minIndex = 0;
  static const primaryKeyColumns = {'CreatureID', 'Index'};

  @override
  Future<CreatureTemplateSpellKey> copyCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    final source = await getCreatureTemplateSpell(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final blank = await createCreatureTemplateSpell(source.creatureID);
    final candidate = source.copyWith(index: blank.index);
    await storeCreatureTemplateSpell(candidate);
    return CreatureTemplateSpellKey.fromEntity(candidate);
  }

  @override
  Future<int> countCreatureTemplateSpells(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  @override
  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: await getNextIndex(creatureID),
    );
  }

  @override
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
    throw ValidationException(
      'creature skill slots are full; only $minIndex-$maxIndex are allowed',
    );
  }
}
