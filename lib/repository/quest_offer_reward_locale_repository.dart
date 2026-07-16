import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestOfferRewardLocaleRepository with RepositoryMixin {
  static const _table = 'quest_offer_reward_locale';

  Future<void> copyQuestOfferRewardLocale(int id, String locale) async {
    // Locales are keyed by locale string; shallow copy is a no-op without a new locale.
    final source = await getQuestOfferRewardLocale(id, locale);
    if (source == null) return;
  }

  Future<int> countQuestOfferRewardLocales() async {
    return laconic.table(_table).count();
  }

  Future<QuestOfferRewardLocaleEntity> createQuestOfferRewardLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestOfferRewardLocaleEntity(id: id, locale: locale);
  }

  Future<void> destroyQuestOfferRewardLocale(int id, String locale) async {
    await laconic
        .table(_table)
        .where('ID', id)
        .where('locale', locale)
        .delete();
  }

  Future<List<BriefQuestOfferRewardLocaleEntity>>
  getBriefQuestOfferRewardLocales({int page = 1}) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'RewardText'])
        .orderBy('ID')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestOfferRewardLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<QuestOfferRewardLocaleEntity?> getQuestOfferRewardLocale(
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
    return QuestOfferRewardLocaleEntity.fromJson(results.first.toMap());
  }

  Future<List<QuestOfferRewardLocaleEntity>>
  getQuestOfferRewardLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestOfferRewardLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestOfferRewardLocaleEntity>> getQuestOfferRewardLocales(
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => QuestOfferRewardLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveQuestOfferRewardLocale(
    QuestOfferRewardLocaleEntity model,
  ) async {
    final existing = await getQuestOfferRewardLocale(model.id, model.locale);
    if (existing == null) {
      await storeQuestOfferRewardLocale(model);
    } else {
      await updateQuestOfferRewardLocale(model.id, model.locale, model);
    }
  }

  Future<void> saveQuestOfferRewardLocales(
    int id,
    List<QuestOfferRewardLocaleEntity> locales,
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

  Future<void> storeQuestOfferRewardLocale(
    QuestOfferRewardLocaleEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateQuestOfferRewardLocale(
    int id,
    String locale,
    QuestOfferRewardLocaleEntity model,
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
}
