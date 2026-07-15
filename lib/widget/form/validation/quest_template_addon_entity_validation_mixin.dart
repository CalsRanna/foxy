import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin QuestTemplateAddonValidationMixin on ViewModelValidationMixin {
  void validateQuestTemplateAddonFields(QuestTemplateAddonEntity value) {
    final nextQuestId = value.nextQuestId;
    final exclusiveGroup = value.exclusiveGroup;
    final breadcrumbForQuestId = value.breadcrumbForQuestId;
    final requiredMinRepFaction = value.requiredMinRepFaction;
    final requiredMaxRepFaction = value.requiredMaxRepFaction;
    final requiredMinRepValue = value.requiredMinRepValue;
    final requiredMaxRepValue = value.requiredMaxRepValue;
    final specialFlags = value.specialFlags;

    if ((specialFlags & ~0x000001FF) != 0) {
      throw ArgumentError.value(
        specialFlags,
        'SpecialFlags',
        '包含 AzerothCore 仅供运行时计算的标志位',
      );
    }
    if (breadcrumbForQuestId != 0 && nextQuestId != 0) {
      throw ArgumentError('设置面包屑目标时不能同时设置 NextQuestID');
    }
    if (breadcrumbForQuestId != 0 && exclusiveGroup != 0) {
      throw ArgumentError('设置面包屑目标时不能同时设置 ExclusiveGroup');
    }
    if (requiredMinRepValue != 0 && requiredMinRepFaction == 0) {
      throw ArgumentError('RequiredMinRepValue 非 0 时必须设置最低声望阵营');
    }
    if (requiredMaxRepValue != 0 && requiredMaxRepFaction == 0) {
      throw ArgumentError('RequiredMaxRepValue 非 0 时必须设置最高声望阵营');
    }
    if (requiredMinRepValue != 0 &&
        requiredMaxRepValue != 0 &&
        requiredMaxRepValue <= requiredMinRepValue) {
      throw ArgumentError('最高声望值必须大于最低声望值');
    }
  }
}
