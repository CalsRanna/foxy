import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_loot_template_entity.g.dart';

/// 法术掉落模板

@FoxyBriefEntity()
@FoxyBriefField.text('itemName')
@FoxyBriefField.text('localeName')
@FoxyBriefField.integer('quality')
@FoxyBriefField.text('icon')
@FoxyFullEntity(table: 'spell_loot_template')
class SpellLootTemplateEntity with _SpellLootTemplateEntityMixin {
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
  final int questRequired;

  @FoxyBriefField()
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

  @FoxyBriefField()
  @FoxyFullField('Comment')
  final String comment;

  const SpellLootTemplateEntity({
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
  });

  factory SpellLootTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _SpellLootTemplateEntityMixin.fromJson(json);
}

extension BriefSpellLootTemplateEntityDisplay on BriefSpellLootTemplateEntity {
  String get displayName => localeName.isNotEmpty ? localeName : itemName;
}
