import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureQuestItemRepository with RepositoryMixin {
  static const _table = 'creature_questitem';

  Future<List<CreatureQuestItemEntity>> getBriefCreatureQuestItems(
    int creatureEntry,
  ) async {
    var builder = laconic.table('$_table AS cq');
    final fields = <String>[
      'cq.*',
      'it.name',
      if (localeEnabled) 'itl.Name AS localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('cq.ItemId', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('cq.ItemId', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('cq.CreatureEntry', creatureEntry);
    builder = builder.orderBy('cq.Idx');
    var results = await builder.get();
    return results
        .map((e) => CreatureQuestItemEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureQuestItemEntity?> getCreatureQuestItem(
    int creatureEntry,
    int idx,
  ) async {
    var results = await laconic
        .table(_table)
        .where('CreatureEntry', creatureEntry)
        .where('Idx', idx)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureQuestItemEntity.fromJson(results.first.toMap());
  }

  Future<CreatureQuestItemEntity> createCreatureQuestItem(
    int creatureEntry,
  ) async {
    var nextIdx = await getNextIdx(creatureEntry);
    return CreatureQuestItemEntity(creatureEntry: creatureEntry, idx: nextIdx);
  }

  Future<void> storeCreatureQuestItem(CreatureQuestItemEntity questItem) async {
    await laconic.table(_table).insert([questItem.toJson()]);
  }

  Future<void> updateCreatureQuestItem(
    CreatureQuestItemEntity questItem,
  ) async {
    var json = questItem.toJson();
    json.remove('CreatureEntry');
    json.remove('Idx');
    await laconic
        .table(_table)
        .where('CreatureEntry', questItem.creatureEntry)
        .where('Idx', questItem.idx)
        .update(json);
  }

  Future<void> destroyCreatureQuestItem(int creatureEntry, int idx) async {
    await laconic
        .table(_table)
        .where('CreatureEntry', creatureEntry)
        .where('Idx', idx)
        .delete();
  }

  Future<void> copyCreatureQuestItem(int creatureEntry, int idx) async {
    var source = await getCreatureQuestItem(creatureEntry, idx);
    if (source == null) return;
    var nextIdx = await getNextIdx(creatureEntry);
    var json = source.toJson();
    json['Idx'] = nextIdx;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureQuestItem(CreatureQuestItemEntity questItem) async {
    var existing = await getCreatureQuestItem(
      questItem.creatureEntry,
      questItem.idx,
    );
    if (existing != null) {
      await updateCreatureQuestItem(questItem);
    } else {
      await storeCreatureQuestItem(questItem);
    }
  }

  Future<int> getNextIdx(int creatureEntry) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(Idx) AS maxIdx'])
        .where('CreatureEntry', creatureEntry)
        .first();
    var maxIdx = (maxResult.toMap()['maxIdx'] ?? 0) as int;
    return maxIdx + 1;
  }
}
