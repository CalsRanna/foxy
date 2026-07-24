import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_quest_item_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('itemLocaleName')
@FoxyBriefField.integer('itemQuality')
@FoxyBriefField.text('itemIcon')
@FoxyFullEntity(table: 'gameobject_questitem')
class GameObjectQuestItemEntity with _GameObjectQuestItemEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('GameObjectEntry', key: true)
  final int gameObjectEntry;

  @FoxyBriefField()
  @FoxyFullField('Idx', key: true)
  final int idx;

  @FoxyBriefField()
  @FoxyFullField('ItemId')
  final int itemId;

  @FoxyBriefField()
  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const GameObjectQuestItemEntity({
    this.gameObjectEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
  });

  factory GameObjectQuestItemEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectQuestItemEntityMixin.fromJson(json);
}

extension BriefGameObjectQuestItemEntityDisplay
    on BriefGameObjectQuestItemEntity {
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}
