// Item Template 标志位常量定义
// 数据来源：AzerothCore SharedDefines.h, ItemDefines.h

import 'package:foxy/constant/creature_flags.dart';

/// Item Flags 物品标识选项 (flags)
const kItemFlagOptions = [
  FlagItem(1, '未知 (Unknown)'),
  FlagItem(2, '魔法制造 (Conjured)'),
  FlagItem(4, '可打开的 (Openable)'),
  FlagItem(8, '英雄等级 (Heroic)'),
  FlagItem(16, '废弃物品 (Deprecated)'),
  FlagItem(32, '无法摧毁 (Indestructible)'),
  FlagItem(64, '未知 (Unknown)'),
  FlagItem(128, '无冷却 (No Cooldown)'),
  FlagItem(256, '未知 (Unknown)'),
  FlagItem(512, '包裹 (Wrapper)'),
  FlagItem(1024, '未知 (Unknown)'),
  FlagItem(2048, '部分掉落 (Party Loot)'),
  FlagItem(4096, '可退还 (Refundable)'),
  FlagItem(8192, '登记表 (Charter)'),
  FlagItem(16384, '可读物品 (Readable)'),
  FlagItem(32768, '未知 (Unknown)'),
  FlagItem(65536, '未知 (Unknown)'),
  FlagItem(131072, '未知 (Unknown)'),
  FlagItem(262144, '可勘探/选矿掉落 (Prospectable)'),
  FlagItem(524288, '装备唯一 (Unique Equip)'),
  FlagItem(1048576, '未知 (Unknown)'),
  FlagItem(2097152, '竞技场可用 (Arena)'),
  FlagItem(4194304, '异常 (Throwable)'),
  FlagItem(8388608, '变形时可用 (Shapeshift)'),
  FlagItem(16777216, '未知 (Unknown)'),
  FlagItem(33554432, '职业配方 (Profession Recipe)'),
  FlagItem(67108864, '竞技场不可用 (Not in Arena)'),
  FlagItem(134217728, '账号绑定 (Account Bound)'),
  FlagItem(268435456, '触发标志 (Triggered)'),
  FlagItem(536870912, '研磨掉落 (Millable)'),
  FlagItem(1073741824, '未知 (Unknown)'),
  FlagItem(2147483648, '拾取绑定可交易 (Upgradable)'),
];

/// Item FlagsExtra 额外标识选项 (flagsExtra)
const kItemFlagsExtraOptions = [
  FlagItem(1, '部落 (Horde)'),
  FlagItem(2, '联盟 (Alliance)'),
  FlagItem(4, '附带金钱 (Extra Gold)'),
  FlagItem(8, '未知 (Unknown)'),
  FlagItem(16, '未知 (Unknown)'),
  FlagItem(32, '未知 (Unknown)'),
  FlagItem(64, '未知 (Unknown)'),
  FlagItem(128, '未知 (Unknown)'),
  FlagItem(256, '不用roll点 (No Roll)'),
  FlagItem(512, '取消roll点 (Cancel Roll)'),
  FlagItem(1024, '未知 (Unknown)'),
  FlagItem(2048, '未知 (Unknown)'),
  FlagItem(4096, '未知 (Unknown)'),
  FlagItem(8192, '未知 (Unknown)'),
  FlagItem(16384, '普通标价 (Normal Price)'),
  FlagItem(32768, '未知 (Unknown)'),
  FlagItem(65536, '未知 (Unknown)'),
  FlagItem(131072, '账号绑定 (Account Bound)'),
  FlagItem(262144, '未知 (Unknown)'),
  FlagItem(524288, '未知 (Unknown)'),
  FlagItem(1048576, '未知 (Unknown)'),
  FlagItem(2097152, '不能被变形 (Cannot Transmog)'),
  FlagItem(4194304, '不能变形 (Cannot Transmog Destination)'),
  FlagItem(8388608, '可以变形 (Can Transmog)'),
];

/// Item flagsCustom 自定义标识选项 (flagsCustom)
const kItemFlagsCustomOptions = [
  FlagItem(1, '玩家下线也计时 (Duration Real Time)'),
  FlagItem(2, '掉落时不检测任务状态 (Ignore Quest Status)'),
  FlagItem(4, '点贪婪前遵守掉落规则 (No Loot Animation)'),
];

