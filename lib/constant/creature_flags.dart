// Creature Template 标志位常量定义
// 数据来源：AzerothCore SharedDefines.h, UnitDefines.h

/// 标志位项
class FlagItem {
  final int value;
  final String label;
  final String? group;

  const FlagItem(this.value, this.label, [this.group]);
}

const kLootModeFlagOptions = [
  FlagItem(0x0001, '默认'),
  FlagItem(0x0002, '困难模式 1'),
  FlagItem(0x0004, '困难模式 2'),
  FlagItem(0x0008, '困难模式 3'),
  FlagItem(0x0010, '困难模式 4'),
  FlagItem(0x8000, '垃圾鱼'),
];

/// NPC 标识选项
const kNpcFlagOptions = [
  FlagItem(0x00000001, '对话', '基础功能'), // Gossip
  FlagItem(0x00000002, '任务', '基础功能'), // Quest Giver
  FlagItem(0x00000004, 'UNK1'),
  FlagItem(0x00000008, 'UNK2'),
  FlagItem(0x00000010, '训练师', '训练师'), // Trainer
  FlagItem(0x00000020, '职业训练师', '训练师'), // Class Trainer
  FlagItem(0x00000040, '专业训练师', '训练师'), // Profession Trainer
  FlagItem(0x00000080, '商人', '商人'), // Vendor
  FlagItem(0x00000100, '弹药商人', '商人'), // Vendor Ammo
  FlagItem(0x00000200, '食物商人', '商人'), // Vendor Food
  FlagItem(0x00000400, '毒药商人', '商人'), // Vendor Poison
  FlagItem(0x00000800, '材料商人', '商人'), // Vendor Reagent
  FlagItem(0x00001000, '修理', '服务'), // Repair
  FlagItem(0x00002000, '飞行管理员', '服务'), // Flight Master
  FlagItem(0x00004000, '灵魂医者', '服务'), // Spirit Healer
  FlagItem(0x00008000, '灵魂向导', '服务'), // Spirit Guide
  FlagItem(0x00010000, '旅店老板', '服务'), // Innkeeper
  FlagItem(0x00020000, '银行', '服务'), // Banker
  FlagItem(0x00040000, '公会请愿人', '服务'), // Petitioner
  FlagItem(0x00080000, '公会徽章设计师', '服务'), // Tabard Designer
  FlagItem(0x00100000, '战场军需官', '服务'), // Battlemaster
  FlagItem(0x00200000, '拍卖师', '服务'), // Auctioneer
  FlagItem(0x00400000, '兽栏管理员', '服务'), // Stable Master
  FlagItem(0x00800000, '公会银行', '服务'), // Guild Banker
  FlagItem(0x01000000, '法术点击', '特殊'), // Spellclick
  FlagItem(0x02000000, '玩家载具', '特殊'), // Player Vehicle
  FlagItem(0x04000000, '邮箱', '服务'), // Mailbox
];

