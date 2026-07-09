import 'package:foxy/entity/quest_template_locale_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestTemplateLocaleRepository with RepositoryMixin {
  static const _table = 'quest_template_locale';

  Future<List<BriefQuestTemplateLocaleEntity>> getBriefQuestTemplateLocales({
    int page = 1,
  }) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'Title'])
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestTemplateLocaleEntity>>
  getQuestTemplateLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countQuestTemplateLocales() async {
    return laconic.table(_table).count();
  }

  Future<QuestTemplateLocaleEntity?> getQuestTemplateLocale(
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
    return QuestTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<QuestTemplateLocaleEntity> createQuestTemplateLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestTemplateLocaleEntity(id: id, locale: locale);
  }

  Future<void> storeQuestTemplateLocale(
    QuestTemplateLocaleEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestTemplateLocale(
    int id,
    String locale,
    QuestTemplateLocaleEntity model,
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

  Future<void> destroyQuestTemplateLocale(int id, String locale) async {
    await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .delete();
  }

  Future<void> copyQuestTemplateLocale(int id, String locale) async {
    // Locales are keyed by locale string; shallow copy is a no-op without a new locale.
    final source = await getQuestTemplateLocale(id, locale);
    if (source == null) return;
  }

  Future<void> saveQuestTemplateLocale(QuestTemplateLocaleEntity model) async {
    final existing = await getQuestTemplateLocale(model.id, model.locale);
    if (existing == null) {
      await storeQuestTemplateLocale(model);
    } else {
      await updateQuestTemplateLocale(model.id, model.locale, model);
    }
  }

  Future<List<QuestTemplateLocaleEntity>> getQuestTemplateLocales(
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => QuestTemplateLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestTemplateLocales(
    int id,
    List<QuestTemplateLocaleEntity> locales,
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
