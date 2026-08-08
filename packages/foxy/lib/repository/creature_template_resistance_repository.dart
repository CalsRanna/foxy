import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_template_resistance_repository.g.dart';

@FoxyRepository(linkKey: ['creatureID'])
class CreatureTemplateResistanceRepository
    with RepositoryMixin, _CreatureTemplateResistanceRepositoryMixin {
  static const maxSchool = 6;
  static const minSchool = 1;
  static const primaryKeyColumns = {'CreatureID', 'School'};

  @override
  Future<CreatureTemplateResistanceKey> copyCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    final source = await getCreatureTemplateResistance(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final blank = await createCreatureTemplateResistance(source.creatureID);
    final candidate = source.copyWith(school: blank.school);
    await storeCreatureTemplateResistance(candidate);
    return CreatureTemplateResistanceKey.fromEntity(candidate);
  }

  @override
  Future<int> countCreatureTemplateResistances(int creatureID) {
    return laconic.table(_table).where('CreatureID', creatureID).count();
  }

  @override
  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: await getNextSchool(creatureID),
    );
  }

  @override
  Future<List<BriefCreatureTemplateResistanceEntity>>
  getBriefCreatureTemplateResistances(int creatureID, {int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['CreatureID', 'School', 'Resistance', 'VerifiedBuild'])
        .where('CreatureID', creatureID)
        .orderBy('CreatureID')
        .orderBy('School')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map(
          (result) =>
              BriefCreatureTemplateResistanceEntity.fromJson(result.toMap()),
        )
        .toList();
  }

  Future<int> getNextSchool(int creatureID) async {
    final results = await laconic
        .table(_table)
        .select(['School'])
        .where('CreatureID', creatureID)
        .get();
    return nextAvailableSchool(
      results.map((result) => (result.toMap()['School'] as num).toInt()),
    );
  }

  static int nextAvailableSchool(Iterable<int> usedSchools) {
    final used = usedSchools.toSet();
    for (var school = minSchool; school <= maxSchool; school++) {
      if (!used.contains(school)) return school;
    }
    throw ValidationException(
      'creature resistance schools are full; only $minSchool-$maxSchool are allowed',
    );
  }
}
