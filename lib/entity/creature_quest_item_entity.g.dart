// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_item_entity.dart';

mixin _CreatureQuestItemEntityMixin {
  static CreatureQuestItemEntity fromJson(Map<String, dynamic> json) {
    return CreatureQuestItemEntity(
      creatureEntry: (json['CreatureEntry'] as num?)?.toInt() ?? 0,
      idx: (json['Idx'] as num?)?.toInt() ?? 0,
      itemId: (json['ItemId'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureQuestItemEntity copyWith({
    int? creatureEntry,
    int? idx,
    int? itemId,
    int? verifiedBuild,
  }) {
    final self = this as CreatureQuestItemEntity;
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntry ?? self.creatureEntry,
      idx: idx ?? self.idx,
      itemId: itemId ?? self.itemId,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureQuestItemEntity;
    return {
      'CreatureEntry': self.creatureEntry,
      'Idx': self.idx,
      'ItemId': self.itemId,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureQuestItemEntity;
    return identical(self, other) ||
        other is CreatureQuestItemEntity &&
            self.runtimeType == other.runtimeType &&
            self.creatureEntry == other.creatureEntry &&
            self.idx == other.idx &&
            self.itemId == other.itemId &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as CreatureQuestItemEntity;
    return Object.hashAll([
      self.runtimeType,
      self.creatureEntry,
      self.idx,
      self.itemId,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureQuestItemEntity;
    return 'CreatureQuestItemEntity('
        'creatureEntry: ${self.creatureEntry}, '
        'idx: ${self.idx}, '
        'itemId: ${self.itemId}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class CreatureQuestItemKey {
  final int creatureEntry;
  final int idx;

  const CreatureQuestItemKey({required this.creatureEntry, required this.idx});

  factory CreatureQuestItemKey.fromEntity(CreatureQuestItemEntity entity) {
    return CreatureQuestItemKey(
      creatureEntry: entity.creatureEntry,
      idx: entity.idx,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureQuestItemKey &&
            creatureEntry == other.creatureEntry &&
            idx == other.idx;
  }

  @override
  int get hashCode => Object.hashAll([creatureEntry, idx]);

  @override
  String toString() {
    return 'CreatureQuestItemKey('
        'creatureEntry: $creatureEntry, '
        'idx: $idx'
        ')';
  }
}

final class BriefCreatureQuestItemEntity {
  final int creatureEntry;
  final int idx;
  final int itemId;
  final int verifiedBuild;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  const BriefCreatureQuestItemEntity({
    this.creatureEntry = 0,
    this.idx = 0,
    this.itemId = 0,
    this.verifiedBuild = 0,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory BriefCreatureQuestItemEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureQuestItemEntity(
      creatureEntry: (json['CreatureEntry'] as num?)?.toInt() ?? 0,
      idx: (json['Idx'] as num?)?.toInt() ?? 0,
      itemId: (json['ItemId'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
      itemName: json['itemName']?.toString() ?? '',
      itemLocaleName: json['itemLocaleName']?.toString() ?? '',
      itemQuality: (json['itemQuality'] as num?)?.toInt() ?? 0,
      itemIcon: json['itemIcon']?.toString() ?? '',
    );
  }

  CreatureQuestItemKey get key {
    return CreatureQuestItemKey(creatureEntry: creatureEntry, idx: idx);
  }
}
