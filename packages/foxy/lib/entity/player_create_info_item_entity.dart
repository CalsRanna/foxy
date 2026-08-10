import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'player_create_info_item_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_item')
class PlayerCreateInfoItemEntity with _PlayerCreateInfoItemEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('race', key: true)
  final int race;

  @FoxyBriefField()
  @FoxyFullField('class', key: true)
  final int class_;

  @FoxyBriefField()
  @FoxyFullField('itemid', key: true)
  final int itemId;

  @FoxyBriefField()
  @FoxyFullField('amount')
  final int amount;

  @FoxyBriefField()
  @FoxyFullField('Note')
  final String note;

  const PlayerCreateInfoItemEntity({
    this.race = 0,
    this.class_ = 0,
    this.itemId = 0,
    this.amount = 1,
    this.note = '',
  });

  factory PlayerCreateInfoItemEntity.fromJson(Map<String, dynamic> json) =>
      _PlayerCreateInfoItemEntityMixin.fromJson(json);
}

extension BriefPlayerCreateInfoItemEntityLabel
    on BriefPlayerCreateInfoItemEntity {
  /// 种族标签（人类/兽人/…），未知值回退为原始数字。
  String get raceLabel =>
      PlayerCreateInfoConstants.playerRaceOptions[race] ?? race.toString();

  /// 职业标签（战士/圣骑士/…），未知值回退为原始数字。
  String get classLabel =>
      PlayerCreateInfoConstants.playerClassOptions[class_] ?? class_.toString();
}
