import 'package:foxy/constant/creature_flags.dart';

/// AzerothCore `ItemEnchantmentType` used by SpellItemEnchantment.dbc.
const kSpellItemEnchantmentEffectTypeOptions = <int, String>{
  0: '无效果',
  1: '战斗触发法术',
  2: '武器伤害',
  3: '装备法术',
  4: '抗性',
  5: '属性',
  6: '图腾武器伤害',
  7: '使用法术',
  8: '棱彩插槽',
};

/// `SpellSchools` values consumed by the enchantment resistance branch.
const kSpellItemEnchantmentSchoolOptions = <int, String>{
  0: '物理',
  1: '神圣',
  2: '火焰',
  3: '自然',
  4: '冰霜',
  5: '暗影',
  6: '奥术',
};

/// `ItemModType` values handled by Player::ApplyEnchantment for type 5.
const kSpellItemEnchantmentStatOptions = <int, String>{
  0: '法力值',
  1: '生命值',
  3: '敏捷',
  4: '力量',
  5: '智力',
  6: '精神',
  7: '耐力',
  12: '防御等级',
  13: '躲闪等级',
  14: '招架等级',
  15: '格挡等级',
  16: '近战命中等级',
  17: '远程命中等级',
  18: '法术命中等级',
  19: '近战暴击等级',
  20: '远程暴击等级',
  21: '法术暴击等级',
  29: '近战急速等级',
  30: '远程急速等级',
  31: '法术急速等级',
  32: '命中等级',
  35: '韧性等级',
  36: '急速等级',
  37: '精准等级',
  38: '攻击强度',
  39: '远程攻击强度',
  41: '法术强度',
  42: '法术强度',
  43: '每 5 秒恢复法力',
  44: '护甲穿透等级',
  45: '法术强度',
  46: '每 5 秒恢复生命',
  47: '法术穿透',
  48: '格挡值',
};

const kSpellItemEnchantmentFlagOptions = <FlagItem>[
  FlagItem(0x01, '可使物品灵魂绑定'),
  FlagItem(0x02, '客户端标志 0x02'),
  FlagItem(0x04, '客户端标志 0x04'),
  FlagItem(0x08, '客户端标志 0x08'),
];
