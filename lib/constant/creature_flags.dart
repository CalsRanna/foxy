// Creature Template 标志位常量定义
// 数据来源：AzerothCore SharedDefines.h, UnitDefines.h

/// 标志位项
class FlagItem {
  final int value;
  final String label;
  final String? group;

  const FlagItem(this.value, this.label, [this.group]);
}

/// NPC 标识选项 (npcflag)
const kNpcFlagOptions = [
  FlagItem(0x00000001, '对话 (Gossip)', '基础功能'),
  FlagItem(0x00000002, '任务 (Quest Giver)', '基础功能'),
  FlagItem(0x00000004, 'UNK1'),
  FlagItem(0x00000008, 'UNK2'),
  FlagItem(0x00000010, '训练师 (Trainer)', '训练师'),
  FlagItem(0x00000020, '职业训练师 (Class Trainer)', '训练师'),
  FlagItem(0x00000040, '专业训练师 (Profession Trainer)', '训练师'),
  FlagItem(0x00000080, '商人 (Vendor)', '商人'),
  FlagItem(0x00000100, '弹药商人 (Vendor Ammo)', '商人'),
  FlagItem(0x00000200, '食物商人 (Vendor Food)', '商人'),
  FlagItem(0x00000400, '毒药商人 (Vendor Poison)', '商人'),
  FlagItem(0x00000800, '材料商人 (Vendor Reagent)', '商人'),
  FlagItem(0x00001000, '修理 (Repair)', '服务'),
  FlagItem(0x00002000, '飞行管理员 (Flight Master)', '服务'),
  FlagItem(0x00004000, '灵魂医者 (Spirit Healer)', '服务'),
  FlagItem(0x00008000, '灵魂向导 (Spirit Guide)', '服务'),
  FlagItem(0x00010000, '旅店老板 (Innkeeper)', '服务'),
  FlagItem(0x00020000, '银行 (Banker)', '服务'),
  FlagItem(0x00040000, '公会请愿人 (Petitioner)', '服务'),
  FlagItem(0x00080000, '公会徽章设计师 (Tabard Designer)', '服务'),
  FlagItem(0x00100000, '战场军需官 (Battlemaster)', '服务'),
  FlagItem(0x00200000, '拍卖师 (Auctioneer)', '服务'),
  FlagItem(0x00400000, '兽栏管理员 (Stable Master)', '服务'),
  FlagItem(0x00800000, '公会银行 (Guild Banker)', '服务'),
  FlagItem(0x01000000, '法术点击 (Spellclick)', '特殊'),
  FlagItem(0x02000000, '玩家载具 (Player Vehicle)', '特殊'),
  FlagItem(0x04000000, '邮箱 (Mailbox)', '服务'),
];

/// 单位标识选项 (unit_flags)
const kUnitFlagOptions = [
  FlagItem(0x00000001, '服务器控制 (Server Controlled)'),
  FlagItem(0x00000002, '不可攻击 (Non Attackable)'),
  FlagItem(0x00000004, '禁止移动 (Disable Move)'),
  FlagItem(0x00000008, '玩家控制 (Player Controlled)'),
  FlagItem(0x00000010, '可重命名 (Rename)'),
  FlagItem(0x00000020, '准备状态 (Preparation)'),
  FlagItem(0x00000040, 'UNK_6'),
  FlagItem(0x00000080, '不可攻击1 (Not Attackable 1)'),
  FlagItem(0x00000100, '对玩家免疫 (Immune To PC)'),
  FlagItem(0x00000200, '对NPC免疫 (Immune To NPC)'),
  FlagItem(0x00000400, '拾取中 (Looting)'),
  FlagItem(0x00000800, '宠物战斗中 (Pet In Combat)'),
  FlagItem(0x00001000, 'PVP'),
  FlagItem(0x00002000, '沉默 (Silenced)'),
  FlagItem(0x00004000, '不能游泳 (Cannot Swim)'),
  FlagItem(0x00008000, '游泳中 (Swimming)'),
  FlagItem(0x00010000, '不可攻击2 (Not Attackable 2)'),
  FlagItem(0x00020000, '无法攻击 (Pacified)'),
  FlagItem(0x00040000, '昏迷 (Stunned)'),
  FlagItem(0x00080000, '战斗中 (In Combat)'),
  FlagItem(0x00100000, '飞行中 (Taxi Flight)'),
  FlagItem(0x00200000, '缴械 (Disarmed)'),
  FlagItem(0x00400000, '混乱 (Confused)'),
  FlagItem(0x00800000, '恐惧 (Fleeing)'),
  FlagItem(0x01000000, '玩家控制中 (Possessed)'),
  FlagItem(0x02000000, '不可选择 (Not Selectable)'),
  FlagItem(0x04000000, '可剥皮 (Skinnable)'),
  FlagItem(0x08000000, '坐骑 (Mount)'),
  FlagItem(0x10000000, 'UNK_28'),
  FlagItem(0x20000000, 'UNK_29'),
  FlagItem(0x40000000, '变形 (Sheathe)'),
  FlagItem(0x80000000, 'UNK_31'),
];

