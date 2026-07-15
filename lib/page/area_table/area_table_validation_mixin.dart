import 'package:foxy/constant/area_table_constants.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin AreaTableValidationMixin on ViewModelValidationMixin {
  void validateAreaTableFields(AreaTableEntity value) {
    requirePositive(value.id, '编号');
    requireNonNegative(value.continentId, '地图 ID');
    requireNonNegative(value.parentAreaId, '父级区域 ID');
    if (value.parentAreaId == value.id) {
      throw StateError('父级区域不能指向自身');
    }
    requireIntRange(value.areaBit, 0, kAreaTableMaxAreaBit, '探索位索引');
    requireKnownFlags(
      value.flags,
      kAreaTableKnownFlagMask,
      '区域标志包含 3.3.5a AreaTable 未定义的位',
    );
    requireAllowedValue(
      value.factionGroupMask,
      kAreaTeamOptions.keys,
      '区域阵营必须为 0、2、4 或 6',
    );
    requireIntRange(value.explorationLevel, -1, 80, '探索等级');
    requireNonNegative(value.soundProviderPref, '声音提供器偏好 ID');
    requireNonNegative(value.soundProviderPrefUnderwater, '水下声音提供器偏好 ID');
    requireNonNegative(value.ambienceId, '环境声音 ID');
    requireNonNegative(value.zoneMusic, '区域音乐 ID');
    requireNonNegative(value.introSound, '进入音乐 ID');
    requireNonNegative(value.liquidTypeId0, '水覆盖 ID');
    requireNonNegative(value.liquidTypeId1, '海洋覆盖 ID');
    requireNonNegative(value.liquidTypeId2, '岩浆覆盖 ID');
    requireNonNegative(value.liquidTypeId3, '软泥覆盖 ID');
    requireNonNegative(value.lightId, '光照 ID');
    requireFinite(value.minElevation, '最低海拔');
    requireFinite(value.ambientMultiplier, '环境系数');
  }
}
