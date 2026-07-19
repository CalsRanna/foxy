import 'package:foxy/entity/player_create_info_item_key.dart';

class BriefPlayerCreateInfoItemEntity {
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

  factory BriefPlayerCreateInfoItemEntity.fromJson(Map<String, dynamic> json) =>
      BriefPlayerCreateInfoItemEntity(
        race: json['race'] ?? 0,
        class_: json['class'] ?? 0,
        itemId: json['itemid'] ?? 0,
        amount: json['amount'] ?? 1,
        note: json['Note'] ?? '',
      );

  PlayerCreateInfoItemKey get key =>
      PlayerCreateInfoItemKey(race: race, class_: class_, itemId: itemId);
}