/// 单位标识选项
const kUnitFlagOptions = [
  FlagItem(0x00000001, '服务器控制'), // Server Controlled
  FlagItem(0x00000002, '不可攻击'), // Non Attackable
  FlagItem(0x00000004, '禁止移动'), // Disable Move
  FlagItem(0x00000008, '玩家控制'), // Player Controlled
  FlagItem(0x00000010, '可重命名'), // Rename
  FlagItem(0x00000020, '准备状态'), // Preparation
  FlagItem(0x00000040, 'UNK_6'),
  FlagItem(0x00000080, '不可攻击1'), // Not Attackable 1
  FlagItem(0x00000100, '对玩家免疫'), // Immune To PC
  FlagItem(0x00000200, '对NPC免疫'), // Immune To NPC
  FlagItem(0x00000400, '拾取中'), // Looting
  FlagItem(0x00000800, '宠物战斗中'), // Pet In Combat
  FlagItem(0x00001000, 'PVP'),
  FlagItem(0x00002000, '沉默'), // Silenced
  FlagItem(0x00004000, '不能游泳'), // Cannot Swim
  FlagItem(0x00008000, '游泳中'), // Swimming
  FlagItem(0x00010000, '不可攻击2'), // Not Attackable 2
  FlagItem(0x00020000, '无法攻击'), // Pacified
  FlagItem(0x00040000, '昏迷'), // Stunned
  FlagItem(0x00080000, '战斗中'), // In Combat
  FlagItem(0x00100000, '飞行中'), // Taxi Flight
  FlagItem(0x00200000, '缴械'), // Disarmed
  FlagItem(0x00400000, '混乱'), // Confused
  FlagItem(0x00800000, '恐惧'), // Fleeing
  FlagItem(0x01000000, '玩家控制中'), // Possessed
  FlagItem(0x02000000, '不可选择'), // Not Selectable
  FlagItem(0x04000000, '可剥皮'), // Skinnable
  FlagItem(0x08000000, '坐骑'), // Mount
  FlagItem(0x10000000, 'UNK_28'),
  FlagItem(0x20000000, '阻止聊天文本触发表情'), // Prevent Emotes From Chat Text
  FlagItem(0x40000000, '收起武器'), // Sheathe
  FlagItem(0x80000000, '免疫伤害'), // Immune
];

/// 单位标识2选项
const kUnitFlag2Options = [
  FlagItem(0x00000001, '假死'), // Feign Death
  FlagItem(0x00000002, '隐藏身体'), // Hide Body
  FlagItem(0x00000004, '忽略声望'), // Ignore Reputation
  FlagItem(0x00000008, '理解语言'), // Comprehend Lang
  FlagItem(0x00000010, '镜像'), // Mirror Image
  FlagItem(0x00000020, '不淡入'), // Do Not Fade In
  FlagItem(0x00000040, '强制移动'), // Force Movement
  FlagItem(0x00000080, '缴械副手'), // Disarm Offhand
  FlagItem(0x00000100, '禁用预测状态'), // Disable Pred Stats
  FlagItem(0x00000400, '缴械远程'), // Disarm Ranged
  FlagItem(0x00000800, '回复能量'), // Regenerate Power
  FlagItem(0x00001000, '限制队伍交互'), // Restrict Party Interaction
  FlagItem(0x00002000, '阻止法术点击'), // Prevent Spell Click
  FlagItem(0x00004000, '允许敌对交互'), // Allow Enemy Interact
  FlagItem(0x00008000, '不能转向'), // Cannot Turn
  FlagItem(0x00010000, 'UNK2'),
  FlagItem(0x00020000, '播放死亡动画'), // Play Death Anim
  FlagItem(0x00040000, '允许作弊法术'), // Allow Cheat Spells
  FlagItem(0x01000000, '未使用 6'), // Unused 6
];

