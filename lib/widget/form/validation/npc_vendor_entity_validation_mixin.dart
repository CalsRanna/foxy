import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin NpcVendorValidationMixin on ViewModelValidationMixin {
  void validateNpcVendorFields(NpcVendorEntity value) {
    requirePositive(value.entry, '商人 ID');
    requireNonNegative(value.slot, '插槽');
    requirePositive(value.item, '物品 ID');
    requireNonNegative(value.maxcount, '最大数量');
    requireNonNegative(value.incrtime, '补货时间');
    requireNonNegative(value.extendedCost, '扩展价格');
    if (value.maxcount > 0 && value.incrtime == 0) {
      throw StateError('最大数量大于 0 时补货时间必须大于 0');
    }
    if (value.maxcount == 0 && value.incrtime > 0) {
      throw StateError('最大数量为 0 时补货时间也必须为 0');
    }
  }
}
