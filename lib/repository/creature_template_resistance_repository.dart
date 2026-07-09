import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateResistanceRepository with RepositoryMixin {
  static const _table = 'creature_template_resistance';

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

  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    var nextSchool = await getNextSchool(creatureID);
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: nextSchool,
    );
  }

  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    await laconic.table(_table).insert([resistance.toJson()]);
  }

  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    var json = resistance.toJson();
    json.remove('CreatureID');
    json.remove('School');
    await laconic
        .table(_table)
        .where('CreatureID', resistance.creatureID)
        .where('School', resistance.school)
        .update(json);
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

  Future<int> getNextSchool(int creatureID) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(School) AS maxSchool'])
        .where('CreatureID', creatureID)
        .first();
    var maxSchool = (maxResult.toMap()['maxSchool'] ?? 0) as int;
    return maxSchool + 1;
  }
}
