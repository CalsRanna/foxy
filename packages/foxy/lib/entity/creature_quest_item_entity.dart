import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'creature_quest_item_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('itemLocaleName')
@FoxyBriefField.integer('itemQuality')
@FoxyBriefField.text('itemIcon')
@FoxyFullEntity(table: 'creature_questitem')
class CreatureQuestItemEntity with _CreatureQuestItemEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('生物', table: 'creature_template', column: 'entry')
  @FoxyFullField('CreatureEntry', key: true)
  final int creatureEntry;

  @FoxyBriefField()
  @FoxyFullField('Idx', key: true)
  final int idx;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('物品', table: 'item_template', column: 'entry')
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
