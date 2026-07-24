import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_quest_item_entity.g.dart';

@FoxyFullEntity(table: 'gameobject_questitem')
class GameObjectQuestItemEntity with _GameObjectQuestItemEntityMixin {
  @FoxyFullField('GameObjectEntry', key: true)
  final int gameObjectEntry;

  @FoxyFullField('Idx', key: true)
  final int idx;

  @FoxyFullField('ItemId')
  final int itemId;

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
