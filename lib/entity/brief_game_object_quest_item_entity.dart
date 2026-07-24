import 'package:foxy/entity/game_object_quest_item_entity.dart';

class BriefGameObjectQuestItemEntity {
  final int gameObjectEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  const BriefGameObjectQuestItemEntity({
    this.gameObjectEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory BriefGameObjectQuestItemEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectQuestItemEntity(
      gameObjectEntry: json['GameObjectEntry'] ?? 0,
      idx: json['Idx'] ?? 0,
      itemId: json['ItemId'] ?? 0,
      verifiedBuild: json['VerifiedBuild'] ?? 0,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
    );
  }

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  GameObjectQuestItemKey get key =>
      GameObjectQuestItemKey(gameObjectEntry: gameObjectEntry, idx: idx);
}
