import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestRequestItemsLocaleRepository with RepositoryMixin {
  static const _table = 'quest_request_items_locale';

  Future<List<BriefQuestRequestItemsLocaleEntity>>
  getBriefQuestRequestItemsLocales({int page = 1}) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'CompletionText'])
        .orderBy('ID')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestRequestItemsLocaleEntity>>
  getQuestRequestItemsLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countQuestRequestItemsLocales() async {
    return laconic.table(_table).count();
  }

  Future<QuestRequestItemsLocaleEntity?> getQuestRequestItemsLocale(
    int id,
    String locale,
  ) async {
    var results = await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return QuestRequestItemsLocaleEntity.fromJson(results.first.toMap());
  }

  Future<QuestRequestItemsLocaleEntity> createQuestRequestItemsLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestRequestItemsLocaleEntity(id: id, locale: locale);
  }

  Future<void> storeQuestRequestItemsLocale(
    QuestRequestItemsLocaleEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestRequestItemsLocale(
    int id,
    String locale,
    QuestRequestItemsLocaleEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    json.remove('locale');
    await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .update(json);
  }

  Future<void> destroyQuestRequestItemsLocale(int id, String locale) async {
    await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .delete();
  }

  Future<void> copyQuestRequestItemsLocale(int id, String locale) async {
    // Locales are keyed by locale string; shallow copy is a no-op without a new locale.
    final source = await getQuestRequestItemsLocale(id, locale);
    if (source == null) return;
  }

  Future<void> saveQuestRequestItemsLocale(
    QuestRequestItemsLocaleEntity model,
  ) async {
    final existing = await getQuestRequestItemsLocale(model.id, model.locale);
    if (existing == null) {
      await storeQuestRequestItemsLocale(model);
    } else {
      await updateQuestRequestItemsLocale(model.id, model.locale, model);
    }
  }

  Future<List<QuestRequestItemsLocaleEntity>> getQuestRequestItemsLocales(
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => QuestRequestItemsLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestRequestItemsLocales(
    int id,
    List<QuestRequestItemsLocaleEntity> locales,
  ) async {
    await laconic.transaction(() async {
      await laconic.table(_table).where('ID', id).delete();
      if (locales.isEmpty) return;
      final jsons = locales.map((e) {
        final json = e.toJson();
        json['ID'] = id;
        return json;
      }).toList();
      await laconic.table(_table).insert(jsons);
    });
  }
}
