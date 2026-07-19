import 'package:foxy/entity/quest_offer_reward_entity.dart';

final class QuestOfferRewardKey {
  final int id;

  const QuestOfferRewardKey({required this.id});

  factory QuestOfferRewardKey.fromEntity(QuestOfferRewardEntity entity) {
    return QuestOfferRewardKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuestOfferRewardKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
