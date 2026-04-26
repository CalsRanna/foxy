// Item Template 标志位常量定义
// 数据来源：AzerothCore SharedDefines.h, ItemDefines.h

import 'package:foxy/constant/creature_flags.dart';

/// Item Flags 物品标识选项 (flags)
const kItemFlagOptions = [
  FlagItem(1, '未知'),
  FlagItem(2, '魔法制造'),
  FlagItem(4, '可打开的/物品掉落'),
  FlagItem(8, '英雄等级'),
  FlagItem(16, '废弃物品'),
  FlagItem(32, '无法摧毁'),
  FlagItem(64, '未知'),
  FlagItem(128, '无冷却'),
  FlagItem(256, '未知'),
  FlagItem(512, '包裹'),
  FlagItem(1024, '未知'),
  FlagItem(2048, '部分掉落'),
  FlagItem(4096, '可退还'),
  FlagItem(8192, '登记表'),
  FlagItem(16384, '未知(可读物品)'),
  FlagItem(32768, '未知'),
  FlagItem(65536, '未知'),
  FlagItem(131072, '未知'),
  FlagItem(262144, '可勘探物品/选矿掉落'),
  FlagItem(524288, '装备唯一'),
  FlagItem(1048576, '未知'),
  FlagItem(2097152, '竞技场可用'),
  FlagItem(4194304, '异常'),
  FlagItem(8388608, '变形时可用'),
  FlagItem(16777216, '未知'),
  FlagItem(33554432, '职业配方'),
  FlagItem(67108864, '竞技场不可用'),
  FlagItem(134217728, '账号绑定'),
  FlagItem(268435456, '在触发标志时使用法术'),
  FlagItem(536870912, '有效/研磨掉落'),
  FlagItem(1073741824, '未知'),
  FlagItem(2147483648, '拾取绑定可交易'),
];

/// Item FlagsExtra 额外标识选项 (flagsExtra)
const kItemFlagsExtraOptions = [
  FlagItem(1, '部落'),
  FlagItem(2, '联盟'),
  FlagItem(4, '附带金钱'),
  FlagItem(8, '未知'),
  FlagItem(16, '未知'),
  FlagItem(32, '未知'),
  FlagItem(64, '未知'),
  FlagItem(128, '未知'),
  FlagItem(256, '不用roll点'),
  FlagItem(512, '取消roll点'),
  FlagItem(1024, '未知'),
  FlagItem(2048, '未知'),
  FlagItem(4096, '未知'),
  FlagItem(8192, '未知'),
  FlagItem(16384, '普通标价'),
  FlagItem(32768, '未知'),
  FlagItem(65536, '未知'),
  FlagItem(131072, '账号绑定'),
  FlagItem(262144, '未知'),
  FlagItem(524288, '未知'),
  FlagItem(1048576, '未知'),
  FlagItem(2097152, '不能被变形'),
  FlagItem(4194304, '不能变形'),
  FlagItem(8388608, '可以变形'),
];

/// Item flagsCustom 自定义标识选项 (flagsCustom)
const kItemFlagsCustomOptions = [
  FlagItem(1, '玩家下线也计时'),
  FlagItem(2, '掉落时不检测任务状态'),
  FlagItem(4, '点贪婪前遵守掉落规则'),
];

/// BagFamily 背包类别标识选项 (BagFamily)
const kItemBagFamilyOptions = [
  FlagItem(1, '箭袋'),
  FlagItem(2, '弹药袋'),
  FlagItem(4, '灵魂碎片'),
  FlagItem(8, '皮革用品'),
  FlagItem(16, '铭文袋'),
  FlagItem(32, '草药袋'),
  FlagItem(64, '附魔袋'),
  FlagItem(128, '工程袋'),
  FlagItem(256, '钥匙袋'),
  FlagItem(512, '珠宝袋'),
  FlagItem(1024, '矿石袋'),
  FlagItem(2048, '灵魂绑定'),
  FlagItem(4096, '宠物栏'),
  FlagItem(8192, '钱袋'),
  FlagItem(16384, '任务物品'),
];

/// AllowableClass 职业标识选项 (AllowableClass)
const kAllowableClassOptions = [
  FlagItem(1, '战士'),
  FlagItem(2, '圣骑士'),
  FlagItem(4, '猎人'),
  FlagItem(8, '盗贼'),
  FlagItem(16, '牧师'),
  FlagItem(32, '死亡骑士'),
  FlagItem(64, '萨满'),
  FlagItem(128, '法师'),
  FlagItem(256, '术士'),
  FlagItem(1024, '德鲁伊'),
];

/// AllowableRace 种族标识选项 (AllowableRace)
const kAllowableRaceOptions = [
  FlagItem(1, '人类'),
  FlagItem(2, '矮人'),
  FlagItem(4, '暗夜精灵'),
  FlagItem(8, '亡灵'),
  FlagItem(16, '牛头人'),
  FlagItem(32, '巨魔'),
  FlagItem(64, '侏儒'),
  FlagItem(128, '熊人'),
  FlagItem(512, '血精灵'),
  FlagItem(1024, '德莱尼'),
];

/// ScalingStatValue 缩放属性标识选项 (ScalingStatValue)
const kItemScalingStatValueOptions = [
  FlagItem(1, '肩膀SSD'),
  FlagItem(2, '饰品SSD'),
  FlagItem(4, '单手武器SSD'),
  FlagItem(8, '3.1版本SSD'),
  FlagItem(16, '远程武器SSD'),
  FlagItem(32, '布甲肩膀护甲'),
  FlagItem(64, '皮甲肩膀护甲'),
  FlagItem(128, '锁甲肩膀护甲'),
  FlagItem(256, '板甲肩膀护甲'),
  FlagItem(512, '单手武器伤害'),
  FlagItem(1024, '双手武器伤害'),
  FlagItem(2048, '单手法杖伤害'),
  FlagItem(4096, '双手法杖伤害'),
  FlagItem(8192, '远程武器伤害'),
  FlagItem(16384, '魔杖伤害'),
  FlagItem(32768, '法术加成'),
  FlagItem(65536, '野性加成'),
  FlagItem(131072, '未知'),
  FlagItem(262144, '3.3版本SSD'),
  FlagItem(524288, '披风护甲'),
  FlagItem(1048576, '布甲护甲'),
  FlagItem(2097152, '皮甲护甲'),
  FlagItem(4194304, '锁甲护甲'),
  FlagItem(8388608, '板甲护甲'),
];
