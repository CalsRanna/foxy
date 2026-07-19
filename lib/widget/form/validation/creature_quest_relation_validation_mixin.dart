import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureQuestRelationValidationMixin on ViewModelValidationMixin {
  void validateCreatureQuestEnderFields(CreatureQuestEnderEntity value) {
    requirePositive(value.id, '生物编号');
    requirePositive(value.quest, '任务编号');
  }

  void validateCreatureQuestStarterFields(CreatureQuestStarterEntity value) {
    requirePositive(value.id, '生物编号');
    requirePositive(value.quest, '任务编号');
  }
}