/// 类型标识选项
const kCreatureTypeFlagOptions = [
  FlagItem(0x00000001, '可驯服'), // Tameable
  FlagItem(0x00000002, '死亡玩家可见'), // Visible To Ghosts
  FlagItem(0x00000004, '首领（?? 等级）'), // Boss Mob
  FlagItem(0x00000008, '不播放受伤动画'), // No Wound Anim
  FlagItem(0x00000010, '无阵营提示'), // No Faction Tooltip
  FlagItem(0x00000020, '更易被听见'), // More Audible
  FlagItem(0x00000040, '可被法术攻击'), // Spell Attackable
  FlagItem(0x00000080, '死亡可交互'), // Interact While Dead
  FlagItem(0x00000100, '草药剥皮'), // Skin With Herbalism
  FlagItem(0x00000200, '采矿剥皮'), // Skin With Mining
  FlagItem(0x00000400, '无死亡消息'), // No Death Message
  FlagItem(0x00000800, '允许骑乘战斗'), // Allow Mounted Combat
  FlagItem(0x00001000, '可协助'), // Can Assist
  FlagItem(0x00002000, '不显示宠物动作条'), // No Pet Bar
  FlagItem(0x00004000, '隐藏唯一标识（Mask UID）'), // Mask UID
  FlagItem(0x00008000, '工程剥皮'), // Skin With Engineering
  FlagItem(0x00010000, '可驯服（特殊宠物）'), // Tameable Exotic
  FlagItem(0x00020000, '使用模型碰撞大小'), // Use Model Collision Size
  FlagItem(0x00040000, '战斗中可交互'), // Allow Interaction While In Combat
  FlagItem(0x00080000, '可与投射物碰撞'), // Collide With Missiles
  FlagItem(0x00100000, '隐藏姓名板'), // No Name Plate
  FlagItem(0x00200000, '不播放骑乘动画'), // Do Not Play Mounted Animations
  FlagItem(0x00400000, '关联全部'), // Link All
  FlagItem(0x00800000, '仅创建者可交互'), // Interact Only With Creator
  FlagItem(0x01000000, '不播放单位事件音效'), // Do Not Play Unit Event Sounds
  FlagItem(0x02000000, '不显示阴影斑点'), // Has No Shadow Blob
  FlagItem(0x04000000, '视为团队成员'), // Treat As Raid Unit
  FlagItem(0x08000000, '强制显示对话'), // Force Gossip
  FlagItem(0x10000000, '不收起武器'), // Do Not Sheathe
  FlagItem(0x20000000, '交互时不选中目标'), // Do Not Target On Interaction
  FlagItem(0x40000000, '不显示对象名称'), // Do Not Render Object Name
  FlagItem(0x80000000, '任务首领'), // Quest Boss
];

/// 动态标识选项
const kDynamicFlagOptions = [
  FlagItem(0x00000001, '可拾取'), // Lootable
  FlagItem(0x00000002, '追踪单位'), // Track Unit
  FlagItem(0x00000004, '已标记'), // Tapped
  FlagItem(0x00000008, '被当前玩家标记'), // Tapped By Player
  FlagItem(0x00000010, '特殊信息'), // Special Info
  FlagItem(0x00000020, '死亡'), // Dead
  FlagItem(0x00000040, '招募好友'), // Refer A Friend
  FlagItem(0x00000080, '被全部仇恨列表标记'), // Tapped By All Threat List
];

/// 额外标识选项
const kFlagsExtraOptions = [
  FlagItem(0x00000001, '副本绑定'), // Instance Bind
  FlagItem(0x00000002, '平民'), // Civilian
  FlagItem(0x00000004, '禁止招架'), // No Parry
  FlagItem(0x00000008, '招架不加速'), // No Parry Hasten
  FlagItem(0x00000010, '禁止格挡'), // No Block
  FlagItem(0x00000020, '禁止碾压攻击'), // No Crushing Blows
  FlagItem(0x00000040, '击杀不提供经验'), // No XP
  FlagItem(0x00000080, '触发器生物'), // Trigger
  FlagItem(0x00000100, '免疫嘲讽（已弃用）'), // No Taunt
  FlagItem(0x00000200, '不更新移动标志'), // No Move Flags Update
  FlagItem(0x00000400, '仅灵魂可见'), // Ghost Visibility
  FlagItem(0x00000800, '使用副手攻击'), // Use Offhand Attack
  FlagItem(0x00001000, '禁止向商人出售'), // No Sell Vendor
  FlagItem(0x00002000, '禁止进入战斗'), // Cannot Enter Combat
  FlagItem(0x00004000, '世界事件'), // World Event
  FlagItem(0x00008000, '守卫'), // Guard
  FlagItem(0x00010000, '忽略假死'), // Ignore Feign Death
  FlagItem(0x00020000, '禁止暴击'), // No Crit
  FlagItem(0x00040000, '不提升武器技能'), // No Skill Gains
  FlagItem(0x00080000, '嘲讽受递减规则影响'), // Taunt Diminishing Returns
  FlagItem(0x00100000, '所有控制受递减规则影响'), // All Diminish
  FlagItem(0x00200000, '击杀归属无需玩家伤害'), // No Player Damage Requirement
  FlagItem(0x00400000, '不作为范围法术目标（已弃用）'), // Avoid AoE
  FlagItem(0x00800000, '禁止闪避'), // No Dodge
  FlagItem(0x01000000, '模块生物'), // Module
  FlagItem(0x02000000, '不呼叫援助'), // Don't Call Assistance
  FlagItem(0x04000000, '忽略所有援助呼叫'), // Ignore All Assistance Calls
  FlagItem(0x08000000, '不覆盖 Entry SmartAI'), // Don't Override Entry SAI
  // 0x10000000 由服务端动态设置，禁止写入数据库。
  FlagItem(0x20000000, '忽略寻路'), // Ignore Pathfinding
  FlagItem(0x40000000, '免疫击退（已弃用）'), // Immunity Knockback
  FlagItem(0x80000000, '强制完全重置'), // Hard Reset
];

