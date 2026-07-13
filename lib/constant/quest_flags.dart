import 'package:foxy/constant/creature_flags.dart';

const kQuestFlagsAllowedMask = 0x000FFFFF;

/// AzerothCore `QuestFlags` for the 3.3.5a client.
const kQuestFlagOptions = [
  FlagItem(0x00000001, '保持存活（未使用）'),
  FlagItem(0x00000002, '队伍接受（未使用）'),
  FlagItem(0x00000004, '探索（未使用）'),
  FlagItem(0x00000008, '可共享'),
  FlagItem(0x00000010, '有条件（未使用）'),
  FlagItem(0x00000020, '隐藏奖励 POI（未使用）'),
  FlagItem(0x00000040, '团队（未使用）'),
  FlagItem(0x00000080, 'TBC（未使用）'),
  FlagItem(0x00000100, '满级经验不转金币（未使用）'),
  FlagItem(0x00000200, '隐藏奖励'),
  FlagItem(0x00000400, '追踪任务'),
  FlagItem(0x00000800, '废弃声望（未使用）'),
  FlagItem(0x00001000, '日常'),
  FlagItem(0x00002000, '强制 PvP'),
  FlagItem(0x00004000, '不可用'),
  FlagItem(0x00008000, '每周'),
  FlagItem(0x00010000, '自动完成'),
  FlagItem(0x00020000, '追踪器显示物品'),
  FlagItem(0x00040000, '目标文本作为完成文本'),
  FlagItem(0x00080000, '自动接受'),
];

const kQuestSpecialFlagsAllowedMask = 0x000001FF;

/// Only the bits included in AzerothCore `QUEST_SPECIAL_FLAGS_DB_ALLOWED`.
const kQuestSpecialFlagOptions = [
  FlagItem(0x0001, '可重复'),
  FlagItem(0x0002, '探索或事件'),
  FlagItem(0x0004, '自动接受'),
  FlagItem(0x0008, '地下城查找器任务'),
  FlagItem(0x0010, '每月'),
  FlagItem(0x0020, '施法目标'),
  FlagItem(0x0040, '禁止声望溢出'),
  FlagItem(0x0080, '任意状态可失败'),
  FlagItem(0x0100, '不计入博学者'),
];
