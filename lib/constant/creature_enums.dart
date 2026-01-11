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

/// family 族群选项（用于猎人宠物等）
const kCreatureFamilyOptions = {
  0: '无 (None)',
  1: '狼 (Wolf)',
  2: '猫 (Cat)',
  3: '蜘蛛 (Spider)',
  4: '熊 (Bear)',
  5: '野猪 (Boar)',
  6: '鳄鱼 (Crocolisk)',
  7: '食腐鸟 (Carrion Bird)',
  8: '螃蟹 (Crab)',
  9: '猩猩 (Gorilla)',
  10: '马 (Horse)',
  11: '迅猛龙 (Raptor)',
  12: '陆行鸟 (Tallstrider)',
  15: '地狱猎犬 (Felhunter)',
  16: '虚空行者 (Voidwalker)',
  17: '魅魔 (Succubus)',
  19: '末日守卫 (Doomguard)',
  20: '蝎子 (Scorpid)',
  21: '乌龟 (Turtle)',
  23: '小鬼 (Imp)',
  24: '蝙蝠 (Bat)',
  25: '鬣狗 (Hyena)',
  26: '猛禽 (Bird of Prey)',
  27: '风蛇 (Wind Serpent)',
  28: '遥控 (Remote Control)',
  29: '恶魔卫士 (Felguard)',
  30: '龙鹰 (Dragonhawk)',
  31: '劫掠者 (Ravager)',
  32: '曲光掠夺者 (Warp Stalker)',
  33: '孢子蝠 (Sporebat)',
  34: '虚空鳐 (Nether Ray)',
  35: '蛇 (Serpent)',
  37: '蛾 (Moth)',
  38: '奇美拉 (Chimaera)',
  39: '魔暴龙 (Devilsaur)',
  40: '食尸鬼 (Ghoul)',
  41: '异种蝎 (Silithid)',
  42: '蠕虫 (Worm)',
  43: '犀牛 (Rhino)',
  44: '黄蜂 (Wasp)',
  45: '熔火犬 (Core Hound)',
  46: '灵魂兽 (Spirit Beast)',
};

/// resistance school 抗性类型选项
const kResistanceSchoolOptions = {
  0: '物理 (Physical)',
  1: '神圣 (Holy)',
  2: '火焰 (Fire)',
  3: '自然 (Nature)',
  4: '冰霜 (Frost)',
  5: '暗影 (Shadow)',
  6: '奥术 (Arcane)',
};

/// trainer_type 训练师类型选项
const kTrainerTypeOptions = {
  0: '职业训练师 (Class Trainer)',
  1: '坐骑训练师 (Mount Trainer)',
  2: '商业技能训练师 (Tradeskill Trainer)',
  3: '宠物训练师 (Pet Trainer)',
};

/// trainer_class 训练师职业选项
const kTrainerClassOptions = {
  0: '无 (None)',
  1: '战士 (Warrior)',
  2: '圣骑士 (Paladin)',
  3: '猎人 (Hunter)',
  4: '盗贼 (Rogue)',
  5: '牧师 (Priest)',
  6: '死亡骑士 (Death Knight)',
  7: '萨满祭司 (Shaman)',
  8: '法师 (Mage)',
  9: '术士 (Warlock)',
  11: '德鲁伊 (Druid)',
};

/// trainer_race 训练师种族选项
const kTrainerRaceOptions = {
  0: '无 (None)',
  1: '人类 (Human)',
  2: '兽人 (Orc)',
  3: '矮人 (Dwarf)',
  4: '暗夜精灵 (Night Elf)',
  5: '亡灵 (Undead)',
  6: '牛头人 (Tauren)',
  7: '侏儒 (Gnome)',
  8: '巨魔 (Troll)',
  10: '血精灵 (Blood Elf)',
  11: '德莱尼 (Draenei)',
};

/// MaxStanding 最高声望选项
const kMaxStandingOptions = {
  0: '仇恨 (Hated)',
  1: '敌对 (Hostile)',
  2: '冷淡 (Unfriendly)',
  3: '中立 (Neutral)',
  4: '友善 (Friendly)',
  5: '尊敬 (Honored)',
  6: '崇敬 (Revered)',
  7: '崇拜 (Exalted)',
};
