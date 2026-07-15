import 'package:foxy/constant/loot_template_constants.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin LootTemplateValidationMixin on ViewModelValidationMixin {
  void validateLootTemplateFields(LootTemplateEntity value) {
    final entry = value.entry;
    final item = value.item;
    final reference = value.reference;
    final chance = value.chance;
    final questRequired = value.questRequired;
    final lootMode = value.lootMode;
    final groupId = value.groupId;
    final minCount = value.minCount;
    final maxCount = value.maxCount;

    if (entry < 0 || entry > 0xffffffff) {
      throw RangeError.range(entry, 0, 0xffffffff, 'Entry');
    }
    if (item < 0 || item > 0xffffffff) {
      throw RangeError.range(item, 0, 0xffffffff, 'Item');
    }
    if (reference < -0x7fffffff || reference > 0x7fffffff) {
      throw RangeError.range(reference, -0x7fffffff, 0x7fffffff, 'Reference');
    }
    if (!chance.isFinite || chance < 0 || chance > 100) {
      throw RangeError.range(chance, 0, 100, 'Chance');
    }
    if (lootMode == 0) throw StateError('掉落模式不能为 0');
    if (lootMode < 0 || lootMode > 0xffff) {
      throw RangeError.range(lootMode, 1, 0xffff, 'LootMode');
    }
    if ((lootMode & ~kLootTemplateValidLootModeMask) != 0) {
      throw StateError('掉落模式包含 AzerothCore 未定义的标志位');
    }
    if (groupId < 0 || groupId >= 128) {
      throw RangeError.range(groupId, 0, 127, 'GroupId');
    }
    if (minCount < 1 || minCount > 255) {
      throw RangeError.range(minCount, 1, 255, 'MinCount');
    }
    if (maxCount < 1 || maxCount > 255) {
      throw RangeError.range(maxCount, 1, 255, 'MaxCount');
    }
    if (reference == 0) {
      if (item == 0) throw StateError('物品掉落行必须指定物品 ID');
      if (maxCount < minCount) {
        throw StateError('最大数量不能小于最小数量');
      }
    } else {
      if (questRequired) throw StateError('引用掉落行不能设置任务需求');
      if (minCount != maxCount) {
        throw StateError('引用掉落行的最小数量和最大数量必须相等');
      }
    }
    if (chance == 0 && groupId == 0) {
      throw StateError('掉落几率为 0 时必须指定掉落组');
    }
    if (chance != 0 && chance < 0.000001) {
      throw StateError('非零掉落几率不能小于 0.000001');
    }
  }
}
