import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellLinkedSpellValidationMixin on ViewModelValidationMixin {
  void validateSpellLinkedSpellFields(SpellLinkedSpellEntity value) {
    final spellTrigger = value.spellTrigger;
    final spellEffect = value.spellEffect;
    final type = value.type;

    if (spellTrigger == 0 || spellEffect == 0) {
      throw ArgumentError('spell_trigger 和 spell_effect 均不能为 0');
    }
    if (type < 0 || type > 2) {
      throw RangeError.range(type, 0, 2, 'type');
    }
  }
}
