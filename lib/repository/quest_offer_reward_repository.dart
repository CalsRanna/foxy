import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// quest_offer_reward 表的数据访问层
///
/// 1:1 子表，主键 ID 与 quest_template 共享。
/// 仅提供 find/create/store/update 四个操作。
class QuestOfferRewardRepository with RepositoryMixin {
  static const _table = 'quest_offer_reward';

  /// 根据 ID 查找
  Future<QuestOfferRewardEntity?> getQuestOfferReward(int id) async {
    try {
      final result = await laconic.table(_table).where('ID', id).first();
      return QuestOfferRewardEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 创建：返回与 quest_template ID 关联的空白对象（不落库）
  Future<QuestOfferRewardEntity> createQuestOfferReward(int id) async {
    final model = QuestOfferRewardEntity(id: id);
    return model;
  }

  /// 存储（insert）
  Future<void> storeQuestOfferReward(QuestOfferRewardEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// 更新（根据 ID）
  Future<void> updateQuestOfferReward(
    int id,
    QuestOfferRewardEntity model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }
}
