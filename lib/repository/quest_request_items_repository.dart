import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestRequestItemsRepository with RepositoryMixin {
  static const _table = 'quest_request_items';

  Future<QuestRequestItemsEntity?> getQuestRequestItems(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestRequestItemsEntity.fromJson(results.first.toMap());
  }

  Future<QuestRequestItemsEntity> createQuestRequestItems([
    int id = 0,
  ]) async {
    return QuestRequestItemsEntity(id: id);
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

  Future<void> destroyQuestRequestItems(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyQuestRequestItems(int id) async {
    var source = await getQuestRequestItems(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveQuestRequestItems(QuestRequestItemsEntity model) async {
    var existing = await getQuestRequestItems(model.id);
    if (existing != null) {
      await updateQuestRequestItems(model.id, model);
    } else {
      await storeQuestRequestItems(model);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }
}
