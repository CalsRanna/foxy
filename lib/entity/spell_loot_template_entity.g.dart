// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_loot_template_entity.dart';

mixin _SpellLootTemplateEntityMixin {
  static SpellLootTemplateEntity fromJson(Map<String, dynamic> json) {
    return SpellLootTemplateEntity(
      entry: (json['Entry'] as num?)?.toInt() ?? 0,
      item: (json['Item'] as num?)?.toInt() ?? 0,
      reference: (json['Reference'] as num?)?.toInt() ?? 0,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100.0,
      questRequired: (json['QuestRequired'] as num?)?.toInt() ?? 0,
      lootMode: (json['LootMode'] as num?)?.toInt() ?? 1,
      groupId: (json['GroupId'] as num?)?.toInt() ?? 0,
      minCount: (json['MinCount'] as num?)?.toInt() ?? 1,
      maxCount: (json['MaxCount'] as num?)?.toInt() ?? 1,
      comment: json['Comment']?.toString() ?? '',
    );
  }

  SpellLootTemplateEntity copyWith({
    int? entry,
    int? item,
    int? reference,
    double? chance,
    int? questRequired,
    int? lootMode,
    int? groupId,
    int? minCount,
    int? maxCount,
    String? comment,
  }) {
    final self = this as SpellLootTemplateEntity;
    return SpellLootTemplateEntity(
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
    final self = this as SpellLootTemplateEntity;
    return {
      'Entry': self.entry,
      'Item': self.item,
      'Reference': self.reference,
      'Chance': self.chance,
      'QuestRequired': self.questRequired,
      'LootMode': self.lootMode,
      'GroupId': self.groupId,
      'MinCount': self.minCount,
      'MaxCount': self.maxCount,
      'Comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellLootTemplateEntity;
    return identical(self, other) ||
        other is SpellLootTemplateEntity &&
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
    final self = this as SpellLootTemplateEntity;
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
    final self = this as SpellLootTemplateEntity;
    return 'SpellLootTemplateEntity('
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

final class SpellLootTemplateKey {
  final int entry;
  final int item;

  const SpellLootTemplateKey({required this.entry, required this.item});

  factory SpellLootTemplateKey.fromEntity(SpellLootTemplateEntity entity) {
    return SpellLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'SpellLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}

final class BriefSpellLootTemplateEntity {
  final int entry;
  final int item;
  final int reference;
  final double chance;
  final int questRequired;
  final int lootMode;
  final int groupId;
  final int minCount;
  final int maxCount;
  final String comment;
  final String itemName;
  final String localeName;
  final int quality;
  final String icon;

  const BriefSpellLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100.0,
    this.questRequired = 0,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
    this.itemName = '',
    this.localeName = '',
    this.quality = 0,
    this.icon = '',
  });

  factory BriefSpellLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellLootTemplateEntity(
      entry: (json['Entry'] as num?)?.toInt() ?? 0,
      item: (json['Item'] as num?)?.toInt() ?? 0,
      reference: (json['Reference'] as num?)?.toInt() ?? 0,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100.0,
      questRequired: (json['QuestRequired'] as num?)?.toInt() ?? 0,
      lootMode: (json['LootMode'] as num?)?.toInt() ?? 1,
      groupId: (json['GroupId'] as num?)?.toInt() ?? 0,
      minCount: (json['MinCount'] as num?)?.toInt() ?? 1,
      maxCount: (json['MaxCount'] as num?)?.toInt() ?? 1,
      comment: json['Comment']?.toString() ?? '',
      itemName: json['itemName']?.toString() ?? '',
      localeName: json['localeName']?.toString() ?? '',
      quality: (json['quality'] as num?)?.toInt() ?? 0,
      icon: json['icon']?.toString() ?? '',
    );
  }

  SpellLootTemplateKey get key {
    return SpellLootTemplateKey(entry: entry, item: item);
  }
}
