// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_item_entity.key.g.dart';

final class BriefPlayerCreateInfoItemEntity {
  final int race;
  final int class_;
  final int itemId;
  final int amount;
  final String note;

  const BriefPlayerCreateInfoItemEntity({
    this.race = 0,
    this.class_ = 0,
    this.itemId = 0,
    this.amount = 1,
    this.note = '',
  });

  factory BriefPlayerCreateInfoItemEntity.fromJson(Map<String, dynamic> json) {
    return BriefPlayerCreateInfoItemEntity(
      race: (json['race'] as num?)?.toInt() ?? 0,
      class_: (json['class'] as num?)?.toInt() ?? 0,
      itemId: (json['itemid'] as num?)?.toInt() ?? 0,
      amount: (json['amount'] as num?)?.toInt() ?? 1,
      note: json['Note']?.toString() ?? '',
    );
  }

  PlayerCreateInfoItemKey get key {
    return PlayerCreateInfoItemKey(race: race, class_: class_, itemId: itemId);
  }
}
