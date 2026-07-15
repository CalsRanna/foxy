import 'package:foxy/constant/flag_item.dart';

/// AzerothCore DBCEnums.h::AreaTeams used by AreaTableEntry::team.
const kAreaTeamOptions = {0: '无阵营', 2: '联盟', 4: '部落', 6: '双方'};

/// AzerothCore DBCEnums.h::AreaFlags for the 3.3.5a AreaTable DBC.
const kAreaFlagOptions = [
  FlagItem(0x00000001, '未知 0'),
  FlagItem(0x00000002, '未知 1'),
  FlagItem(0x00000004, '未知 2'),
  FlagItem(0x00000008, '附属主城'),
  FlagItem(0x00000010, '未知 3'),
  FlagItem(0x00000020, '附属主城 2'),
  FlagItem(0x00000040, '允许决斗'),
  FlagItem(0x00000080, '竞技场'),
  FlagItem(0x00000100, '主城'),
  FlagItem(0x00000200, '城市'),
  FlagItem(0x00000400, '外域'),
  FlagItem(0x00000800, '避难所'),
  FlagItem(0x00001000, '需要飞行'),
  FlagItem(0x00002000, '未使用 1'),
  FlagItem(0x00004000, '外域 2'),
  FlagItem(0x00008000, '户外 PvP'),
  FlagItem(0x00010000, '竞技场副本'),
  FlagItem(0x00020000, '未使用 2'),
  FlagItem(0x00040000, '争夺区域'),
  FlagItem(0x00080000, '未知 4'),
  FlagItem(0x00100000, '低等级区域'),
  FlagItem(0x00200000, '城镇'),
  FlagItem(0x00400000, '部落休息区'),
  FlagItem(0x00800000, '联盟休息区'),
  FlagItem(0x01000000, '冬拥湖'),
  FlagItem(0x02000000, '室内'),
  FlagItem(0x04000000, '室外'),
  FlagItem(0x08000000, '冬拥湖 2'),
  FlagItem(0x20000000, '禁飞区'),
  FlagItem(0x40000000, '客户端标志（AzerothCore 未命名）'),
];

const kAreaTableKnownFlagMask = 0x6FFFFFFF;
const kAreaTableMaxAreaBit = 4095;
