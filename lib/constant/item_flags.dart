// Item Template 标志位常量定义
// 数据来源：AzerothCore SharedDefines.h, ItemDefines.h

import 'package:foxy/constant/flag_item.dart';

/// AllowableClass 职业标识选项
const kAllowableClassOptions = [
  FlagItem(1, '战士'), // Warrior
  FlagItem(2, '圣骑士'), // Paladin
  FlagItem(4, '猎人'), // Hunter
  FlagItem(8, '盗贼'), // Rogue
  FlagItem(16, '牧师'), // Priest
  FlagItem(32, '死亡骑士'), // Death Knight
  FlagItem(64, '萨满'), // Shaman
  FlagItem(128, '法师'), // Mage
  FlagItem(256, '术士'), // Warlock
  FlagItem(1024, '德鲁伊'), // Druid
];

/// AllowableRace 种族标识选项
const kAllowableRaceOptions = [
  FlagItem(1, '人类'), // Human
  FlagItem(2, '矮人'), // Dwarf
  FlagItem(4, '暗夜精灵'), // Night Elf
  FlagItem(8, '亡灵'), // Undead
  FlagItem(16, '牛头人'), // Tauren
  FlagItem(32, '巨魔'), // Troll
  FlagItem(64, '侏儒'), // Gnome
  FlagItem(128, '兽人'), // Orc
  FlagItem(512, '血精灵'), // Blood Elf
  FlagItem(1024, '德莱尼'), // Draenei
];

/// BagFamily 背包类别标识选项
const kItemBagFamilyOptions = [
  FlagItem(1, '箭袋'), // Quiver
  FlagItem(2, '弹药袋'), // Ammo Pouch
  FlagItem(4, '灵魂碎片'), // Soul Shard
  FlagItem(8, '皮革用品'), // Leatherworking
  FlagItem(16, '铭文袋'), // Inscription
  FlagItem(32, '草药袋'), // Herb
  FlagItem(64, '附魔袋'), // Enchanting
  FlagItem(128, '工程袋'), // Engineering
  FlagItem(256, '钥匙袋'), // Key
  FlagItem(512, '珠宝袋'), // Jewelcrafting
  FlagItem(1024, '矿石袋'), // Mining
  FlagItem(2048, '灵魂绑定'), // Soulbound
  FlagItem(4096, '宠物栏'), // Pet
  FlagItem(8192, '钱袋'), // Money
  FlagItem(16384, '任务物品'), // Quest
];

/// Item Flags 物品标识选项
const kItemFlagOptions = [
  FlagItem(1, '不可拾取'),
  FlagItem(2, '魔法制造'), // Conjured
  FlagItem(4, '包含掉落'),
  FlagItem(8, '英雄提示'),
  FlagItem(16, '废弃物品'), // Deprecated
  FlagItem(32, '无法摧毁'), // Indestructible
  FlagItem(64, '玩家可施法'),
  FlagItem(128, '无装备冷却'),
  FlagItem(256, '多次任务拾取'),
  FlagItem(512, '包裹'), // Wrapper
  FlagItem(1024, '使用资源'),
  FlagItem(2048, '多次掉落'),
  FlagItem(4096, '购买记录'),
  FlagItem(8192, '请愿书'),
  FlagItem(16384, '包含文本'),
  FlagItem(32768, '不可分解'),
  FlagItem(65536, '实时持续时间'),
  FlagItem(131072, '不记录制造者'),
  FlagItem(262144, '可勘探/选矿掉落'), // Prospectable
  FlagItem(524288, '装备唯一'), // Unique Equip
  FlagItem(1048576, '光环忽略'),
  FlagItem(2097152, '竞技场可用'), // Arena
  FlagItem(4194304, '无耐久损失'),
  FlagItem(8388608, '变形时可用'), // Shapeshift
  FlagItem(16777216, '任务发光'),
  FlagItem(33554432, '隐藏不可用配方'),
  FlagItem(67108864, '竞技场不可用'), // Not in Arena
  FlagItem(134217728, '账号绑定'), // Account Bound
  FlagItem(268435456, '施法不消耗材料'),
  FlagItem(536870912, '研磨掉落'), // Millable
  FlagItem(1073741824, '报告到公会频道'),
  FlagItem(2147483648, '禁用渐进掉落'),
];

