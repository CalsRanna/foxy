import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class QuestOfferRewardLocaleRepository with RepositoryMixin {
  static const _table = 'quest_offer_reward_locale';

  Future<List<QuestOfferRewardLocaleEntity>> getQuestOfferRewardLocales(
    int id,
  ) async {
    final results = await laconic.table(_table).where('ID', id).get();
    return results
        .map((e) => QuestOfferRewardLocaleEntity.fromJson(e.toMap()))
        .toList();
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
}
