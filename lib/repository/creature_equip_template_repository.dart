import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureEquipTemplateRepository with RepositoryMixin {
  static const _table = 'creature_equip_template';

  Future<List<BriefCreatureEquipTemplateEntity>> getBriefCreatureEquipTemplates(
    int creatureID,
  ) async {
    var builder = laconic.table('$_table AS cet');
    const fields = [
      'cet.*',
      'it1.name as name_1',
      'itl1.Name as localeName_1',
      'it1.Quality as Quality_1',
      'didi1.InventoryIcon0 as Icon_1',
      'it2.name as name_2',
      'itl2.Name as localeName_2',
      'it2.Quality as Quality_2',
      'didi2.InventoryIcon0 as Icon_2',
      'it3.name as name_3',
      'itl3.Name as localeName_3',
      'it3.Quality as Quality_3',
      'didi3.InventoryIcon0 as Icon_3',
    ];
    builder = builder.select(fields);
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
    return results
        .map((e) => BriefCreatureEquipTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureEquipTemplateEntity?> getCreatureEquipTemplate(
    int creatureID,
    int id,
  ) async {
    var results = await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('ID', id)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureEquipTemplateEntity.fromJson(results.first.toMap());
  }

  Future<CreatureEquipTemplateEntity> createCreatureEquipTemplate(
    int creatureID,
  ) async {
    var nextId = await getNextId(creatureID);
    return CreatureEquipTemplateEntity(creatureID: creatureID, id: nextId);
  }

  Future<void> storeCreatureEquipTemplate(
    CreatureEquipTemplateEntity equip,
  ) async {
    await laconic.table(_table).insert([equip.toJson()]);
  }

  Future<void> updateCreatureEquipTemplate(
    CreatureEquipTemplateEntity equip,
  ) async {
    var json = equip.toJson();
    json.remove('CreatureID');
    json.remove('ID');
    await laconic
        .table(_table)
        .where('CreatureID', equip.creatureID)
        .where('ID', equip.id)
        .update(json);
  }

  Future<void> destroyCreatureEquipTemplate(int creatureID, int id) async {
    await laconic
        .table(_table)
        .where('CreatureID', creatureID)
        .where('ID', id)
        .delete();
  }

  Future<void> copyCreatureEquipTemplate(int creatureID, int id) async {
    var source = await getCreatureEquipTemplate(creatureID, id);
    if (source == null) return;
    var nextId = await getNextId(creatureID);
    var json = source.toJson();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureEquipTemplate(
    CreatureEquipTemplateEntity equip,
  ) async {
    var existing = await getCreatureEquipTemplate(equip.creatureID, equip.id);
    if (existing != null) {
      await updateCreatureEquipTemplate(equip);
    } else {
      await storeCreatureEquipTemplate(equip);
    }
  }

  Future<int> getNextId(int creatureID) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(ID) AS maxId'])
        .where('CreatureID', creatureID)
        .first();
    var maxId = (maxResult.toMap()['maxId'] ?? 0) as int;
    return maxId + 1;
  }
}
