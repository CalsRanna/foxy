// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disenchant_loot_template_entity.dart';

mixin _DisenchantLootTemplateEntityMixin {
  int get entry;
  int get item;
  int get reference;
  double get chance;
  bool get questRequired;
  int get lootMode;
  int get groupId;
  int get minCount;
  int get maxCount;
  String get comment;

  static DisenchantLootTemplateEntity fromJson(Map<String, dynamic> json) {
    return DisenchantLootTemplateEntity(
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

  DisenchantLootTemplateEntity copyWith({
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
    return DisenchantLootTemplateEntity(
      entry: entry ?? this.entry,
      item: item ?? this.item,
      reference: reference ?? this.reference,
      chance: chance ?? this.chance,
      questRequired: questRequired ?? this.questRequired,
      lootMode: lootMode ?? this.lootMode,
      groupId: groupId ?? this.groupId,
      minCount: minCount ?? this.minCount,
      maxCount: maxCount ?? this.maxCount,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Entry': entry,
      'Item': item,
      'Reference': reference,
      'Chance': chance,
      'QuestRequired': questRequired ? 1 : 0,
      'LootMode': lootMode,
      'GroupId': groupId,
      'MinCount': minCount,
      'MaxCount': maxCount,
      'Comment': comment,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DisenchantLootTemplateEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            item == other.item &&
            reference == other.reference &&
            chance == other.chance &&
            questRequired == other.questRequired &&
            lootMode == other.lootMode &&
            groupId == other.groupId &&
            minCount == other.minCount &&
            maxCount == other.maxCount &&
            comment == other.comment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      item,
      reference,
      chance,
      questRequired,
      lootMode,
      groupId,
      minCount,
      maxCount,
      comment,
    ]);
  }

  @override
  String toString() {
    return 'DisenchantLootTemplateEntity('
        'entry: $entry, '
        'item: $item, '
        'reference: $reference, '
        'chance: $chance, '
        'questRequired: $questRequired, '
        'lootMode: $lootMode, '
        'groupId: $groupId, '
        'minCount: $minCount, '
        'maxCount: $maxCount, '
        'comment: $comment'
        ')';
  }
}
