import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureTemplateSpellValidationMixin on ViewModelValidationMixin {
  void validateCreatureTemplateSpellFields(CreatureTemplateSpellEntity value) {
    requirePositive(value.creatureID, '生物 ID');
    requireIntRange(value.index, 0, 7, '技能槽');
    requirePositive(value.spell, '技能 ID');
  }
}
