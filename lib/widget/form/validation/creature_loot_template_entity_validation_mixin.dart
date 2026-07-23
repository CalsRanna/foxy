import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/loot_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureLootTemplateValidationMixin on ViewModelValidationMixin {
  void validateCreatureLootTemplateFields(CreatureLootTemplateEntity value) {
    validateLootTemplateValues(
      entry: value.entry,
      item: value.item,
      reference: value.reference,
      chance: value.chance,
      questRequired: value.questRequired,
      lootMode: value.lootMode,
      groupId: value.groupId,
      minCount: value.minCount,
      maxCount: value.maxCount,
    );
  }
}
