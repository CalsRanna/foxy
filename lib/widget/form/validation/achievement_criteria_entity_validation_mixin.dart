import 'package:foxy/constant/achievement_constants.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin AchievementCriteriaValidationMixin on ViewModelValidationMixin {
  void validateAchievementCriteriaFields(AchievementCriteriaEntity value) {
    final id = value.id;
    final achievementId = value.achievementId;
    final type = value.type;
    final assetId = value.assetId;
    final quantity = value.quantity;
    final startEvent = value.startEvent;
    final startAsset = value.startAsset;
    final failEvent = value.failEvent;
    final failAsset = value.failAsset;
    final descriptionLangFlags = value.descriptionLangFlags;
    final flags = value.flags;
    final timerStartEvent = value.timerStartEvent;
    final timerAssetId = value.timerAssetId;
    final timerTime = value.timerTime;
    final uiOrder = value.uiOrder;

    void requireSmallintId(int value, String field) {
      if (value <= 0 || value > 0xffff) {
        throw ArgumentError.value(value, field, '必须在 1..65535 范围内');
      }
    }

    void requireNonNegativeInt32(int value, String field) {
      if (value < 0 || value > 0x7fffffff) {
        throw ArgumentError.value(value, field, '必须为非负 int32');
      }
    }

    void requireInt32(int value, String field) {
      if (value < -0x80000000 || value > 0x7fffffff) {
        throw ArgumentError.value(value, field, '必须在 signed int32 范围内');
      }
    }

    requireSmallintId(id, 'ID');
    requireSmallintId(achievementId, 'Achievement_ID');
    if (!kAchievementCriteriaStoredTypes.contains(type)) {
      throw ArgumentError.value(type, 'Type', '不是 core 或 3.3.5a 客户端使用的条件类型');
    }
    requireNonNegativeInt32(assetId, 'Asset_ID');
    requireNonNegativeInt32(quantity, 'Quantity');
    if (!kAchievementCriteriaConditions.contains(startEvent)) {
      throw ArgumentError.value(startEvent, 'Start_event', '不是 core 支持的条件类型');
    }
    requireNonNegativeInt32(startAsset, 'Start_asset');
    if (!kAchievementCriteriaConditions.contains(failEvent)) {
      throw ArgumentError.value(failEvent, 'Fail_event', '不是 core 支持的条件类型');
    }
    requireNonNegativeInt32(failAsset, 'Fail_asset');
    requireInt32(descriptionLangFlags, 'Description_lang_Flags');
    if (flags < 0 || (flags & ~kAchievementCriteriaKnownFlagMask) != 0) {
      throw ArgumentError.value(flags, 'Flags', '包含 3.3.5a 未定义位');
    }
    if (!kAchievementCriteriaTimedTypes.contains(timerStartEvent)) {
      throw ArgumentError.value(
        timerStartEvent,
        'Timer_start_event',
        '不是 core 支持的计时类型',
      );
    }
    requireNonNegativeInt32(timerAssetId, 'Timer_asset_ID');
    requireNonNegativeInt32(timerTime, 'Timer_time');
    requireNonNegativeInt32(uiOrder, 'Ui_order');
    if (timerStartEvent == 0 && (timerAssetId != 0 || timerTime != 0)) {
      throw ArgumentError('无计时类型时 Timer_asset_ID 和 Timer_time 必须为 0');
    }
    if (timerStartEvent != 0 && timerTime == 0) {
      throw ArgumentError('计时条件的 Timer_time 必须大于 0');
    }
  }
}
