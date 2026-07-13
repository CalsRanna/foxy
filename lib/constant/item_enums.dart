// Item Template 枚举常量定义
// 数据来源：AzerothCore SharedDefines.h, ItemDefines.h

/// Material 材质类型选项
const kItemMaterialOptions = {
  -1: '消耗品', // Consumable
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
  0: '法力值', // Mana
  1: '生命值', // Health
  2: '保留（未定义）',
  3: '敏捷', // Agility
  4: '力量', // Strength
  5: '智力', // Intellect
  6: '精神', // Spirit
  7: '耐力', // Stamina
  8: '保留（未定义）',
  9: '保留（未定义）',
  10: '保留（未定义）',
  11: '保留（未定义）',
  12: '防御技能等级', // Defense Skill Rating
  13: '躲闪等级', // Dodge Rating
  14: '招架等级', // Parry Rating
  15: '格挡等级', // Block Rating
  16: '近战命中等级', // Melee Hit Rating
  17: '远程命中等级', // Ranged Hit Rating
  18: '法术命中等级', // Spell Hit Rating
  19: '近战暴击等级', // Melee Crit Rating
  20: '远程暴击等级', // Ranged Crit Rating
  21: '法术暴击等级', // Spell Crit Rating
  22: '近战被命中等级', // Melee Hit Taken Rating
  23: '远程被命中等级', // Ranged Hit Taken Rating
  24: '法术被命中等级', // Spell Hit Taken Rating
  25: '近战被暴击等级', // Melee Crit Taken Rating
  26: '远程被暴击等级', // Ranged Crit Taken Rating
  27: '法术被暴击等级', // Spell Crit Taken Rating
  28: '近战急速等级', // Melee Haste Rating
  29: '远程急速等级', // Ranged Haste Rating
  30: '法术急速等级', // Spell Haste Rating
  31: '命中等级', // Hit Rating
  32: '暴击等级', // Crit Rating
  33: '被命中等级', // Hit Taken Rating
  34: '被暴击等级', // Crit Taken Rating
  35: '韧性等级', // Resilience Rating
  36: '急速等级', // Haste Rating
  37: '精准等级', // Expertise
  38: '攻击强度', // Attack Power
  39: '远程攻击强度', // Ranged Attack Power
  40: '野性攻击强度（3.3.5a 未使用）', // Feral Attack Power, not in 3.3.5a
  41: '法术治疗加成（已弃用）', // Spell Healing Done, deprecated
  42: '法术伤害加成（已弃用）', // Spell Damage Done, deprecated
  43: '法力回复', // Mana Regeneration
  44: '护甲穿透等级', // Armor Penetration
  45: '法术强度', // Spell Power
  46: '生命回复', // Health Regeneration
  47: '法术穿透', // Spell Penetration
  48: '格挡值', // Block Value
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

/// ReputationRank，AzerothCore MAX_REPUTATION_RANK = 8。
const kItemReputationRankOptions = {
  0: '仇恨',
  1: '敌对',
  2: '冷淡',
  3: '中立',
  4: '友善',
  5: '尊敬',
  6: '崇敬',
  7: '崇拜',
};
