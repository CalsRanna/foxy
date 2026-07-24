import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

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
