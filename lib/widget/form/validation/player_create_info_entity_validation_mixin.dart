import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_action_entity.dart';
import 'package:foxy/entity/player_create_info_cast_spell_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_item_entity.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin PlayerCreateInfoValidationMixin on ViewModelValidationMixin {
  void validatePlayerCreateInfoFields(PlayerCreateInfoEntity value) {
    final race = value.race;
    final class_ = value.class_;
    final positionX = value.positionX;
    final positionY = value.positionY;
    final positionZ = value.positionZ;
    final orientation = value.orientation;

    if (!kPlayerRaceOptions.containsKey(race)) throw StateError('种族无效: $race');
    if (!kPlayerClassOptions.containsKey(class_)) {
      throw StateError('职业无效: $class_');
    }
    const maxCoordinate = 17066.166666666668;
    if (!positionX.isFinite ||
        positionX.abs() > maxCoordinate ||
        !positionY.isFinite ||
        positionY.abs() > maxCoordinate ||
        !positionZ.isFinite ||
        positionZ.abs() > maxCoordinate ||
        !orientation.isFinite) {
      throw StateError('出生坐标或朝向无效');
    }
  }
}

mixin PlayerCreateInfoActionValidationMixin on ViewModelValidationMixin {
  void validatePlayerCreateInfoActionFields(
    PlayerCreateInfoActionEntity value,
  ) {
    final race = value.race;
    final class_ = value.class_;
    final button = value.button;
    final action = value.action;
    final type = value.type;

    if (!kPlayerRaceOptions.containsKey(race) ||
        !kPlayerClassOptions.containsKey(class_)) {
      throw StateError('动作按钮必须属于有效的种族/职业组合');
    }
    if (button < 0 || button >= 144) throw StateError('按钮必须在 0..143 之间');
    if (action < 0 || action >= 0x1000000) {
      throw StateError('动作必须在 0..16777215 之间');
    }
    if (!kPlayerActionButtonTypeOptions.containsKey(type)) {
      throw StateError('动作类型无效: $type');
    }
  }
}

mixin PlayerCreateInfoItemValidationMixin on ViewModelValidationMixin {
  void validatePlayerCreateInfoItemFields(PlayerCreateInfoItemEntity value) {
    final race = value.race;
    final class_ = value.class_;
    final itemid = value.itemId;
    final amount = value.amount;

    if (race != 0 && !kPlayerRaceOptions.containsKey(race)) {
      throw StateError('种族无效: $race');
    }
    if (class_ != 0 && !kPlayerClassOptions.containsKey(class_)) {
      throw StateError('职业无效: $class_');
    }
    if (itemid <= 0) throw StateError('物品 ID 必须大于 0');
    if (amount == 0) throw StateError('物品数量不能为 0');
  }
}

mixin PlayerCreateInfoSpellCustomValidationMixin on ViewModelValidationMixin {
  void validatePlayerCreateInfoSpellCustomFields(
    PlayerCreateInfoSpellCustomEntity value,
  ) {
    final racemask = value.raceMask;
    final classmask = value.classMask;
    final spell = value.spell;

    _validatePlayerCreateMasks(racemask, classmask);
    if (spell <= 0) throw StateError('法术 ID 必须大于 0');
  }
}

mixin PlayerCreateInfoSkillValidationMixin on ViewModelValidationMixin {
  void validatePlayerCreateInfoSkillFields(PlayerCreateInfoSkillEntity value) {
    final raceMask = value.raceMask;
    final classMask = value.classMask;
    final skill = value.skill;
    final rank = value.rank;

    _validatePlayerCreateMasks(raceMask, classMask);
    if (skill <= 0) throw StateError('技能 ID 必须大于 0');
    if (rank < 0 || rank >= 16) throw StateError('技能阶数必须在 0..15 之间');
  }
}

mixin PlayerCreateInfoCastSpellValidationMixin on ViewModelValidationMixin {
  void validatePlayerCreateInfoCastSpellFields(
    PlayerCreateInfoCastSpellEntity value,
  ) {
    final raceMask = value.raceMask;
    final classMask = value.classMask;
    final spell = value.spell;

    _validatePlayerCreateMasks(raceMask, classMask);
    if (spell <= 0) throw StateError('法术 ID 必须大于 0');
  }
}

void _validatePlayerCreateMasks(int raceMask, int classMask) {
  if (raceMask != 0 && (raceMask & kPlayerCreatePlayableRaceMask) == 0) {
    throw StateError('种族掩码未包含可玩种族');
  }
  if (classMask != 0 && (classMask & kPlayerCreatePlayableClassMask) == 0) {
    throw StateError('职业掩码未包含可玩职业');
  }
}