/// BagFamily 背包类别标识选项 (BagFamily)
const kItemBagFamilyOptions = [
  FlagItem(1, '箭袋 (Quiver)'),
  FlagItem(2, '弹药袋 (Ammo Pouch)'),
  FlagItem(4, '灵魂碎片 (Soul Shard)'),
  FlagItem(8, '皮革用品 (Leatherworking)'),
  FlagItem(16, '铭文袋 (Inscription)'),
  FlagItem(32, '草药袋 (Herb)'),
  FlagItem(64, '附魔袋 (Enchanting)'),
  FlagItem(128, '工程袋 (Engineering)'),
  FlagItem(256, '钥匙袋 (Key)'),
  FlagItem(512, '珠宝袋 (Jewelcrafting)'),
  FlagItem(1024, '矿石袋 (Mining)'),
  FlagItem(2048, '灵魂绑定 (Soulbound)'),
  FlagItem(4096, '宠物栏 (Pet)'),
  FlagItem(8192, '钱袋 (Money)'),
  FlagItem(16384, '任务物品 (Quest)'),
];

/// AllowableClass 职业标识选项 (AllowableClass)
const kAllowableClassOptions = [
  FlagItem(1, '战士 (Warrior)'),
  FlagItem(2, '圣骑士 (Paladin)'),
  FlagItem(4, '猎人 (Hunter)'),
  FlagItem(8, '盗贼 (Rogue)'),
  FlagItem(16, '牧师 (Priest)'),
  FlagItem(32, '死亡骑士 (Death Knight)'),
  FlagItem(64, '萨满 (Shaman)'),
  FlagItem(128, '法师 (Mage)'),
  FlagItem(256, '术士 (Warlock)'),
  FlagItem(1024, '德鲁伊 (Druid)'),
];

/// AllowableRace 种族标识选项 (AllowableRace)
const kAllowableRaceOptions = [
  FlagItem(1, '人类 (Human)'),
  FlagItem(2, '矮人 (Dwarf)'),
  FlagItem(4, '暗夜精灵 (Night Elf)'),
  FlagItem(8, '亡灵 (Undead)'),
  FlagItem(16, '牛头人 (Tauren)'),
  FlagItem(32, '巨魔 (Troll)'),
  FlagItem(64, '侏儒 (Gnome)'),
  FlagItem(128, '兽人 (Orc)'),
  FlagItem(512, '血精灵 (Blood Elf)'),
  FlagItem(1024, '德莱尼 (Draenei)'),
];

/// ScalingStatValue 缩放属性标识选项 (ScalingStatValue)
const kItemScalingStatValueOptions = [
  FlagItem(1, '肩膀SSD (Shoulder)'),
  FlagItem(2, '饰品SSD (Trinket)'),
  FlagItem(4, '单手武器SSD (One-Hand Weapon)'),
  FlagItem(8, '远程武器SSD (Ranged Weapon)'),
  FlagItem(16, '布甲肩膀护甲 (Cloth Shoulder)'),
  FlagItem(32, '皮甲肩膀护甲 (Leather Shoulder)'),
  FlagItem(64, '锁甲肩膀护甲 (Mail Shoulder)'),
  FlagItem(128, '板甲肩膀护甲 (Plate Shoulder)'),
  FlagItem(256, '单手武器伤害 (One-Hand DPS)'),
  FlagItem(512, '双手武器伤害 (Two-Hand DPS)'),
  FlagItem(1024, '单手法杖伤害 (One-Hand Caster DPS)'),
  FlagItem(2048, '双手法杖伤害 (Two-Hand Caster DPS)'),
  FlagItem(4096, '远程武器伤害 (Ranged DPS)'),
  FlagItem(8192, '魔杖伤害 (Wand DPS)'),
  FlagItem(16384, '法术加成 (Spell Power)'),
  FlagItem(32768, '野性加成 (Feral Attack Power)'),
  FlagItem(65536, '未知 (Unknown)'),
  FlagItem(131072, '3.3版本SSD (3.3 SSD)'),
  FlagItem(262144, '披风护甲 (Cloak Armor)'),
  FlagItem(524288, '布甲护甲 (Cloth Armor)'),
  FlagItem(1048576, '皮甲护甲 (Leather Armor)'),
  FlagItem(2097152, '锁甲护甲 (Mail Armor)'),
  FlagItem(4194304, '板甲护甲 (Plate Armor)'),
];