/// Item flagsCustom 自定义标识选项
const kItemFlagsCustomOptions = [
  FlagItem(1, '玩家下线也计时'), // Duration Real Time
  FlagItem(2, '掉落时不检测任务状态'), // Ignore Quest Status
  FlagItem(4, '点贪婪前遵守掉落规则'), // No Loot Animation
];

/// Item FlagsExtra 额外标识选项
const kItemFlagsExtraOptions = [
  FlagItem(1, '部落'), // Horde
  FlagItem(2, '联盟'), // Alliance
  FlagItem(4, '扩展价格仍需金币'),
  FlagItem(8, '按施法物品分类'),
  FlagItem(16, '按物理物品分类'),
  FlagItem(32, '所有人可需求'),
  FlagItem(64, '拾取绑定不可交易'),
  FlagItem(128, '拾取绑定可交易'),
  FlagItem(256, '只能贪婪'),
  FlagItem(512, '施法武器'),
  FlagItem(1024, '登录时删除'),
  FlagItem(2048, '内部物品'),
  FlagItem(4096, '无商店价值'),
  FlagItem(8192, '发现前显示'),
  FlagItem(16384, '覆盖金币花费'),
  FlagItem(32768, '忽略评级战场默认限制'),
  FlagItem(65536, '评级战场不可用'),
  FlagItem(131072, '战网账号可交易'),
  FlagItem(262144, '使用前确认'),
  FlagItem(524288, '变换时重新判断绑定'),
  FlagItem(1048576, '充能耗尽时不变换'),
  FlagItem(2097152, '不改变物品外观'),
  FlagItem(4194304, '不能作为外观来源'),
  FlagItem(8388608, '外观来源忽略品质'),
  FlagItem(16777216, '无耐久'),
  FlagItem(33554432, '坦克角色'),
  FlagItem(67108864, '治疗角色'),
  FlagItem(134217728, '伤害角色'),
  FlagItem(268435456, '挑战模式可掉落'),
  FlagItem(536870912, '掉落界面不堆叠'),
  FlagItem(1073741824, '分解到掉落模板'),
  FlagItem(2147483648, '用于专业技能'),
];

/// ScalingStatValue 缩放属性标识选项
const kItemScalingStatValueOptions = [
  FlagItem(0x00000001, '肩部预算'),
  FlagItem(0x00000002, '饰品预算'),
  FlagItem(0x00000004, '单手武器预算'),
  FlagItem(0x00000008, '主要预算'),
  FlagItem(0x00000010, '远程预算'),
  FlagItem(0x00000020, '布甲肩部护甲'),
  FlagItem(0x00000040, '皮甲肩部护甲'),
  FlagItem(0x00000080, '锁甲肩部护甲'),
  FlagItem(0x00000100, '板甲肩部护甲'),
  FlagItem(0x00000200, '单手武器 DPS'),
  FlagItem(0x00000400, '双手武器 DPS'),
  FlagItem(0x00000800, '法系单手 DPS'),
  FlagItem(0x00001000, '法系双手 DPS'),
  FlagItem(0x00002000, '远程 DPS'),
  FlagItem(0x00004000, '魔杖 DPS'),
  FlagItem(0x00008000, '法术强度'),
  FlagItem(0x00040000, '三级预算'),
  FlagItem(0x00080000, '披风护甲'),
  FlagItem(0x00100000, '布甲胸部护甲'),
  FlagItem(0x00200000, '皮甲胸部护甲'),
  FlagItem(0x00400000, '锁甲胸部护甲'),
  FlagItem(0x00800000, '板甲胸部护甲'),
];

/// SocketColor 是位掩码，服务端允许四种颜色的任意组合。
const kItemSocketColorFlagOptions = [
  FlagItem(1, '多彩'),
  FlagItem(2, '红色'),
  FlagItem(4, '黄色'),
  FlagItem(8, '蓝色'),
];
