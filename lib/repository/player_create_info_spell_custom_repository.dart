import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoSpellCustomRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_spell_custom';

  Future<List<PlayerCreateInfoSpellCustomEntity>>
  getBriefPlayerCreateInfoSpellCustoms(int racemask, int classmask) async {
    var results = await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .get();
    return results
        .map((e) => PlayerCreateInfoSpellCustomEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoSpellCustomEntity?> getPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
  ) async {
    var results = await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoSpellCustomEntity.fromJson(results.first.toMap());
  }

  Future<PlayerCreateInfoSpellCustomEntity> createPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
  ) async {
    return PlayerCreateInfoSpellCustomEntity(
      racemask: racemask,
      classmask: classmask,
    );
  }

  Future<void> storePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity spell,
  ) async {
    await laconic.table(_table).insert([spell.toJson()]);
  }

  Future<void> updatePlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
    PlayerCreateInfoSpellCustomEntity entity,
  ) async {
    var json = entity.toJson();
    json.remove('racemask');
    json.remove('classmask');
    json.remove('Spell');
    await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .update(json);
  }

  Future<void> destroyPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
  ) async {
    await laconic
        .table(_table)
        .where('racemask', racemask)
        .where('classmask', classmask)
        .where('spell', spell)
        .delete();
  }

  Future<void> copyPlayerCreateInfoSpellCustom(
    int racemask,
    int classmask,
    int spell,
  ) async {
    var source = await getPlayerCreateInfoSpellCustom(
      racemask,
      classmask,
      spell,
    );
    if (source == null) return;
    var json = source.toJson();
    json['Spell'] = spell + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> savePlayerCreateInfoSpellCustom(
    PlayerCreateInfoSpellCustomEntity entity,
  ) async {
    var existing = await getPlayerCreateInfoSpellCustom(
      entity.racemask,
      entity.classmask,
      entity.spell,
    );
    if (existing != null) {
      await updatePlayerCreateInfoSpellCustom(
        entity.racemask,
        entity.classmask,
        entity.spell,
        entity,
      );
    } else {
      await storePlayerCreateInfoSpellCustom(entity);
    }
  }
}