import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateResistanceRepository with RepositoryMixin {
  static const _table = 'creature_template_resistance';
  static const minSchool = 1;
  static const maxSchool = 6;

  Future<void> copyCreatureTemplateResistance(
    int creatureID,
    int school,
  ) async {
    var source = await getCreatureTemplateResistance(creatureID, school);
    if (source == null) return;
    var nextSchool = await getNextSchool(creatureID);
    var json = source.toJson();
    json['School'] = nextSchool;
    await laconic.table(_table).insert([json]);
  }

  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    var nextSchool = await getNextSchool(creatureID);
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: nextSchool,
    );
  }

  Future<void> destroyCreatureTemplateResistance(
    int creatureID,
    int school,
  ) async {
    await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('School', school)
        .delete();
  }

  Future<List<CreatureTemplateResistanceEntity>>
  getBriefCreatureTemplateResistances(int creatureID) async {
    var builder = laconic.table(_table);
    builder = builder.select(['*']);
    builder = builder.where('CreatureID', creatureID);
    builder = builder.orderBy('School');
    var results = await builder.get();
    return results
        .map((e) => CreatureTemplateResistanceEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureTemplateResistanceEntity?> getCreatureTemplateResistance(
    int creatureID,
    int school,
  ) async {
    var results = await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('School', school)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureTemplateResistanceEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextSchool(int creatureID) async {
    var results = await laconic
        .table(_table)
        .select(['School'])
        .where('CreatureID', creatureID)
        .get();
    return nextAvailableSchool(
      results.map((result) => result.toMap()['School'] as int),
    );
  }

  Future<void> saveCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    var existing = await getCreatureTemplateResistance(
      resistance.creatureID,
      resistance.school,
    );
    if (existing != null) {
      await updateCreatureTemplateResistance(resistance);
    } else {
      await storeCreatureTemplateResistance(resistance);
    }
  }

  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    validateSchool(resistance.school);
    await laconic.table(_table).insert([resistance.toJson()]);
  }

  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    validateSchool(resistance.school);
    var json = resistance.toJson();
    json.remove('CreatureID');
    json.remove('School');
    await laconic
        .table(_table)
        .where('CreatureID', resistance.creatureID)
        .where('School', resistance.school)
        .update(json);
  }

  static int nextAvailableSchool(Iterable<int> usedSchools) {
    final used = usedSchools.toSet();
    for (var school = minSchool; school <= maxSchool; school++) {
      if (!used.contains(school)) return school;
    }
    throw StateError('生物抗性学校已满，只允许 $minSchool-$maxSchool');
  }

  static void validateSchool(int school) {
    if (school < minSchool || school > maxSchool) {
      throw ArgumentError.value(
        school,
        'school',
        '生物抗性学校只允许 $minSchool-$maxSchool',
      );
    }
  }
}
