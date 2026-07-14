// Condition Source Type 枚举常量定义
// 数据来源：AzerothCore ConditionMgr.h - ConditionSourceType

/// SourceTypeOrReferenceId 来源类型标签
/// 非负值对应来源类型；负值表示引用另一组条件
const kConditionSourceTypeLabels = <int, String>{
  1: '生物掉落', // CONDITION_SOURCE_TYPE_CREATURE_LOOT_TEMPLATE
  2: '分解掉落', // CONDITION_SOURCE_TYPE_DISENCHANT_LOOT_TEMPLATE
  3: '钓鱼掉落', // CONDITION_SOURCE_TYPE_FISHING_LOOT_TEMPLATE
  4: '游戏对象掉落', // CONDITION_SOURCE_TYPE_GAMEOBJECT_LOOT_TEMPLATE
  5: '物品掉落', // CONDITION_SOURCE_TYPE_ITEM_LOOT_TEMPLATE
  6: '邮件掉落', // CONDITION_SOURCE_TYPE_MAIL_LOOT_TEMPLATE
  7: '研磨掉落', // CONDITION_SOURCE_TYPE_MILLING_LOOT_TEMPLATE
  8: '偷窃掉落', // CONDITION_SOURCE_TYPE_PICKPOCKETING_LOOT_TEMPLATE
  9: '勘探掉落', // CONDITION_SOURCE_TYPE_PROSPECTING_LOOT_TEMPLATE
  10: '引用掉落', // CONDITION_SOURCE_TYPE_REFERENCE_LOOT_TEMPLATE
  11: '剥皮掉落', // CONDITION_SOURCE_TYPE_SKINNING_LOOT_TEMPLATE
  12: '法术掉落', // CONDITION_SOURCE_TYPE_SPELL_LOOT_TEMPLATE
  13: '法术隐式目标', // CONDITION_SOURCE_TYPE_SPELL_IMPLICIT_TARGET
  14: '对话菜单', // CONDITION_SOURCE_TYPE_GOSSIP_MENU
  15: '对话选项', // CONDITION_SOURCE_TYPE_GOSSIP_MENU_OPTION
  16: '生物载具', // CONDITION_SOURCE_TYPE_CREATURE_TEMPLATE_VEHICLE
  17: '法术', // CONDITION_SOURCE_TYPE_SPELL
  18: '法术点击', // CONDITION_SOURCE_TYPE_SPELL_CLICK_EVENT
  19: '任务可用', // CONDITION_SOURCE_TYPE_QUEST_AVAILABLE
  20: '对话问候', // CONDITION_SOURCE_TYPE_GOSSIP_HELLO
  21: '载具法术', // CONDITION_SOURCE_TYPE_VEHICLE_SPELL
  22: '智能事件', // CONDITION_SOURCE_TYPE_SMART_EVENT
  23: 'NPC商人', // CONDITION_SOURCE_TYPE_NPC_VENDOR
  24: '法术触发', // CONDITION_SOURCE_TYPE_SPELL_PROC
  28: '玩家掉落', // CONDITION_SOURCE_TYPE_PLAYER_LOOT_TEMPLATE
  29: '生物重生', // CONDITION_SOURCE_TYPE_CREATURE_RESPAWN
  30: '对象可见性', // CONDITION_SOURCE_TYPE_OBJECT_VISIBILITY
};

const kConditionSourceTypesWithGroup = <int>{
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  18,
  20,
  21,
  22,
  23,
  28,
  30,
};

const kConditionSourceTypesWithSourceId = <int>{22, 30};

int conditionTargetCount(int sourceTypeOrReferenceId) {
  if (sourceTypeOrReferenceId == 22) return 3;
  if (const {
    13,
    14,
    15,
    16,
    17,
    18,
    20,
    21,
    23,
    24,
    30,
  }.contains(sourceTypeOrReferenceId)) {
    return 2;
  }
  return 1;
}
