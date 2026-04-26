import 'package:foxy/model/spell_area.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellAreaRepository with RepositoryMixin {
  static const _table = 'spell_area';

  Future<List<SpellArea>> getBySpell(int spell) async {
    try {
      var results = await laconic
          .table(_table)
          .where('spell', spell)
          .get();
      return results
          .map((e) => SpellArea.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<SpellArea?> find(int spell, int area, int questStart, int auraSpell,
      int racemask, int gender) async {
    try {
      var result = await laconic
          .table(_table)
          .where('spell', spell)
          .where('area', area)
          .where('quest_start', questStart)
          .where('aura_spell', auraSpell)
          .where('racemask', racemask)
          .where('gender', gender)
          .first();
      return SpellArea.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(SpellArea data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> update(SpellArea oldData, SpellArea newData) async {
    var json = newData.toJson();
    json.remove('spell');
    json.remove('area');
    json.remove('quest_start');
    json.remove('aura_spell');
    json.remove('racemask');
    json.remove('gender');
    await laconic
        .table(_table)
        .where('spell', oldData.spell)
        .where('area', oldData.area)
        .where('quest_start', oldData.questStart)
        .where('aura_spell', oldData.auraSpell)
        .where('racemask', oldData.racemask)
        .where('gender', oldData.gender)
        .update(json);
  }

  Future<void> delete(int spell, int area, int questStart, int auraSpell,
      int racemask, int gender) async {
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

  Future<SpellArea> copy(SpellArea data) async {
    var json = data.toJson();
    var maxAreaResult = await laconic
        .table(_table)
        .select(['MAX(area) AS maxArea'])
        .where('spell', data.spell)
        .first();
    var maxArea = (maxAreaResult.toMap()['maxArea'] ?? 0) as int;
    json['area'] = maxArea + 1;
    await laconic.table(_table).insert([json]);
    return SpellArea.fromJson(json);
  }
}
