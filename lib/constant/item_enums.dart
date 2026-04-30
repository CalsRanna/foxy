// Item Template 枚举常量定义
// 数据来源：AzerothCore SharedDefines.h, ItemDefines.h

/// Material 材质类型选项
const kItemMaterialOptions = {
  0: '未定义', // None
  1: '金属', // Metal
  2: '木制品', // Wood
  3: '液体', // Liquid
  4: '珠宝', // Jewelry
  5: '锁甲', // Mail
  6: '板甲', // Plate
  7: '布甲', // Cloth
  8: '皮甲', // Leather
};

/// Bonding 绑定类型选项
const kItemBondingOptions = {
  0: '不绑定', // No Bind
  1: '拾取时绑定', // Bind on Pickup
  2: '装备后绑定', // Bind on Equip
  3: '使用后绑定', // Bind on Use
  4: '任务物品', // Quest Item
  5: '任务物品1', // Quest Item 1
};

/// Sheath 武器挂载类型选项
const kItemSheathOptions = {
  0: '无', // None
  1: '双手武器，背在后面尖向下', // Two-Hand
  2: '法杖，背在后面尖向上', // Staff
  3: '单手武器', // One-Hand
  4: '盾牌', // Shield
  5: '附魔棒', // Enchanting Rod
  6: '拳套/火把/锄头等', // Fist Weapon
};

/// FoodType 食物类型选项
const kItemFoodTypeOptions = {
  0: '无', // None
  1: '肉', // Meat
  2: '鱼', // Fish
  3: '芝士', // Cheese
  4: '面包', // Bread
  5: '菌类', // Fungus
  6: '水果', // Fruit
  7: '生肉', // Raw Meat
  8: '生鱼', // Raw Fish
};

/// StatType 属性类型选项
const kItemStatTypeOptions = {
  0: '无', // None
  1: '生命值', // Health
  2: '法力值', // Mana
  3: '敏捷', // Agility
  4: '力量', // Strength
  5: '智力', // Intellect
  6: '精神', // Spirit
  7: '耐力', // Stamina
  8: '未知', // Unknown
  9: '未知', // Unknown
  10: '未知', // Unknown
  11: '未知', // Unknown
  12: '防御等级', // Defense Rating
  13: '躲闪等级', // Dodge Rating
  14: '招架等级', // Parry Rating
  15: '盾牌格挡', // Shield Block
  16: '近战命中', // Melee Hit
  17: '远程命中', // Ranged Hit
  18: '法术命中', // Spell Hit
  19: '近战暴击', // Melee Crit
  20: '远程暴击', // Ranged Crit
  21: '法术暴击', // Spell Crit
  22: '近战躲闪', // Melee Dodge
  23: '远程躲闪', // Ranged Dodge
  24: '法术躲闪', // Spell Dodge
  25: '近战暴击躲闪', // Melee Crit Dodge
  26: '远程暴击躲闪', // Ranged Crit Dodge
  27: '法术暴击躲闪', // Spell Crit Dodge
  28: '近战攻击速度', // Melee Haste
  29: '远程攻击速度', // Ranged Haste
  30: '法术攻击速度', // Spell Haste
  31: '命中等级', // Hit Rating
  32: '暴击等级', // Crit Rating
  33: '命中躲闪', // Hit Dodge
  34: '暴击躲闪', // Crit Dodge
  35: '韧性', // Resilience
  36: '急速攻击速度', // Haste Rating
  37: '精准等级', // Expertise
  38: '攻击强度', // Attack Power
  39: '远程攻击强度', // Ranged Attack Power
  40: '猎豹/熊/巨熊形态攻击强度', // Feral Attack Power
  41: '法术治疗效果', // Spell Healing
  42: '法术伤害效果', // Spell Damage
  43: '5秒回蓝', // MP5
  44: '护甲穿透等级', // Armor Penetration
  45: '法术强度', // Spell Power
  46: '5秒回血', // HP5
  47: '法术穿透', // Spell Penetration
  48: '格挡值', // Block Value
};

/// SocketColor 插槽颜色选项
const kItemSocketColorOptions = {
  1: '原石', // Meta
  2: '红色', // Red
  4: '黄色', // Yellow
  8: '蓝色', // Blue
};

/// SpellTrigger 法术触发类型选项
const kItemSpellTriggerOptions = {
  0: '使用', // Use
  1: '装备', // Equip
  2: '击中时可能', // Chance on Hit
  4: '灵魂石', // Soul Stone
  5: '使用无延迟', // Use No Delay
  6: '学习法术', // Learn Spell
};

/// Quality 物品品质选项
const kItemQualityOptions = {
  0: '粗糙', // Poor
  1: '普通', // Common
  2: '优秀', // Uncommon
  3: '精良', // Rare
  4: '史诗', // Epic
  5: '传说', // Legendary
  6: '神器', // Artifact
  7: '传家宝', // Heirloom
};
