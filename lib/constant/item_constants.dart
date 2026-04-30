// 物品常量定义
// 数据来源：AzerothCore SharedDefines.h, ItemDefines.h

/// 物品类别名称
const kItemClasses = [
  '消耗品', // Consumable
  '容器', // Container
  '武器', // Weapon
  '珠宝', // Gem
  '护甲', // Armor
  '药剂', // Reagent
  '弹药', // Ammo
  '贸易品', // Trade Goods
  '通用-弃用', // Generic
  '配方', // Recipe
  '货币', // Currency
  '箭袋', // Quiver
  '任务', // Quest
  '钥匙', // Key
  '永久的-弃用', // Permanent
  '杂项', // Miscellaneous
  '雕文', // Glyph
];

/// 物品子类别名称（按类别索引）
const kItemSubclasses = [
  // 0: 消耗品
  [
    '消耗品', // Consumable
    '药水', // Potion
    '药剂', // Elixir
    '合剂', // Flask
    '卷轴', // Scroll
    '食物和饮料', // Food & Drink
    '物品强化', // Item Enhancement
    '绷带', // Bandage
    '其他' // Other
  ],
  // 1: 容器
  [
    '背包', // Bag
    '灵魂袋', // Soul Bag
    '草药包', // Herb Bag
    '附魔材料包', // Enchanting Bag
    '工程学材料包', // Engineering Bag
    '宝石袋', // Gem Bag
    '矿物袋', // Mining Bag
    '制皮材料包', // Leatherworking Bag
    '铭文包' // Inscription Bag
  ],
  // 2: 武器
  [
    '单手斧', // Axe 1H
    '双手斧', // Axe 2H
    '弓', // Bow
    '枪', // Gun
    '单手锤', // Mace 1H
    '双手锤', // Mace 2H
    '长柄武器', // Polearm
    '单手剑', // Sword 1H
    '双手剑', // Sword 2H
    '弃用', // Obsolete
    '法杖', // Staff
    '外来的', // Exotic
    '外来的', // Exotic
    '拳套', // Fist Weapon
    '杂项', // Misc
    '匕首', // Dagger
    '投掷', // Thrown
    '矛', // Spear
    '弩', // Crossbow
    '魔杖', // Wand
    '钓鱼竿' // Fishing Pole
  ],
  // 3: 珠宝
  [
    '红色', // Red
    '蓝色', // Blue
    '黄色', // Yellow
    '紫色', // Purple
    '绿色', // Green
    '橙色', // Orange
    '多彩', // Meta
    '简单', // Simple
    '棱彩' // Prismatic
  ],
  // 4: 护甲
  [
    '杂项', // Misc
    '布甲', // Cloth
    '皮甲', // Leather
    '锁甲', // Mail
    '板甲', // Plate
    '小圆盾-弃用', // Buckler
    '盾', // Shield
    '圣契', // Libram
    '神像', // Idol
    '图腾', // Totem
    '魔印' // Sigil
  ],
  // 5: 药剂
  ['药剂'], // Reagent
  // 6: 弹药
  [
    '魔杖-弃用', // Wand
    '闪电-弃用', // Bolt
    '箭', // Arrow
    '子弹', // Bullet
    '投掷-弃用' // Thrown
  ],
  // 7: 贸易品
  [
    '贸易品', // Trade Goods
    '零件', // Parts
    '爆炸物', // Explosives
    '装置', // Devices
    '珠宝加工', // Jewelcrafting
    '布料', // Cloth
    '皮革', // Leather
    '金属和矿石', // Metal & Stone
    '肉类', // Meat
    '草药', // Herb
    '元素', // Elemental
    '其他', // Other
    '附魔', // Enchanting
    '原料', // Materials
    '护甲附魔', // Armor Enchant
    '武器附魔' // Weapon Enchant
  ],
  // 8: 通用-弃用
  ['通用-弃用'], // Generic
  // 9: 配方
  [
    '书籍', // Book
    '制皮', // Leatherworking
    '裁缝', // Tailoring
    '工程学', // Engineering
    '锻造', // Blacksmithing
    '烹饪', // Cooking
    '炼金术', // Alchemy
    '急救', // First Aid
    '附魔', // Enchanting
    '钓鱼', // Fishing
    '珠宝加工' // Jewelcrafting
  ],
  // 10: 货币
  ['货币'], // Currency
  // 11: 箭袋
  [
    '箭袋-弃用', // Quiver Obsolete
    '弹药袋-弃用', // Ammo Pouch Obsolete
    '箭袋', // Quiver
    '弹药袋' // Ammo Pouch
  ],
  // 12: 任务
  ['任务'], // Quest
  // 13: 钥匙
  [
    '钥匙', // Key
    '开锁工具' // Lockpick
  ],
  // 14: 永久的-弃用
  ['永久的-弃用'], // Permanent
  // 15: 杂项
  [
    '垃圾', // Junk
    '施法材料', // Reagent
    '伙伴', // Companion
    '节日', // Holiday
    '其他', // Other
    '坐骑' // Mount
  ],
  // 16: 雕文
  [
    '无', // None
    '战士', // Warrior
    '圣骑士', // Paladin
    '猎人', // Hunter
    '盗贼', // Rogue
    '牧师', // Priest
    '死亡骑士', // Death Knight
    '萨满', // Shaman
    '法师', // Mage
    '术士', // Warlock
    '无', // None
    '德鲁伊' // Druid
  ],
];

/// 物品佩戴位置名称
const kItemInventoryTypes = [
  '其他', // Non-equippable
  '头部', // Head
  '颈部', // Neck
  '肩部', // Shoulder
  '衬衣', // Shirt
  '胸部', // Chest
  '腰部', // Waist
  '腿部', // Legs
  '脚', // Feet
  '手腕', // Wrist
  '手', // Hands
  '手指', // Finger
  '饰品', // Trinket
  '单手', // One-Hand
  '副手-盾', // Shield
  '远程', // Ranged
  '背部', // Back
  '双手', // Two-Hand
  '背包', // Bag
  '披风', // Tabard
  '长袍', // Robe
  '主手', // Main Hand
  '副手', // Off Hand
  '副手物品', // Held in Off-hand
  '弹药', // Ammo
  '投掷', // Thrown
  '远程-右手', // Ranged Right
  '箭袋', // Quiver
  '圣物', // Relic
];
