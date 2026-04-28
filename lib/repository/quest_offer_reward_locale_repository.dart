import 'package:foxy/model/quest_offer_reward.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// quest_offer_reward_locale 表的数据访问层
/// 复合主键: (ID, Locale)
class QuestOfferRewardLocaleRepository with RepositoryMixin {
  static const _table = 'quest_offer_reward_locale';

  /// 按 ID 查询该 QuestOfferReward 的所有 locale
  Future<List<QuestOfferRewardLocale>> getQuestOfferRewardLocales(int id) async {
    try {
      final results = await laconic.table(_table).where('ID', id).get();
      return results
          .map((e) => QuestOfferRewardLocale.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 删除-然后-重新插入模式（replaceAll）
  Future<void> replaceAll(int id, List<QuestOfferRewardLocale> locales) async {
    await laconic.table(_table).where('ID', id).delete();
    if (locales.isNotEmpty) {
      await laconic
          .table(_table)
          .insert(locales.map((l) => l.toJson()).toList());
    }
  }
}
