import 'package:foxy/constant/flag_item.dart';

abstract final class PlayerCreateInfoConstants {
  /// `playercreateinfo.race` uses ChrRaces.dbc IDs accepted by ObjectMgr.
  static const playerRaceOptions = {
    1: '人类',
    2: '兽人',
    3: '矮人',
    4: '暗夜精灵',
    5: '亡灵',
    6: '牛头人',
    7: '侏儒',
    8: '巨魔',
    10: '血精灵',
    11: '德莱尼',
  };

  /// Race masks shared by the three mask-based player-create tables and
  /// SkillLineAbility.dbc.
  static const playerCreateRaceMaskFlags = [
    FlagItem(1, '人类'),
    FlagItem(2, '兽人'),
    FlagItem(4, '矮人'),
    FlagItem(8, '暗夜精灵'),
    FlagItem(16, '亡灵'),
    FlagItem(32, '牛头人'),
    FlagItem(64, '侏儒'),
    FlagItem(128, '巨魔'),
    FlagItem(512, '血精灵'),
    FlagItem(1024, '德莱尼'),
  ];
  static const playerCreatePlayableRaceMask = 1791;
  static const playerCreatePlayableClassMask = 1535;

  /// Class masks shared by the three mask-based player-create tables and
  /// SkillLineAbility.dbc.
  static const playerCreateClassMaskFlags = [
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

  /// `playercreateinfo.class` uses ChrClasses.dbc IDs accepted by ObjectMgr.
  static const playerClassOptions = {
    1: '战士',
    2: '圣骑士',
    3: '猎人',
    4: '盗贼',
    5: '牧师',
    6: '死亡骑士',
    7: '萨满',
    8: '法师',
    9: '术士',
    11: '德鲁伊',
  };

  /// Player.h::ActionButtonType. This is not the pet ActiveStates enum.
  static const playerActionButtonTypeOptions = {
    0x00: '法术',
    0x01: '点击动作',
    0x20: '装备方案',
    0x40: '宏',
    0x41: '角色宏',
    0x80: '物品',
  };

  static int classBit(int playerClass) => 1 << (playerClass - 1);

  static int raceBit(int race) => 1 << (race - 1);
}
