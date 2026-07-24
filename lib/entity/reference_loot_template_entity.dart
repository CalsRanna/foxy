// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'reference_loot_template_entity.g.dart';

/// 掉落模板 — 对应 *_loot_template 表

@FoxyFullEntity(table: 'reference_loot_template')
class ReferenceLootTemplateEntity with _ReferenceLootTemplateEntityMixin {
  @FoxyFullField('Entry', key: true)
  final int entry;

  @FoxyFullField('Item', key: true)
  final int item;

  @FoxyFullField('Reference')
  final int reference;

  @FoxyFullField('Chance')
  final double chance;

  @FoxyFullField('QuestRequired')
  final bool questRequired;

  @FoxyFullField('LootMode')
  final int lootMode;

  @FoxyFullField('GroupId')
  final int groupId;

  @FoxyFullField('MinCount')
  final int minCount;

  @FoxyFullField('MaxCount')
  final int maxCount;

  @FoxyFullField('Comment')
  final String comment;

  const ReferenceLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100,
    this.questRequired = false,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
  });

  factory ReferenceLootTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _ReferenceLootTemplateEntityMixin.fromJson(json);
}
