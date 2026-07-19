import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GameObjectQuestRelationValidationMixin on ViewModelValidationMixin {
  void validateGameObjectQuestEnderFields(GameObjectQuestEnderEntity value) {
    requirePositive(value.id, '游戏对象编号');
    requirePositive(value.quest, '任务编号');
  }

  void validateGameObjectQuestStarterFields(
    GameObjectQuestStarterEntity value,
  ) {
    requirePositive(value.id, '游戏对象编号');
    requirePositive(value.quest, '任务编号');
  }
}
