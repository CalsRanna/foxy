import 'package:foxy/entity/quest_offer_reward_locale_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_offer_reward_locale_repository.g.dart';

@FoxyRepository(QuestOfferRewardLocaleEntity)
class QuestOfferRewardLocaleRepository
    with RepositoryMixin, _QuestOfferRewardLocaleRepositoryMixin {
  static const _table = 'quest_offer_reward_locale';
  static const primaryKeyColumns = {'ID', 'locale'};

  Future<void> applyQuestOfferRewardLocaleChanges({
    required List<QuestOfferRewardLocaleEntity> creations,
    required List<QuestOfferRewardLocaleKey> deletions,
    required Map<QuestOfferRewardLocaleKey, QuestOfferRewardLocaleEntity>
    updates,
  }) async {
    await laconic.transaction(() async {
      for (final key in deletions) {
        await destroyQuestOfferRewardLocale(key);
      }
      for (final update in updates.entries) {
        await updateQuestOfferRewardLocale(update.key, update.value);
      }
      for (final locale in creations) {
        await storeQuestOfferRewardLocale(locale);
      }
    });
  }

  Future<int> countQuestOfferRewardLocales({required int id}) async {
    return laconic.table(_table).where('ID', id).count();
  }

  Future<QuestOfferRewardLocaleEntity> createQuestOfferRewardLocale({
    int id = 0,
    String locale = 'zhCN',
  }) async {
    return QuestOfferRewardLocaleEntity(id: id, locale: locale);
  }

  Future<List<BriefQuestOfferRewardLocaleEntity>>
  getBriefQuestOfferRewardLocales({required int id, int page = 1}) async {
    final offset = (page - 1) * kPageSize;
    final results = await laconic
        .table(_table)
        .select(['ID', 'locale', 'RewardText'])
        .where('ID', id)
        .orderBy('locale')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefQuestOfferRewardLocaleEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestOfferRewardLocaleEntity>>
  getQuestOfferRewardLocaleEntities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((e) => QuestOfferRewardLocaleEntity.fromJson(e.toMap()))
        .toList();
  }
}
