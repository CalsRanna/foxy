import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureEquipTemplateValidationMixin on ViewModelValidationMixin {
  void validateCreatureEquipTemplateFields(CreatureEquipTemplateEntity value) {
    requirePositive(value.creatureID, '生物 ID');
    requirePositive(value.id, '装备模板 ID');
    requireNonNegative(value.itemID1, '主手物品 ID');
    requireNonNegative(value.itemID2, '副手物品 ID');
    requireNonNegative(value.itemID3, '远程物品 ID');
  }
}