/// 免疫机制选项
const kMechanicImmuneMaskOptions = [
  FlagItem(0x00000001, '魅惑'), // Charm
  FlagItem(0x00000002, '迷惑'), // Disoriented
  FlagItem(0x00000004, '缴械'), // Disarm
  FlagItem(0x00000008, '分心'), // Distract
  FlagItem(0x00000010, '恐惧'), // Fear
  FlagItem(0x00000020, '抓取'), // Grip
  FlagItem(0x00000040, '定身'), // Root
  FlagItem(0x00000080, '减速'), // Slow Attack
  FlagItem(0x00000100, '沉默'), // Silence
  FlagItem(0x00000200, '睡眠'), // Sleep
  FlagItem(0x00000400, '减速'), // Snare
  FlagItem(0x00000800, '昏迷'), // Stun
  FlagItem(0x00001000, '冰冻'), // Freeze
  FlagItem(0x00002000, '击倒'), // Knockout
  FlagItem(0x00004000, '流血'), // Bleed
  FlagItem(0x00008000, '变形'), // Bandage
  FlagItem(0x00010000, '变形'), // Polymorph
  FlagItem(0x00020000, '驱逐'), // Banish
  FlagItem(0x00040000, '护盾'), // Shield
  FlagItem(0x00080000, '束缚'), // Shackle
  FlagItem(0x00100000, '坐骑'), // Mount
  FlagItem(0x00200000, '感染'), // Infected
  FlagItem(0x00400000, '转向'), // Turn
  FlagItem(0x00800000, '恐慌'), // Horror
  FlagItem(0x01000000, '无敌'), // Invulnerability
  FlagItem(0x02000000, '打断'), // Interrupt
  FlagItem(0x04000000, '眩晕'), // Daze
  FlagItem(0x08000000, '发现'), // Discovery
  FlagItem(0x10000000, '免疫护盾'), // Immune Shield
  FlagItem(0x20000000, '疲劳'), // Sapped
  FlagItem(0x40000000, '狂怒'), // Enraged
];

/// 免疫法术类型选项
const kSpellSchoolImmuneMaskOptions = [
  FlagItem(0x01, '物理'), // Physical
  FlagItem(0x02, '神圣'), // Holy
  FlagItem(0x04, '火焰'), // Fire
  FlagItem(0x08, '自然'), // Nature
  FlagItem(0x10, '冰霜'), // Frost
  FlagItem(0x20, '暗影'), // Shadow
  FlagItem(0x40, '奥术'), // Arcane
];

/// 栖息类型选项
const kInhabitTypeOptions = [
  FlagItem(0x01, '地面'), // Ground
  FlagItem(0x02, '水中'), // Water
  FlagItem(0x04, '飞行'), // Flying
];
