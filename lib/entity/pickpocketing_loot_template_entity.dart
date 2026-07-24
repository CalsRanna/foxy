import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'pickpocketing_loot_template_entity.g.dart';

/// 掉落模板 — 对应 pickpocketing_loot_template 表。
@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('itemLocaleName')
@FoxyBriefField.integer('itemQuality')
@FoxyBriefField.text('itemIcon')
@FoxyFullEntity(table: 'pickpocketing_loot_template')
class PickpocketingLootTemplateEntity
    with _PickpocketingLootTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('Entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('Item', key: true)
  final int item;

  @FoxyBriefField()
  @FoxyFullField('Reference')
  final int reference;

  @FoxyBriefField()
  @FoxyFullField('Chance')
  final double chance;

  @FoxyBriefField()
  @FoxyFullField('QuestRequired')
  final bool questRequired;

  @FoxyFullField('LootMode')
  final int lootMode;

  @FoxyBriefField()
  @FoxyFullField('GroupId')
  final int groupId;

  @FoxyBriefField()
  @FoxyFullField('MinCount')
  final int minCount;

  @FoxyBriefField()
  @FoxyFullField('MaxCount')
  final int maxCount;

  @FoxyFullField('Comment')
  final String comment;

  const PickpocketingLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100.0,
    this.questRequired = false,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
  });

  factory PickpocketingLootTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _PickpocketingLootTemplateEntityMixin.fromJson(json);
}

extension BriefPickpocketingLootTemplateEntityDisplay
    on BriefPickpocketingLootTemplateEntity {
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}
