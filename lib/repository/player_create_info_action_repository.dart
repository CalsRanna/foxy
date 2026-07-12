import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoActionRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_action';

  Future<List<PlayerCreateInfoActionEntity>> getBriefPlayerCreateInfoActions(
    int race,
    int class_,
  ) async {
    var results = await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .get();
    return results
        .map((e) => PlayerCreateInfoActionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoActionEntity?> getPlayerCreateInfoAction(
    int race,
    int class_,
    int button,
  ) async {
    var results = await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .where('button', button)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoActionEntity.fromJson(results.first.toMap());
  }

  Future<PlayerCreateInfoActionEntity> createPlayerCreateInfoAction(
    int race,
    int class_,
  ) async {
    return PlayerCreateInfoActionEntity(race: race, class_: class_);
  }

  Future<void> storePlayerCreateInfoAction(
    PlayerCreateInfoActionEntity action,
  ) async {
    await laconic.table(_table).insert([action.toJson()]);
  }

  Future<void> updatePlayerCreateInfoAction(
    int race,
    int class_,
    int button,
    PlayerCreateInfoActionEntity action,
  ) async {
    var json = action.toJson();
    json.remove('race');
    json.remove('class');
    await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .where('button', button)
        .update(json);
  }

  Future<void> destroyPlayerCreateInfoAction(
    int race,
    int class_,
    int button,
  ) async {
    await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .where('button', button)
        .delete();
  }

  Future<void> copyPlayerCreateInfoAction(
    int race,
    int class_,
    int button,
  ) async {
    var source = await getPlayerCreateInfoAction(race, class_, button);
    if (source == null) return;
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(button) AS maxButton'])
        .where('race', race)
        .where('class', class_)
        .first();
    var maxButton = (maxResult.toMap()['maxButton'] ?? 0) as int;
    var json = source.toJson();
    json['button'] = maxButton + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> savePlayerCreateInfoAction(
    PlayerCreateInfoActionEntity action,
  ) async {
    var existing = await getPlayerCreateInfoAction(
      action.race,
      action.class_,
      action.button,
    );
    if (existing != null) {
      await updatePlayerCreateInfoAction(
        action.race,
        action.class_,
        action.button,
        action,
      );
    } else {
      await storePlayerCreateInfoAction(action);
    }
  }
}
