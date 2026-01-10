// Creature Template 枚举常量定义
// 数据来源：AzerothCore SharedDefines.h, UnitDefines.h

import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Map 扩展方法，将 `Map<T, String>` 转换为 `List<ShadOption<T>>`
extension ShadOptionsExtension<T> on Map<T, String> {
  List<ShadOption<T>> toShadOptions() {
    return entries
        .map((e) => ShadOption(value: e.key, child: Text(e.value)))
        .toList();
  }
}

/// unit_class 职业选项
const kUnitClassOptions = {
  1: '战士 (Warrior)',
  2: '圣骑士 (Paladin)',
  4: '盗贼 (Rogue)',
  8: '法师 (Mage)',
};

/// rank 稀有程度选项
const kRankOptions = {
  0: '普通 (Normal)',
  1: '精英 (Elite)',
  2: '稀有精英 (Rare Elite)',
  3: '世界BOSS (World Boss)',
  4: '稀有 (Rare)',
};

/// type 生物类型选项
const kCreatureTypeOptions = {
  0: '无 (None)',
  1: '野兽 (Beast)',
  2: '龙类 (Dragonkin)',
  3: '恶魔 (Demon)',
  4: '元素 (Elemental)',
  5: '巨人 (Giant)',
  6: '亡灵 (Undead)',
  7: '人型生物 (Humanoid)',
  8: '小动物 (Critter)',
  9: '机械 (Mechanical)',
  10: '未指定 (Not Specified)',
  11: '图腾 (Totem)',
  12: '非战斗宠物 (Non-combat Pet)',
  13: '气体云 (Gas Cloud)',
};

/// RacialLeader / RegenHealth 布尔选项
const kBooleanOptions = {0: '否 (No)', 1: '是 (Yes)'};

/// exp 属性扩展选项（资料片）
const kExpansionOptions = {
  0: '经典旧世 (Classic)',
  1: '燃烧的远征 (TBC)',
  2: '巫妖王之怒 (WotLK)',
};

/// dmgschool 伤害类型选项
const kDamageSchoolOptions = {
  0: '物理 (Physical)',
  1: '神圣 (Holy)',
  2: '火焰 (Fire)',
  3: '自然 (Nature)',
  4: '冰霜 (Frost)',
  5: '暗影 (Shadow)',
  6: '奥术 (Arcane)',
};

/// movementType 移动类型选项
const kMovementTypeOptions = {
  0: '静止 (Idle)',
  1: '随机 (Random)',
  2: '路径点 (Waypoint)',
};
