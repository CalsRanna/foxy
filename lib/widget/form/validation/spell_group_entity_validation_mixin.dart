import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellGroupValidationMixin on ViewModelValidationMixin {
  void validateSpellGroupFields(SpellGroupEntity value) {
    final id = value.id;
    final spellId = value.spellId;

    if (id <= 0 || (id >= 3 && id <= 1000)) {
      throw ArgumentError.value(id, 'id', '只能使用核心组 1/2 或数据库组 > 1000');
    }
    if (spellId == 0) {
      throw ArgumentError.value(spellId, 'spellId', '不能为 0');
    }
  }
}
