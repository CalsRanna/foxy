import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GameObjectTemplateValidationMixin on ViewModelValidationMixin {
  void validateGameObjectTemplateFields(GameObjectTemplateEntity value) {
    final type = value.type;
    final size = value.size;
    final data0 = value.data0;
    final data1 = value.data1;
    final data2 = value.data2;
    final data3 = value.data3;

    if (type < 0 || type > 35) throw ArgumentError('游戏对象类型必须在 0..35');
    if (size <= 0) throw ArgumentError('尺寸必须大于 0');
    if (type == 23 && data0 > data1) {
      throw ArgumentError('集合石最低等级不能大于最高等级');
    }
    if (type == 25 && data2 > data3) {
      throw ArgumentError('钓鱼水域最少开启次数不能大于最多开启次数');
    }
  }
}
