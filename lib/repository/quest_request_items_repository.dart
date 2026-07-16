import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestRequestItemsRepository with RepositoryMixin {
  static const _table = 'quest_request_items';

  Future<void> copyQuestRequestItems(int id) async {
    var source = await getQuestRequestItems(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countQuestRequestItems() async {
    return laconic.table(_table).count();
  }

  Future<QuestRequestItemsEntity> createQuestRequestItems([int id = 0]) async {
    return QuestRequestItemsEntity(id: id);
  }

  Future<void> destroyQuestRequestItems(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefQuestRequestItemsEntity>> getBriefQuestRequestItems({
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'EmoteOnComplete',
      'EmoteOnIncomplete',
      'CompletionText',
    ]);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestRequestItemsEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestRequestItemsEntity?> getQuestRequestItems(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestRequestItemsEntity>> getQuestRequestItemsList() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => QuestRequestItemsEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestRequestItems(QuestRequestItemsEntity model) async {
    var existing = await getQuestRequestItems(model.id);
    if (existing != null) {
      await updateQuestRequestItems(model.id, model);
    } else {
      await storeQuestRequestItems(model);
    }
  }

  Future<void> storeQuestRequestItems(QuestRequestItemsEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestRequestItems(
    int id,
    QuestRequestItemsEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }
}
