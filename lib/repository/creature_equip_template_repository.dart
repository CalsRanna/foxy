import 'package:foxy/model/creature_equip_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureEquipTemplateRepository with RepositoryMixin {
  static const _table = 'creature_equip_template';

  /// 获取指定生物的所有装备模板（带物品信息）
  Future<List<CreatureEquipTemplate>> getByEntry(int creatureID) async {
    try {
      var builder = laconic.table('$_table AS cet');

      // 选择字段，包含3个装备槽的完整信息
      const fields = [
        'cet.*',
        'it1.name as name_1',
        'itl1.Name as localeName_1',
        'it1.Quality as Quality_1',
        'didi1.InventoryIcon_1 as Icon_1',
        'it2.name as name_2',
        'itl2.Name as localeName_2',
        'it2.Quality as Quality_2',
        'didi2.InventoryIcon_1 as Icon_2',
        'it3.name as name_3',
        'itl3.Name as localeName_3',
        'it3.Quality as Quality_3',
        'didi3.InventoryIcon_1 as Icon_3',
      ];

      builder = builder.select(fields);

      // 装备1的JOIN
      builder = builder.leftJoin(
        'item_template AS it1',
        (join) => join.on('cet.ItemID1', 'it1.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl1',
        (join) => join.on('cet.ItemID1', 'itl1.ID').on('itl1.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi1',
        (join) => join.on('it1.displayid', 'didi1.ID'),
      );

      // 装备2的JOIN
      builder = builder.leftJoin(
        'item_template AS it2',
        (join) => join.on('cet.ItemID2', 'it2.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl2',
        (join) => join.on('cet.ItemID2', 'itl2.ID').on('itl2.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi2',
        (join) => join.on('it2.displayid', 'didi2.ID'),
      );

      // 装备3的JOIN
      builder = builder.leftJoin(
        'item_template AS it3',
        (join) => join.on('cet.ItemID3', 'it3.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl3',
        (join) => join.on('cet.ItemID3', 'itl3.ID').on('itl3.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi3',
        (join) => join.on('it3.displayid', 'didi3.ID'),
      );

      builder = builder.where('cet.CreatureID', creatureID);
      builder = builder.orderBy('cet.ID');
      var results = await builder.get();
      return results.map((e) => CreatureEquipTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<CreatureEquipTemplate?> find(int creatureID, int id) async {
    try {
      var result = await laconic
          .table(_table)
          .where('CreatureID', creatureID)
          .where('ID', id)
          .first();
      return result != null ? CreatureEquipTemplate.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }

  /// 新增装备模板
  Future<void> store(CreatureEquipTemplate equip) async {
    await laconic.table(_table).insert([equip.toJson()]);
  }

  /// 更新装备模板
  Future<void> update(CreatureEquipTemplate equip) async {
    var json = equip.toJson();
    json.remove('CreatureID');
    json.remove('ID');
    await laconic
        .table(_table)
        .where('CreatureID', equip.creatureID)
        .where('ID', equip.id)
        .update(json);
  }

  /// 删除装备模板
  Future<void> delete(int creatureID, int id) async {
    await laconic.table(_table).where('CreatureID', creatureID).where('ID', id).delete();
  }

  /// 复制装备模板
  Future<CreatureEquipTemplate> copy(int creatureID, int id) async {
    // 获取最大ID
    var maxIdResult = await laconic
        .table(_table)
        .select(['MAX(ID) AS maxId'])
        .where('CreatureID', creatureID)
        .first();
    var maxId = (maxIdResult?.toMap()['maxId'] ?? 0) as int;

    // 获取源记录
    var source = await find(creatureID, id);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newEquip = CreatureEquipTemplate.fromJson(source.toJson());
    newEquip.id = maxId + 1;

    await store(newEquip);
    return newEquip;
  }

  /// 获取下一个可用的ID
  Future<int> getNextId(int creatureID) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(ID) AS maxId'])
        .where('CreatureID', creatureID)
        .first();
    var maxId = (maxResult?.toMap()['maxId'] ?? 0) as int;
    return maxId + 1;
  }
}
