import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellAreaValidationMixin on ViewModelValidationMixin {
  void validateSpellAreaFields(SpellAreaEntity value) {
    final spell = value.spell;
    final auraSpell = value.auraSpell;
    final gender = value.gender;
    final autocast = value.autocast;
    final questStartStatus = value.questStartStatus;
    final questEndStatus = value.questEndStatus;

    if (gender < 0 || gender > 2) {
      throw RangeError.range(gender, 0, 2, 'gender');
    }
    if (autocast != 0 && autocast != 1) {
      throw ArgumentError.value(autocast, 'autocast', '只能为 0 或 1');
    }
    const allowedQuestStatusMask = 0x6B;
    if (questStartStatus & ~allowedQuestStatusMask != 0) {
      throw ArgumentError.value(
        questStartStatus,
        'questStartStatus',
        '包含无效任务状态位',
      );
    }
    if (questEndStatus & ~allowedQuestStatusMask != 0) {
      throw ArgumentError.value(questEndStatus, 'questEndStatus', '包含无效任务状态位');
    }
    if (auraSpell.abs() == spell && spell != 0) {
      throw ArgumentError('aura_spell 不能引用当前 spell');
    }
  }
}
