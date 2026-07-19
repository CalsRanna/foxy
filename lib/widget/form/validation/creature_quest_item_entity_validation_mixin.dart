import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureQuestItemValidationMixin on ViewModelValidationMixin {
  void validateCreatureQuestItemFields(CreatureQuestItemEntity value) {
    requirePositive(value.creatureEntry, '生物 ID');
    requireNonNegative(value.idx, '任务物品索引');
    requirePositive(value.itemId, '物品 ID');
  }
}
