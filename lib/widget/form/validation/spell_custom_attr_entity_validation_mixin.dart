import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellCustomAttrValidationMixin on ViewModelValidationMixin {
  void validateSpellCustomAttrFields(SpellCustomAttrEntity value) =>
      value._validateFields();
}

extension on SpellCustomAttrEntity {
  void _validateFields() {
    if ((attributes & 0x00001000) != 0 && (attributes & 0x02000000) != 0) {
      throw ArgumentError('效果1不能同时标记为正面和负面');
    }
    if ((attributes & 0x00002000) != 0 && (attributes & 0x04000000) != 0) {
      throw ArgumentError('效果2不能同时标记为正面和负面');
    }
    if ((attributes & 0x00004000) != 0 && (attributes & 0x08000000) != 0) {
      throw ArgumentError('效果3不能同时标记为正面和负面');
    }
  }
}
