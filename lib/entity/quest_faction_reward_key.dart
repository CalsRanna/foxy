import 'package:foxy/entity/quest_faction_reward_entity.dart';

class QuestFactionRewardKey {
  final int id;

  const QuestFactionRewardKey({required this.id});

  factory QuestFactionRewardKey.fromEntity(QuestFactionRewardEntity entity) {
    return QuestFactionRewardKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestFactionRewardKey && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
