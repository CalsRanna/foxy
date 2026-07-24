import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_equip_template_entity.g.dart';

/// 生物装备模板 — 对应 creature_equip_template 表（复合键: CreatureID + ID）

@FoxyFullEntity(table: 'creature_equip_template')
class CreatureEquipTemplateEntity with _CreatureEquipTemplateEntityMixin {
  @FoxyFullField('CreatureID', key: true)
  final int creatureID;

  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('ItemID1')
  final int itemID1;

  @FoxyFullField('ItemID2')
  final int itemID2;

  @FoxyFullField('ItemID3')
  final int itemID3;

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
