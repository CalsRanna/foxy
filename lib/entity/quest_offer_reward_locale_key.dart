import 'package:flutter/foundation.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';

@immutable
final class QuestOfferRewardLocaleKey {
  final int id;
  final String locale;

  const QuestOfferRewardLocaleKey({required this.id, required this.locale});

  factory QuestOfferRewardLocaleKey.fromEntity(
    QuestOfferRewardLocaleEntity value,
  ) {
    return QuestOfferRewardLocaleKey(id: value.id, locale: value.locale);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is QuestOfferRewardLocaleKey &&
            id == other.id &&
            locale == other.locale;
  }

  @override
  int get hashCode => Object.hash(id, locale);
}
