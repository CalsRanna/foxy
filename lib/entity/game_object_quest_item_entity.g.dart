// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_item_entity.dart';

final class BriefGameObjectQuestItemEntity {
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
      gameObjectEntry: json['GameObjectEntry'] == true
          ? 1
          : json['GameObjectEntry'] == false
          ? 0
          : (json['GameObjectEntry'] as num?)?.toInt() ?? 0,
      idx: json['Idx'] == true
          ? 1
          : json['Idx'] == false
          ? 0
          : (json['Idx'] as num?)?.toInt() ?? 0,
      itemId: json['ItemId'] == true
          ? 1
          : json['ItemId'] == false
          ? 0
          : (json['ItemId'] as num?)?.toInt() ?? 0,
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
      itemName: json['itemName']?.toString() ?? '',
      itemLocaleName: json['itemLocaleName']?.toString() ?? '',
      itemQuality: json['itemQuality'] == true
          ? 1
          : json['itemQuality'] == false
          ? 0
          : (json['itemQuality'] as num?)?.toInt() ?? 0,
      itemIcon: json['itemIcon']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    gameObjectEntry,
    idx,
    itemId,
    verifiedBuild,
    itemName,
    itemLocaleName,
    itemQuality,
    itemIcon,
  ]);

  GameObjectQuestItemKey get key {
    return GameObjectQuestItemKey(gameObjectEntry: gameObjectEntry, idx: idx);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefGameObjectQuestItemEntity &&
            gameObjectEntry == other.gameObjectEntry &&
            idx == other.idx &&
            itemId == other.itemId &&
            verifiedBuild == other.verifiedBuild &&
            itemName == other.itemName &&
            itemLocaleName == other.itemLocaleName &&
            itemQuality == other.itemQuality &&
            itemIcon == other.itemIcon;
  }

  @override
  String toString() {
    return 'BriefGameObjectQuestItemEntity('
        'gameObjectEntry: $gameObjectEntry, '
        'idx: $idx, '
        'itemId: $itemId, '
        'verifiedBuild: $verifiedBuild, '
        'itemName: $itemName, '
        'itemLocaleName: $itemLocaleName, '
        'itemQuality: $itemQuality, '
        'itemIcon: $itemIcon'
        ')';
  }
}

final class GameObjectQuestItemKey {
  final int gameObjectEntry;
  final int idx;

  const GameObjectQuestItemKey({
    required this.gameObjectEntry,
    required this.idx,
  });

  factory GameObjectQuestItemKey.fromEntity(GameObjectQuestItemEntity entity) {
    return GameObjectQuestItemKey(
      gameObjectEntry: entity.gameObjectEntry,
      idx: entity.idx,
    );
  }

  @override
  int get hashCode => Object.hashAll([gameObjectEntry, idx]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectQuestItemKey &&
            gameObjectEntry == other.gameObjectEntry &&
            idx == other.idx;
  }

  @override
  String toString() {
    return 'GameObjectQuestItemKey('
        'gameObjectEntry: $gameObjectEntry, '
        'idx: $idx'
        ')';
  }
}

mixin _GameObjectQuestItemEntityMixin {
  @override
  int get hashCode {
    final self = this as GameObjectQuestItemEntity;
    return Object.hashAll([
      self.runtimeType,
      self.gameObjectEntry,
      self.idx,
      self.itemId,
      self.verifiedBuild,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as GameObjectQuestItemEntity;
    return identical(self, other) ||
        other is GameObjectQuestItemEntity &&
            self.runtimeType == other.runtimeType &&
            self.gameObjectEntry == other.gameObjectEntry &&
            self.idx == other.idx &&
            self.itemId == other.itemId &&
            self.verifiedBuild == other.verifiedBuild;
  }

  GameObjectQuestItemEntity copyWith({
    int? gameObjectEntry,
    int? idx,
    int? itemId,
    int? verifiedBuild,
  }) {
    final self = this as GameObjectQuestItemEntity;
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry ?? self.gameObjectEntry,
      idx: idx ?? self.idx,
      itemId: itemId ?? self.itemId,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GameObjectQuestItemEntity;
    return {
      'GameObjectEntry': self.gameObjectEntry,
      'Idx': self.idx,
      'ItemId': self.itemId,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  String toString() {
    final self = this as GameObjectQuestItemEntity;
    return 'GameObjectQuestItemEntity('
        'gameObjectEntry: ${self.gameObjectEntry}, '
        'idx: ${self.idx}, '
        'itemId: ${self.itemId}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }

  static GameObjectQuestItemEntity fromJson(Map<String, dynamic> json) {
    return GameObjectQuestItemEntity(
      gameObjectEntry: json['GameObjectEntry'] == true
          ? 1
          : json['GameObjectEntry'] == false
          ? 0
          : (json['GameObjectEntry'] as num?)?.toInt() ?? 0,
      idx: json['Idx'] == true
          ? 1
          : json['Idx'] == false
          ? 0
          : (json['Idx'] as num?)?.toInt() ?? 0,
      itemId: json['ItemId'] == true
          ? 1
          : json['ItemId'] == false
          ? 0
          : (json['ItemId'] as num?)?.toInt() ?? 0,
      verifiedBuild: json['VerifiedBuild'] == true
          ? 1
          : json['VerifiedBuild'] == false
          ? 0
          : (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }
}
