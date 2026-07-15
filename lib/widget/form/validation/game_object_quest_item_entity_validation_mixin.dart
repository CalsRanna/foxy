import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GameObjectQuestItemValidationMixin on ViewModelValidationMixin {
  void validateGameObjectQuestItemFields(GameObjectQuestItemEntity value) {
    final gameObjectEntry = value.gameObjectEntry;
    final idx = value.idx;
    final itemId = value.itemId;

    if (gameObjectEntry <= 0) throw ArgumentError('游戏对象编号必须大于 0');
    if (idx < 0 || idx >= 6) throw ArgumentError('任务物品索引必须在 0..5');
    if (itemId <= 0) throw ArgumentError('物品 ID 必须大于 0');
  }
}
