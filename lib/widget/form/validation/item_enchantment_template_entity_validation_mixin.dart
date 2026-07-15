import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemEnchantmentTemplateValidationMixin on ViewModelValidationMixin {
  void validateItemEnchantmentTemplateFields(
    ItemEnchantmentTemplateEntity value,
  ) {
    final entry = value.entry;
    final ench = value.ench;
    final chance = value.chance;

    if (entry == 0) throw ArgumentError('entry 必须引用非零附魔组');
    if (ench == 0) throw ArgumentError('ench 必须引用随机属性或随机后缀 DBC');
    if (chance <= 0.000001 || chance > 100) {
      throw ArgumentError.value(chance, 'chance', '必须大于 0.000001 且不超过 100');
    }
  }
}
