import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureTemplateResistanceValidationMixin on ViewModelValidationMixin {
  void validateCreatureTemplateResistanceFields(
    CreatureTemplateResistanceEntity value,
  ) {
    requirePositive(value.creatureID, '生物 ID');
    requireIntRange(value.school, 1, 6, '抗性学校');
  }
}
