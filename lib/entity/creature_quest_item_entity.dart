import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_quest_item_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('itemLocaleName')
@FoxyBriefField.integer('itemQuality')
@FoxyBriefField.text('itemIcon')
@FoxyFullEntity(table: 'creature_questitem')
class CreatureQuestItemEntity with _CreatureQuestItemEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('CreatureEntry', key: true)
  final int creatureEntry;

  @FoxyBriefField()
  @FoxyFullField('Idx', key: true)
  final int idx;

  @FoxyBriefField()
  @FoxyFullField('ItemId')
  final int itemId;

  @FoxyBriefField()
  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const CreatureQuestItemEntity({
    this.creatureEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureQuestItemEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureQuestItemEntityMixin.fromJson(json);
}

extension BriefCreatureQuestItemEntityDisplay on BriefCreatureQuestItemEntity {
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}
