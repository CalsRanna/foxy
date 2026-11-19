import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'creature_equip_template_entity.g.dart';

/// Creature equip template — maps to the creature_equip_template table
/// (composite key: CreatureID + ID)

@FoxyBriefEntity()
@FoxyBriefField.text('name1')
@FoxyBriefField.text('localeName1')
@FoxyBriefField.integer('quality1')
@FoxyBriefField.text('icon1')
@FoxyBriefField.text('name2')
@FoxyBriefField.text('localeName2')
@FoxyBriefField.integer('quality2')
@FoxyBriefField.text('icon2')
@FoxyBriefField.text('name3')
@FoxyBriefField.text('localeName3')
@FoxyBriefField.integer('quality3')
@FoxyBriefField.text('icon3')
@FoxyFullEntity()
class CreatureEquipTemplateEntity with _CreatureEquipTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('生物', table: 'creature_template', column: 'entry')
  @FoxyFullField('CreatureID', key: true)
  final int creatureID;

  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('物品1', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID1')
  final int itemID1;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('物品2', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID2')
  final int itemID2;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('物品3', table: 'item_template', column: 'entry')
  @FoxyFullField('ItemID3')
  final int itemID3;

  @FoxyBriefField()
  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const CreatureEquipTemplateEntity({
    this.creatureID = 0,
    this.id = 0,
    this.itemID1 = 0,
    this.itemID2 = 0,
    this.itemID3 = 0,
    this.verifiedBuild = 0,
  });

  factory CreatureEquipTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureEquipTemplateEntityMixin.fromJson(json);
}

extension BriefCreatureEquipTemplateEntityDisplay
    on BriefCreatureEquipTemplateEntity {
  String get displayName1 => localeName1.isNotEmpty ? localeName1 : name1;

  String get displayName2 => localeName2.isNotEmpty ? localeName2 : name2;

  String get displayName3 => localeName3.isNotEmpty ? localeName3 : name3;
}
