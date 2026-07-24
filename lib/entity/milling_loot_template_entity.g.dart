// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milling_loot_template_entity.dart';

mixin _MillingLootTemplateEntityMixin {
  static MillingLootTemplateEntity fromJson(Map<String, dynamic> json) {
    return MillingLootTemplateEntity(
      entry: (json['Entry'] as num?)?.toInt() ?? 0,
      item: (json['Item'] as num?)?.toInt() ?? 0,
      reference: (json['Reference'] as num?)?.toInt() ?? 0,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100.0,
      questRequired: json['QuestRequired'] == null
          ? false
          : (json['QuestRequired'] as num).toInt() == 1,
      lootMode: (json['LootMode'] as num?)?.toInt() ?? 1,
      groupId: (json['GroupId'] as num?)?.toInt() ?? 0,
      minCount: (json['MinCount'] as num?)?.toInt() ?? 1,
      maxCount: (json['MaxCount'] as num?)?.toInt() ?? 1,
      comment: json['Comment']?.toString() ?? '',
    );
  }

  MillingLootTemplateEntity copyWith({
    int? entry,
    int? item,
    int? reference,
    double? chance,
    bool? questRequired,
    int? lootMode,
    int? groupId,
    int? minCount,
    int? maxCount,
    String? comment,
  }) {
    final self = this as MillingLootTemplateEntity;
    return MillingLootTemplateEntity(
      entry: entry ?? self.entry,
      item: item ?? self.item,
      reference: reference ?? self.reference,
      chance: chance ?? self.chance,
      questRequired: questRequired ?? self.questRequired,
      lootMode: lootMode ?? self.lootMode,
      groupId: groupId ?? self.groupId,
      minCount: minCount ?? self.minCount,
      maxCount: maxCount ?? self.maxCount,
      comment: comment ?? self.comment,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as MillingLootTemplateEntity;
    return {
      'Entry': self.entry,
      'Item': self.item,
      'Reference': self.reference,
      'Chance': self.chance,
      'QuestRequired': self.questRequired ? 1 : 0,
      'LootMode': self.lootMode,
      'GroupId': self.groupId,
      'MinCount': self.minCount,
      'MaxCount': self.maxCount,
      'Comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as MillingLootTemplateEntity;
    return identical(self, other) ||
        other is MillingLootTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.item == other.item &&
            self.reference == other.reference &&
            self.chance == other.chance &&
            self.questRequired == other.questRequired &&
            self.lootMode == other.lootMode &&
            self.groupId == other.groupId &&
            self.minCount == other.minCount &&
            self.maxCount == other.maxCount &&
            self.comment == other.comment;
  }

  @override
  int get hashCode {
    final self = this as MillingLootTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.item,
      self.reference,
      self.chance,
      self.questRequired,
      self.lootMode,
      self.groupId,
      self.minCount,
      self.maxCount,
      self.comment,
    ]);
  }

  @override
  String toString() {
    final self = this as MillingLootTemplateEntity;
    return 'MillingLootTemplateEntity('
        'entry: ${self.entry}, '
        'item: ${self.item}, '
        'reference: ${self.reference}, '
        'chance: ${self.chance}, '
        'questRequired: ${self.questRequired}, '
        'lootMode: ${self.lootMode}, '
        'groupId: ${self.groupId}, '
        'minCount: ${self.minCount}, '
        'maxCount: ${self.maxCount}, '
        'comment: ${self.comment}'
        ')';
  }
}

final class MillingLootTemplateKey {
  final int entry;
  final int item;

  const MillingLootTemplateKey({required this.entry, required this.item});

  factory MillingLootTemplateKey.fromEntity(MillingLootTemplateEntity entity) {
    return MillingLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MillingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'MillingLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}

final class BriefMillingLootTemplateEntity {
  final int entry;
  final int item;
  final int reference;
  final double chance;
  final bool questRequired;
  final int groupId;
  final int minCount;
  final int maxCount;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  const BriefMillingLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100.0,
    this.questRequired = false,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory BriefMillingLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefMillingLootTemplateEntity(
      entry: (json['Entry'] as num?)?.toInt() ?? 0,
      item: (json['Item'] as num?)?.toInt() ?? 0,
      reference: (json['Reference'] as num?)?.toInt() ?? 0,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100.0,
      questRequired: json['QuestRequired'] == null
          ? false
          : (json['QuestRequired'] as num).toInt() == 1,
      groupId: (json['GroupId'] as num?)?.toInt() ?? 0,
      minCount: (json['MinCount'] as num?)?.toInt() ?? 1,
      maxCount: (json['MaxCount'] as num?)?.toInt() ?? 1,
      itemName: json['itemName']?.toString() ?? '',
      itemLocaleName: json['itemLocaleName']?.toString() ?? '',
      itemQuality: (json['itemQuality'] as num?)?.toInt() ?? 0,
      itemIcon: json['itemIcon']?.toString() ?? '',
    );
  }

  MillingLootTemplateKey get key {
    return MillingLootTemplateKey(entry: entry, item: item);
  }
}
