import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_equip_template_entity.g.dart';

/// 生物装备模板 — 对应 creature_equip_template 表（复合键: CreatureID + ID）

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
@FoxyFullEntity(table: 'creature_equip_template')
class CreatureEquipTemplateEntity with _CreatureEquipTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('CreatureID', key: true)
  final int creatureID;

  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('ItemID1')
  final int itemID1;

  @FoxyBriefField()
  @FoxyFullField('ItemID2')
  final int itemID2;

  @FoxyBriefField()
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
