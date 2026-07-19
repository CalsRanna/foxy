import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GossipMenuOptionValidationMixin on ViewModelValidationMixin {
  void validateGossipMenuOptionFields(GossipMenuOptionEntity value) {
    requirePositive(value.menuId, 'MenuID');
    requireIntRange(value.optionId, 0, 31, 'OptionID');
    requireAllowedValue(
      value.optionIcon,
      kGossipOptionIcons.keys,
      'OptionIcon 不是 AzerothCore 支持的值',
    );
    requireAllowedValue(
      value.optionType,
      kGossipOptionTypes.keys,
      'OptionType 不是 AzerothCore 支持的值',
    );
    requireAllowedValue(
      value.boxCoded,
      kGossipBooleanOptions.keys,
      'BoxCoded 只能为 0 或 1',
    );
    requireNonNegative(value.optionNpcFlag, 'OptionNpcFlag');
    requireNonNegative(value.actionMenuId, 'ActionMenuID');
    requireNonNegative(value.actionPoiId, 'ActionPoiID');
    requireNonNegative(value.boxMoney, 'BoxMoney');
  }
}