/// 单位标识2选项 (unit_flags2)
const kUnitFlag2Options = [
  FlagItem(0x00000001, '假死 (Feign Death)'),
  FlagItem(0x00000002, '隐藏身体 (Hide Body)'),
  FlagItem(0x00000004, '忽略声望 (Ignore Reputation)'),
  FlagItem(0x00000008, '理解语言 (Comprehend Lang)'),
  FlagItem(0x00000010, '镜像 (Mirror Image)'),
  FlagItem(0x00000020, '不淡入 (Do Not Fade In)'),
  FlagItem(0x00000040, '强制移动 (Force Movement)'),
  FlagItem(0x00000080, '缴械副手 (Disarm Offhand)'),
  FlagItem(0x00000100, '禁用预测状态 (Disable Pred Stats)'),
  FlagItem(0x00000400, '缴械远程 (Disarm Ranged)'),
  FlagItem(0x00000800, '回复能量 (Regenerate Power)'),
  FlagItem(0x00001000, '限制队伍交互 (Restrict Party Interaction)'),
  FlagItem(0x00002000, '阻止法术点击 (Prevent Spell Click)'),
  FlagItem(0x00004000, '允许敌对交互 (Allow Enemy Interact)'),
  FlagItem(0x00008000, '不能转向 (Cannot Turn)'),
  FlagItem(0x00010000, 'UNK2'),
  FlagItem(0x00020000, '播放死亡动画 (Play Death Anim)'),
  FlagItem(0x00040000, '允许作弊法术 (Allow Cheat Spells)'),
];

/// 类型标识选项 (type_flags)
const kCreatureTypeFlagOptions = [
  FlagItem(0x00000001, '可驯服 (Tameable)'),
  FlagItem(0x00000002, '灵魂可见 (Visible To Ghosts)'),
  FlagItem(0x00000004, 'BOSS'),
  FlagItem(0x00000008, '不播放受伤动画 (No Wound Anim)'),
  FlagItem(0x00000010, '无阵营提示 (No Faction Tooltip)'),
  FlagItem(0x00000020, '更响亮 (More Audible)'),
  FlagItem(0x00000040, '法术可攻击 (Spell Attackable)'),
  FlagItem(0x00000080, '死亡可交互 (Interact While Dead)'),
  FlagItem(0x00000100, '草药剥皮 (Skin With Herbalism)'),
  FlagItem(0x00000200, '采矿剥皮 (Skin With Mining)'),
  FlagItem(0x00000400, '无死亡消息 (No Death Message)'),
  FlagItem(0x00000800, '允许骑乘战斗 (Allow Mounted Combat)'),
  FlagItem(0x00001000, '可协助 (Can Assist)'),
  FlagItem(0x00002000, '无宠物栏 (No Pet Bar)'),
  FlagItem(0x00004000, '面具生物 (Mask UID)'),
  FlagItem(0x00008000, '工程剥皮 (Skin With Engineering)'),
  FlagItem(0x00010000, '奇特外观 (Exotic)'),
  FlagItem(0x00020000, '使用模型碰撞大小 (Use Model Collision Size)'),
  FlagItem(0x00040000, '允许远程交互 (Allow Interaction While In Combat)'),
  FlagItem(0x00080000, '法术可点击 (Spell Clickable)'),
];

/// 动态标识选项 (dynamicflags)
const kDynamicFlagOptions = [
  FlagItem(0x00000001, '可拾取 (Lootable)'),
  FlagItem(0x00000002, '追踪单位 (Track Unit)'),
  FlagItem(0x00000004, '已标记 (Tapped)'),
  FlagItem(0x00000008, '其他人标记 (Tapped By All Threat List)'),
  FlagItem(0x00000010, '特殊信息 (Special Info)'),
  FlagItem(0x00000020, '死亡 (Dead)'),
  FlagItem(0x00000040, '引用玩家 (Refer A Friend)'),
  FlagItem(0x00000080, '被其他人标记 (Tapped By Player)'),
];

