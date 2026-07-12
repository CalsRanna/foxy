// Condition Value1/2/3 语义配置
// 数据来源：AzerothCore ConditionMgr.h - ConditionTypes 注释
// 不同 ConditionType 下 Value1/2/3 含义不同，此表提供动态 label 与 Value1 选择器类型

/// 参数1的选择器类型（仅在已有 FoxyEntityPickerDelegate 的类型上启用）
enum ConditionValue1Picker {
  none, // 纯数字输入
  quest, // 任务选择器
  spell, // 法术选择器
  item, // 物品选择器
  map, // 地图选择器
  area, // 区域选择器
  faction, // 阵营选择器
  title, // 称号选择器
  creature, // 生物选择器
}

class ConditionValueConfig {
  final String label1;
  final String label2;
  final String label3;
  final ConditionValue1Picker value1Picker;

  const ConditionValueConfig({
    required this.label1,
    this.label2 = '',
    this.label3 = '',
    this.value1Picker = ConditionValue1Picker.none,
  });

  static const defaultValue = ConditionValueConfig(label1: '参数1');

  String get displayLabel2 => label2.isEmpty ? '参数2' : label2;
  String get displayLabel3 => label3.isEmpty ? '参数3' : label3;
}

/// ConditionTypeOrReference -> Value1/2/3 语义配置
/// 负值(引用)或未列出的类型使用 [ConditionValueConfig.defaultValue]
const kConditionValueConfigs = <int, ConditionValueConfig>{
  1: ConditionValueConfig(
    label1: '法术ID',
    label2: '效果索引',
    label3: '使用目标',
    value1Picker: ConditionValue1Picker.spell,
  ), // Aura
  2: ConditionValueConfig(
    label1: '物品ID',
    label2: '数量',
    label3: '包含银行',
    value1Picker: ConditionValue1Picker.item,
  ), // Item
  3: ConditionValueConfig(
    label1: '物品ID',
    value1Picker: ConditionValue1Picker.item,
  ), // ItemEquipped
  4: ConditionValueConfig(
    label1: '区域ID',
    value1Picker: ConditionValue1Picker.area,
  ), // ZoneID
  5: ConditionValueConfig(
    label1: '阵营ID',
    label2: '声望掩码',
    value1Picker: ConditionValue1Picker.faction,
  ), // ReputationRank
  6: ConditionValueConfig(label1: '阵营'), // Team (469联盟/67部落)
  7: ConditionValueConfig(label1: '技能ID', label2: '技能值'), // Skill (无 delegate)
  8: ConditionValueConfig(
    label1: '任务ID',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestRewarded
  9: ConditionValueConfig(
    label1: '任务ID',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestTaken
  10: ConditionValueConfig(label1: '醉酒状态'), // DrunkenState
  11: ConditionValueConfig(label1: '索引', label2: '数值'), // WorldState
  12: ConditionValueConfig(label1: '活动ID'), // ActiveEvent
  13: ConditionValueConfig(
    label1: '条目',
    label2: '数据',
    label3: '类型',
  ), // InstanceInfo
  14: ConditionValueConfig(
    label1: '任务ID',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestNone
  15: ConditionValueConfig(label1: '职业'), // Class
  16: ConditionValueConfig(label1: '种族'), // Race
  17: ConditionValueConfig(label1: '成就ID'), // Achievement (无 delegate)
  18: ConditionValueConfig(
    label1: '称号ID',
    value1Picker: ConditionValue1Picker.title,
  ), // Title
  19: ConditionValueConfig(label1: '生成掩码'), // SpawnMask
  20: ConditionValueConfig(label1: '性别'), // Gender
  21: ConditionValueConfig(label1: '单位状态'), // UnitState
  22: ConditionValueConfig(
    label1: '地图ID',
    value1Picker: ConditionValue1Picker.map,
  ), // MapID
  23: ConditionValueConfig(
    label1: '区域ID',
    value1Picker: ConditionValue1Picker.area,
  ), // AreaID
  24: ConditionValueConfig(label1: '生物类型'), // CreatureType
  25: ConditionValueConfig(
    label1: '法术ID',
    value1Picker: ConditionValue1Picker.spell,
  ), // Spell
  26: ConditionValueConfig(label1: '相位掩码'), // PhaseMask
  27: ConditionValueConfig(label1: '等级', label2: '比较类型'), // Level
  28: ConditionValueConfig(
    label1: '任务ID',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestComplete
  29: ConditionValueConfig(
    label1: '生物ID',
    label2: '距离',
    label3: '死亡',
    value1Picker: ConditionValue1Picker.creature,
  ), // NearCreature
  30: ConditionValueConfig(
    label1: '对象ID',
    label2: '距离',
    label3: '对象状态',
  ), // NearGameobject (无 delegate)
  31: ConditionValueConfig(
    label1: '类型ID',
    label2: '条目',
    label3: 'GUID',
  ), // ObjectEntryGuid
  32: ConditionValueConfig(label1: '类型掩码'), // TypeMask
  33: ConditionValueConfig(label1: '条件目标', label2: '关系类型'), // RelationTo
  34: ConditionValueConfig(label1: '条件目标', label2: '声望掩码'), // ReactionTo
  35: ConditionValueConfig(
    label1: '条件目标',
    label2: '距离',
    label3: '比较类型',
  ), // DistanceTo
  37: ConditionValueConfig(label1: '生命值', label2: '比较类型'), // HpVal
  38: ConditionValueConfig(label1: '生命值百分比', label2: '比较类型'), // HpPct
  39: ConditionValueConfig(label1: '成就ID'), // RealmAchievement (无 delegate)
  42: ConditionValueConfig(label1: '状态类型', label2: '状态'), // StandState
  43: ConditionValueConfig(
    label1: '任务ID',
    value1Picker: ConditionValue1Picker.quest,
  ), // DailyQuestDone
  45: ConditionValueConfig(label1: '宠物类型掩码'), // PetType
  47: ConditionValueConfig(
    label1: '任务ID',
    label2: '状态掩码',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestState
  48: ConditionValueConfig(
    label1: '任务ID',
    label2: '目标索引',
    label3: '目标数量',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestObjectiveProgress
  49: ConditionValueConfig(label1: '难度'), // DifficultyId
  101: ConditionValueConfig(
    label1: '任务ID',
    value1Picker: ConditionValue1Picker.quest,
  ), // QuestSatisfyExclusive
  102: ConditionValueConfig(label1: '光环类型'), // HasAuraType
  104: ConditionValueConfig(label1: '数据ID', label2: '数值'), // AiData
  105: ConditionValueConfig(
    label1: '检查难度',
    label2: '难度',
  ), // PlayerQueuedRandomDungeon
};

ConditionValueConfig conditionValueConfig(int type) =>
    kConditionValueConfigs[type] ?? ConditionValueConfig.defaultValue;
