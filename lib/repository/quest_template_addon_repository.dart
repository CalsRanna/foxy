import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestTemplateAddonRepository with RepositoryMixin {
  static const _table = 'quest_template_addon';

  Future<void> copyQuestTemplateAddon(int id) async {
    var source = await getQuestTemplateAddon(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countQuestTemplateAddons() async {
    return laconic.table(_table).count();
  }

  Future<QuestTemplateAddonEntity> createQuestTemplateAddon([
    int id = 0,
  ]) async {
    return QuestTemplateAddonEntity(id: id);
  }

  Future<void> destroyQuestTemplateAddon(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefQuestTemplateAddonEntity>> getBriefQuestTemplateAddons({
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'MaxLevel',
      'PrevQuestID',
      'NextQuestID',
      'SpecialFlags',
    ]);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestTemplateAddonEntity?> getQuestTemplateAddon(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return QuestTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestTemplateAddonEntity>> getQuestTemplateAddons() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => QuestTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestTemplateAddon(QuestTemplateAddonEntity model) async {
    var existing = await getQuestTemplateAddon(model.id);
    if (existing != null) {
      await updateQuestTemplateAddon(model.id, model);
    } else {
      await storeQuestTemplateAddon(model);
    }
  }

  Future<void> storeQuestTemplateAddon(QuestTemplateAddonEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestTemplateAddon(
    int id,
    QuestTemplateAddonEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }
}
