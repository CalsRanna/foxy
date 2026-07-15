import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellLootTemplateValidationMixin on ViewModelValidationMixin {
  void validateSpellLootTemplateFields(SpellLootTemplateEntity value) {
    final reference = value.reference;
    final chance = value.chance;
    final questRequired = value.questRequired;
    final lootMode = value.lootMode;
    final groupId = value.groupId;
    final minCount = value.minCount;
    final maxCount = value.maxCount;

    if (lootMode == 0) throw StateError('掉落模式不能为 0');
    if (groupId < 0 || groupId > 127) {
      throw RangeError.range(groupId, 0, 127, 'GroupId');
    }
    if (minCount < 1 || minCount > 255) {
      throw RangeError.range(minCount, 1, 255, 'MinCount');
    }
    if (maxCount < 1 || maxCount > 255) {
      throw RangeError.range(maxCount, 1, 255, 'MaxCount');
    }
    if (reference == 0 && maxCount < minCount) {
      throw StateError('最大数量不能小于最小数量');
    }
    if (chance == 0 && groupId == 0) {
      throw StateError('掉落几率为 0 时必须指定掉落组');
    }
    if (chance < 0 || chance > 100) {
      throw RangeError.range(chance, 0, 100, 'Chance');
    }
    if (questRequired != 0 && questRequired != 1) {
      throw ArgumentError.value(questRequired, 'QuestRequired', '只能为 0 或 1');
    }
  }
}
