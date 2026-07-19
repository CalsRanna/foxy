import 'package:foxy/entity/brief_quest_offer_reward_locale_entity.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/entity/quest_offer_reward_locale_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class QuestOfferRewardLocaleRepository with RepositoryMixin {
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

  Future<void> destroyQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原任务奖励本地化记录不存在，可能已被其他操作修改或删除');
    }
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

  Future<QuestOfferRewardLocaleEntity?> getQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
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

  Future<void> storeQuestOfferRewardLocale(
    QuestOfferRewardLocaleEntity model,
  ) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('任务奖励本地化主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateQuestOfferRewardLocale(
    QuestOfferRewardLocaleKey originalKey,
    QuestOfferRewardLocaleEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原任务奖励本地化记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的任务奖励本地化主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, QuestOfferRewardLocaleKey key) {
    return builder.where('ID', key.id).where('locale', key.locale);
  }
}
