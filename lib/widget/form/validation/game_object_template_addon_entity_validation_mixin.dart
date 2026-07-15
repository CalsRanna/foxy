import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GameObjectTemplateAddonValidationMixin on ViewModelValidationMixin {
  void validateGameObjectTemplateAddonFields(
    GameObjectTemplateAddonEntity value,
  ) {
    final entry = value.entry;
    final minGold = value.minGold;
    final maxGold = value.maxGold;

    if (entry <= 0) throw ArgumentError('游戏对象编号必须大于 0');
    if (minGold < 0 || maxGold < 0) throw ArgumentError('金币数量不能小于 0');
    if (minGold > maxGold) throw ArgumentError('最小金币不能大于最大金币');
  }
}