/// 额外标识选项 (flags_extra)
const kFlagsExtraOptions = [
  FlagItem(0x00000001, '实例绑定 (Instance Bind)'),
  FlagItem(0x00000002, '平民 (Civilian)'),
  FlagItem(0x00000004, '无parry (No Parry)'),
  FlagItem(0x00000008, '无parry急速 (No Parry Hasten)'),
  FlagItem(0x00000010, '无格挡 (No Block)'),
  FlagItem(0x00000020, '无碾压 (No Crush)'),
  FlagItem(0x00000040, '无经验 (No XP At Kill)'),
  FlagItem(0x00000080, '触发 (Trigger)'),
  FlagItem(0x00000100, '无taunt (No Taunt)'),
  FlagItem(0x00000400, '世界事件 (Worldevent)'),
  FlagItem(0x00000800, '守卫 (Guard)'),
  FlagItem(0x00004000, '无仇恨 (No Crit)'),
  FlagItem(0x00008000, '无技能提升 (No Skill Gain)'),
  FlagItem(0x00010000, '被召唤时服从召唤者目标 (Taunt Diminish)'),
  FlagItem(0x00020000, '所有仇恨减少 (All Diminish)'),
  FlagItem(0x00080000, '地下城BOSS (Dungeon Boss)'),
  FlagItem(0x00100000, '忽略寻路 (Ignore Pathfinding)'),
  FlagItem(0x00200000, '免疫击退 (Immunity Knockback)'),
];

/// 免疫机制选项 (mechanic_immune_mask)
const kMechanicImmuneMaskOptions = [
  FlagItem(0x00000001, '魅惑 (Charm)'),
  FlagItem(0x00000002, '迷惑 (Disoriented)'),
  FlagItem(0x00000004, '缴械 (Disarm)'),
  FlagItem(0x00000008, '分心 (Distract)'),
  FlagItem(0x00000010, '恐惧 (Fear)'),
  FlagItem(0x00000020, '抓取 (Grip)'),
  FlagItem(0x00000040, '定身 (Root)'),
  FlagItem(0x00000080, '减速 (Slow Attack)'),
  FlagItem(0x00000100, '沉默 (Silence)'),
  FlagItem(0x00000200, '睡眠 (Sleep)'),
  FlagItem(0x00000400, '减速 (Snare)'),
  FlagItem(0x00000800, '昏迷 (Stun)'),
  FlagItem(0x00001000, '冰冻 (Freeze)'),
  FlagItem(0x00002000, '击倒 (Knockout)'),
  FlagItem(0x00004000, '流血 (Bleed)'),
  FlagItem(0x00008000, '变形 (Bandage)'),
  FlagItem(0x00010000, '变形 (Polymorph)'),
  FlagItem(0x00020000, '驱逐 (Banish)'),
  FlagItem(0x00040000, '护盾 (Shield)'),
  FlagItem(0x00080000, '束缚 (Shackle)'),
  FlagItem(0x00100000, '坐骑 (Mount)'),
  FlagItem(0x00200000, '感染 (Infected)'),
  FlagItem(0x00400000, '转向 (Turn)'),
  FlagItem(0x00800000, '恐慌 (Horror)'),
  FlagItem(0x01000000, '无敌 (Invulnerability)'),
  FlagItem(0x02000000, '打断 (Interrupt)'),
  FlagItem(0x04000000, '眩晕 (Daze)'),
  FlagItem(0x08000000, '发现 (Discovery)'),
  FlagItem(0x10000000, '免疫护盾 (Immune Shield)'),
  FlagItem(0x20000000, '疲劳 (Sapped)'),
  FlagItem(0x40000000, '狂怒 (Enraged)'),
];

/// 免疫法术类型选项 (spell_school_immune_mask)
const kSpellSchoolImmuneMaskOptions = [
  FlagItem(0x01, '物理 (Physical)'),
  FlagItem(0x02, '神圣 (Holy)'),
  FlagItem(0x04, '火焰 (Fire)'),
  FlagItem(0x08, '自然 (Nature)'),
  FlagItem(0x10, '冰霜 (Frost)'),
  FlagItem(0x20, '暗影 (Shadow)'),
  FlagItem(0x40, '奥术 (Arcane)'),
];
