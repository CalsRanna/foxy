import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellAreaRepository with RepositoryMixin {
  static const _table = 'spell_area';

  Future<List<SpellAreaEntity>> getBriefSpellAreas(int spell) async {
    var results = await laconic.table(_table).where('spell', spell).get();
    return results.map((e) => SpellAreaEntity.fromJson(e.toMap())).toList();
  }

  Future<SpellAreaEntity?> getSpellArea(
    int spell,
    int area,
    int questStart,
    int auraSpell,
    int racemask,
    int gender,
  ) async {
    var results = await laconic
        .table(_table)
        .where('spell', spell)
        .where('area', area)
        .where('quest_start', questStart)
        .where('aura_spell', auraSpell)
        .where('racemask', racemask)
        .where('gender', gender)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellAreaEntity.fromJson(results.first.toMap());
  }

  Future<SpellAreaEntity> createSpellArea(int spell) async {
    return SpellAreaEntity(spell: spell);
  }

  Future<void> storeSpellArea(SpellAreaEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellArea(
    int spell,
    int area,
    int questStart,
    int auraSpell,
    int racemask,
    int gender,
    SpellAreaEntity data,
  ) async {
    var json = data.toJson();
    json.remove('spell');
    json.remove('area');
    json.remove('quest_start');
    json.remove('aura_spell');
    json.remove('racemask');
    json.remove('gender');
    await laconic
        .table(_table)
        .where('spell', spell)
        .where('area', area)
        .where('quest_start', questStart)
        .where('aura_spell', auraSpell)
        .where('racemask', racemask)
        .where('gender', gender)
        .update(json);
  }

  Future<void> destroySpellArea(
    int spell,
    int area,
    int questStart,
    int auraSpell,
    int racemask,
    int gender,
  ) async {
    await laconic
        .table(_table)
        .where('spell', spell)
        .where('area', area)
        .where('quest_start', questStart)
        .where('aura_spell', auraSpell)
        .where('racemask', racemask)
        .where('gender', gender)
        .delete();
  }

  Future<void> copySpellArea(
    int spell,
    int area,
    int questStart,
    int auraSpell,
    int racemask,
    int gender,
  ) async {
    var source = await getSpellArea(
      spell,
      area,
      questStart,
      auraSpell,
      racemask,
      gender,
    );
    if (source == null) return;
    var json = source.toJson();
    var maxAreaResult = await laconic
        .table(_table)
        .select(['MAX(area) AS maxArea'])
        .where('spell', spell)
        .first();
    var maxArea = (maxAreaResult.toMap()['maxArea'] ?? 0) as int;
    json['area'] = maxArea + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellArea(SpellAreaEntity data) async {
    var existing = await getSpellArea(
      data.spell,
      data.area,
      data.questStart,
      data.auraSpell,
      data.racemask,
      data.gender,
    );
    if (existing != null) {
      await updateSpellArea(
        data.spell,
        data.area,
        data.questStart,
        data.auraSpell,
        data.racemask,
        data.gender,
        data,
      );
    } else {
      await storeSpellArea(data);
    }
  }
}
