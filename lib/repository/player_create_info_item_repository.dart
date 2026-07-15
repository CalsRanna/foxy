import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PlayerCreateInfoItemRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_item';

  Future<List<PlayerCreateInfoItemEntity>> getBriefPlayerCreateInfoItems(
    int race,
    int class_,
  ) async {
    var results = await laconic
        .table(_table)
        .whereRaw('(`race` = 0 OR `race` = ?)', [race])
        .whereRaw('(`class` = 0 OR `class` = ?)', [class_])
        .orderBy('race')
        .orderBy('`class`')
        .orderBy('itemid')
        .get();
    return results
        .map((e) => PlayerCreateInfoItemEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoItemEntity?> getPlayerCreateInfoItem(
    int race,
    int class_,
    int itemid,
  ) async {
    var results = await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .where('itemid', itemid)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoItemEntity.fromJson(results.first.toMap());
  }

  Future<PlayerCreateInfoItemEntity> createPlayerCreateInfoItem(
    int race,
    int class_,
  ) async {
    return PlayerCreateInfoItemEntity(race: race, class_: class_);
  }

  Future<void> storePlayerCreateInfoItem(
    PlayerCreateInfoItemEntity item,
  ) async {
    await laconic.table(_table).insert([item.toJson()]);
  }

  Future<void> updatePlayerCreateInfoItem(
    int race,
    int class_,
    int itemid,
    PlayerCreateInfoItemEntity item,
  ) async {
    var json = item.toJson();
    json.remove('race');
    json.remove('class');
    json.remove('itemid');
    await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .where('itemid', itemid)
        .update(json);
  }

  Future<void> destroyPlayerCreateInfoItem(
    int race,
    int class_,
    int itemid,
  ) async {
    await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .where('itemid', itemid)
        .delete();
  }

  Future<void> copyPlayerCreateInfoItem(
    int race,
    int class_,
    int itemid,
  ) async {
    throw UnsupportedError('物品 ID 是复合主键的一部分，请新增并选择有效物品。');
  }

  Future<void> savePlayerCreateInfoItem(PlayerCreateInfoItemEntity item) async {
    var existing = await getPlayerCreateInfoItem(
      item.race,
      item.class_,
      item.itemid,
    );
    if (existing != null) {
      await updatePlayerCreateInfoItem(
        item.race,
        item.class_,
        item.itemid,
        item,
      );
    } else {
      await storePlayerCreateInfoItem(item);
    }
  }
}
