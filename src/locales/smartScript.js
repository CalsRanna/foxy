const sourceTypes = [
  "生物",
  "物体",
  "区域触发器",
  "",
  "",
  "",
  "",
  "",
  "",
  "定时动作列表",
];

const eventTypes = [
  "进入战斗",
  "脱离战斗",
  "血量百分比",
  "法力值百分比",
  "生物仇恨",
  "生物击杀",
  "生物死亡",
  "生物闪避攻击",
  "生物或物体法术击中",
  "目标距离",
  "生物脱离战斗的距离",
  "生物或物体刷新",
  "目标血量百分比",
  "目标施法",
  "友方血量赤字",
  "友方？",
  "友方失去BUFF",
  "生物或物体召唤其他单位",
  "目标法力值百分比",
  "目标接受任务",
  "目标接收任务奖励",
  "生物抵达终点",
  "接收动作",
  "生物拥有光环",
  "目标被技能增强",
  "重置（战斗过后，刷新或再次刷新）",
  "距离内目标进入战斗",
  "乘客公告板",
  "乘客移除",
  "生物被魅惑",
  "目标被魅惑",
  "目标技能击中",
  "生物受伤害",
  "目标受伤害",
  "移动信息",
  "被召唤单位消失",
  "尸体移除",
  "初始AI",
  "生物或物体数据设置",
  "生物路径点开始",
  "生物路径点到达",
  "增加玩家传送（废弃）",
  "增加生物传送（废弃）",
  "移除玩家传送（废弃）",
  "传送调整（废弃）",
  "玩家进入副本（废弃）",
  "区域触发器触发",
  "目标接受任务（废弃）",
  "任务目标完成（废弃）",
  "任务完成（废弃）",
  "任务被奖励（废弃）",
  "任务失败（废弃）",
  "文字覆盖",
  "生物接受治疗",
  "生物刚被召唤",
  "生物路径行动暂停",
  "生物路径行动恢复",
  "生物路径行动停止",
  "生物路径行动结束",
  "定时事件触发",
  "更新",
  "把单个的事件链接成事件链",
  "对话选项选择",
  "刚刚创建",
  "右键点击拥有对话框的生物或物体",
  "跟随完成",
  "傀儡效果",
  "生物在目标身后",
  "游戏事件开始",
  "游戏事件结束",
  "状态改变",
  "事件通知",
  "行动完成",
  "技能点击",
  "友方血量百分比",
  "生物进入距离范围",
  "物体进入距离范围",
  "计数器设置",
];

const eventPhaseMasks = [
  {
    index: 0,
    flag: 1,
    name: "SMART_EVENT_PHASE_1",
    comment: "Phase 1 only.",
  },
  {
    index: 1,
    flag: 2,
    name: "SMART_EVENT_PHASE_2",
    comment: "Phase 2 only.",
  },
  {
    index: 2,
    flag: 4,
    name: "SMART_EVENT_PHASE_3",
    comment: "Phase 3 only.",
  },
  {
    index: 3,
    flag: 8,
    name: "SMART_EVENT_PHASE_4",
    comment: "Phase 4 only.",
  },
  {
    index: 4,
    flag: 16,
    name: "SMART_EVENT_PHASE_5",
    comment: "Phase 5 only.",
  },
  {
    index: 5,
    flag: 32,
    name: "SMART_EVENT_PHASE_6",
    comment: "Phase 6 only.",
  },
  {
    index: 6,
    flag: 64,
    name: "SMART_EVENT_PHASE_7",
    comment: "Phase 7 only.",
  },
  {
    index: 7,
    flag: 128,
    name: "SMART_EVENT_PHASE_8",
    comment: "Phase 8 only.",
  },
  {
    index: 8,
    flag: 256,
    name: "SMART_EVENT_PHASE_9",
    comment: "Phase 9 only.",
  },
  {
    index: 9,
    flag: 512,
    name: "SMART_EVENT_PHASE_10",
    comment: "Phase 10 only.",
  },
  {
    index: 10,
    flag: 1024,
    name: "SMART_EVENT_PHASE_11",
    comment: "Phase 11 only.",
  },
  {
    index: 11,
    flag: 2048,
    name: "SMART_EVENT_PHASE_12",
    comment: "Phase 12 only.",
  },
];

const eventFlags = [
  {
    index: 0,
    flag: 1,
    name: "不可重复",
    comment: "Event can not repeat",
  },
  {
    index: 1,
    flag: 2,
    name: "普通地下城",
    comment: "Event only occurs in normal dungeon",
  },
  {
    index: 2,
    flag: 4,
    name: "英雄地下城",
    comment: "Event only occurs in heroic dungeon",
  },
  {
    index: 3,
    flag: 8,
    name: "普通团队副本",
    comment: "Event only occurs in normal raid",
  },
  {
    index: 4,
    flag: 16,
    name: "英雄团队副本",
    comment: "Event only occurs in heroic raid",
  },
  {
    index: 5,
    flag: 32,
    name: "SMART_EVENT_FLAG_RESERVED_5",
    comment: "SMART_EVENT_FLAG_RESERVED_5",
  },
  {
    index: 6,
    flag: 64,
    name: "SMART_EVENT_FLAG_RESERVED_6",
    comment: "SMART_EVENT_FLAG_RESERVED_6",
  },
  {
    index: 7,
    flag: 128,
    name: "调试专用",
    comment: "Event only occurs in debug build",
  },
  {
    index: 8,
    flag: 256,
    name: "不会重置",
    comment: "Event will not reset in SmartScript::OnReset()",
  },
];

const eventParams = [
  [
    { label: "InitialMin", field: "event_param1", type: "el-input-number" },
    { label: "InitialMax", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_UPDATE_IC
  [
    { label: "InitialMin", field: "event_param1", type: "el-input-number" },
    { label: "InitialMax", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_UPDATE_OOC
  [
    { label: "HPMinPct", field: "event_param1", type: "el-input-number" },
    { label: "HPMaxPct", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_HEALTH_PCT
  [
    { label: "ManaMinPct", field: "event_param1", type: "el-input-number" },
    { label: "ManaMaxPct", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_MANA_PCT
  [], // SMART_EVENT_AGGRO
  [
    { label: "CooldownMin", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param2", type: "el-input-number" },
    { label: "Player only", field: "event_param3", type: "el-switch" },
    { label: "生物编号", field: "event_param4", type: "el-input" },
  ], // SMART_EVENT_KILL
  [], // SMART_EVENT_DEATH
  [], // SMART_EVENT_EVADE
  [
    { label: "技能", field: "event_param1", type: "spell-selector" },
    { label: "类型", field: "event_param2", type: "el-input" },
    { label: "CooldownMin", field: "event_param3", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_SPELLHIT
  [
    { label: "MinDist", field: "event_param1", type: "el-input-number" },
    { label: "MaxDist", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_RANGE
  [
    { label: "NoHostile", field: "event_param1", type: "el-input-number" },
    { label: "MaxRange", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param3", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param4", type: "el-input-number" },
    { label: "Player Only", field: "event_param5", type: "el-switch" },
  ], // SMART_EVENT_OOC_LOS
  [
    { label: "type", field: "event_param1", type: "el-input-number" },
    { label: "MapId", field: "event_param2", type: "el-input-number" },
    { label: "ZoneId", field: "event_param3", type: "el-input-number" },
  ], // SMART_EVENT_RESPAWN
  [
    { label: "HPMinPct", field: "event_param1", type: "el-input-number" },
    { label: "HPMaxPct", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_TARGET_HEALTH_PCT
  [
    { label: "RepeatMin", field: "event_param1", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param2", type: "el-input-number" },
    { label: "法术技能", field: "event_param3", type: "spell-selector" },
  ], // SMART_EVENT_VICTIM_CASTING
  [
    { label: "HPDeficit", field: "event_param1", type: "el-input-number" },
    { label: "Radius", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_FRIENDLY_HEALTH
  [
    { label: "Radius", field: "event_param1", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param3", type: "el-input-number" },
  ], // SMART_EVENT_FRIENDLY_IS_CC
  [
    { label: "法术技能", field: "event_param1", type: "spell-selector" },
    { label: "Radius", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_FRIENDLY_MISSING_BUFF
  [
    { label: "CretureId", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param3", type: "el-input-number" },
  ], // SMART_EVENT_SUMMONED_UNIT
  [
    { label: "ManaMinPct", field: "event_param1", type: "el-input-number" },
    { label: "ManaMaxPct", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_TARGET_MANA_PCT
  [{ label: "QuestID", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_ACCEPTED_QUEST
  [{ label: "QuestID", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_REWARD_QUEST
  [], // SMART_EVENT_REACHED_HOME
  [
    { label: "EmoteId", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param3", type: "el-input-number" },
  ], // SMART_EVENT_RECEIVE_EMOTE
  [
    { label: "法术技能", field: "event_param1", type: "spell-selector" },
    { label: "Stacks", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_HAS_AURA
  [
    { label: "法术技能", field: "event_param1", type: "spell-selector" },
    { label: "Stacks", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_TARGET_BUFFED
  [], // SMART_EVENT_RESET
  [
    { label: "NoHostile", field: "event_param1", type: "el-input-number" },
    { label: "MaxRange", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param3", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param4", type: "el-input-number" },
    { label: "Player Only", field: "event_param5", type: "el-switch" },
  ], // SMART_EVENT_IC_LOS
  [
    { label: "CooldownMin", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_PASSENGER_BOARDED
  [
    { label: "CooldownMin", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_PASSENGER_REMOVED
  [], // SMART_EVENT_CHARMED
  [], // SMART_EVENT_CHARMED_TARGET
  [
    { label: "法术技能", field: "event_param1", type: "spell-selector" },
    { label: "School", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_SPELLHIT_TARGET
  [
    { label: "MinDmg", field: "event_param1", type: "el-input-number" },
    { label: "MaxDmg", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_DAMAGED
  [
    { label: "MinDmg", field: "event_param1", type: "el-input-number" },
    { label: "MaxDmg", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_DAMAGED_TARGET
  [
    { label: "MovementType", field: "event_param1", type: "el-input-number" },
    { label: "PointID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_MOVEMENTINFORM
  [
    { label: "Entry", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param3", type: "el-input-number" },
  ], // SMART_EVENT_SUMMON_DESPAWNED
  [], // SMART_EVENT_CORPSE_REMOVED
  [], // SMART_EVENT_AI_INIT
  [
    { label: "Field", field: "event_param1", type: "el-input-number" },
    { label: "Value", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param3", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_DATA_SET
  [
    { label: "PointId", field: "event_param1", type: "el-input-number" },
    { label: "pathID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_WAYPOINT_START
  [
    { label: "PointId", field: "event_param1", type: "el-input-number" },
    { label: "pathID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_WAYPOINT_REACHED
  [],
  [],
  [],
  [],
  [],
  [{ label: "TriggerId ", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_AREATRIGGER_ONTRIGGER
  [],
  [],
  [],
  [],
  [],
  [
    { label: "GroupID", field: "event_param1", type: "el-input-number" },
    { label: "CreatureID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_TEXT_OVER
  [
    { label: "MinHeal", field: "event_param1", type: "el-input-number" },
    { label: "MaxHeal", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param3", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_RECEIVE_HEAL
  [], // SMART_EVENT_JUST_SUMMONED
  [
    { label: "PointId", field: "event_param1", type: "el-input-number" },
    { label: "pathID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_WAYPOINT_PAUSED
  [
    { label: "PointId", field: "event_param1", type: "el-input-number" },
    { label: "pathID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_WAYPOINT_RESUMED
  [
    { label: "PointId", field: "event_param1", type: "el-input-number" },
    { label: "pathID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_WAYPOINT_STOPPED
  [
    { label: "PointId", field: "event_param1", type: "el-input-number" },
    { label: "pathID", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_WAYPOINT_ENDED
  [{ label: "Id", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_TIMED_EVENT_TRIGGERED
  [
    { label: "InitialMin", field: "event_param1", type: "el-input-number" },
    { label: "InitialMax", field: "event_param2", type: "el-input-number" },
    { label: "RepeatMin", field: "event_param3", type: "el-input-number" },
    { label: "RepeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_UPDATE
  [], // SMART_EVENT_LINK
  [
    { label: "对话编号", field: "event_param1", type: "gossip-menu-selector" },
    { label: "子选项编号", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_GOSSIP_SELECT
  [], // SMART_EVENT_JUST_CREATED
  [], // SMART_EVENT_GOSSIP_HELLO
  [], // SMART_EVENT_FOLLOW_COMPLETED
  [], // SMART_EVENT_UNUSED_66
  [
    { label: "CooldownMin", field: "event_param1", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param2", type: "el-input-number" },
  ], // SMART_EVENT_IS_BEHIND_TARGET
  [{ label: "eventEntry", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_GAME_EVENT_START
  [{ label: "eventEntry", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_GAME_EVENT_END
  [{ label: "State", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_GO_STATE_CHANGED
  [{ label: "EventId", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_GO_EVENT_INFORM
  [{ label: "EventId", field: "event_param1", type: "el-input-number" }], // SMART_EVENT_ACTION_DONE
  [], // SMART_EVENT_ON_SPELLCLICK
  [
    { label: "minHpPct", field: "event_param1", type: "el-input-number" },
    { label: "maxHpPct", field: "event_param2", type: "el-input-number" },
    { label: "repeatMin", field: "event_param3", type: "el-input-number" },
    { label: "repeatMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_FRIENDLY_HEALTH_PCT
  [
    { label: "guid", field: "event_param1", type: "el-input-number" },
    { label: "entry", field: "event_param2", type: "el-input-number" },
    { label: "distance", field: "event_param3", type: "el-input-number" },
    {
      label: "repeat interval",
      field: "event_param4",
      type: "el-input-number",
    },
  ], // SMART_EVENT_DISTANCE_CREATURE
  [
    { label: "guid", field: "event_param1", type: "el-input-number" },
    { label: "entry", field: "event_param2", type: "el-input-number" },
    { label: "distance", field: "event_param3", type: "el-input-number" },
    {
      label: "repeat interval",
      field: "event_param4",
      type: "el-input-number",
    },
  ], // SMART_EVENT_DISTANCE_GAMEOBJECT
  [
    { label: "counterID", field: "event_param1", type: "el-input-number" },
    { label: "value", field: "event_param2", type: "el-input-number" },
    { label: "CooldownMin", field: "event_param3", type: "el-input-number" },
    { label: "CooldownMax", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_COUNTER_SET 77
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [
    { label: "maxPlayers", field: "event_param1", type: "el-input-number" },
    { label: "Range", field: "event_param2", type: "el-input-number" },
    { label: "FirstCheck", field: "event_param3", type: "el-input-number" },
    { label: "RepeatCheck", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_NEAR_PLAYERS 101
  [
    { label: "maxPlayers", field: "event_param1", type: "el-input-number" },
    { label: "Range", field: "event_param2", type: "el-input-number" },
    { label: "FirstCheck", field: "event_param3", type: "el-input-number" },
    { label: "RepeatCheck", field: "event_param4", type: "el-input-number" },
  ], // SMART_EVENT_NEAR_PLAYERS_NEGATION
];

const actionTypes = [
  "无",
  "谈话",
  "设置阵营",
  "变形",
  "播放声音",
  "播放动作",
  "任务失败",
  "添加任务",
  "设置反应状态",
  "激活物体",
  "随机动作",
  "施法",
  "召唤生物",
  "单体仇恨百分比",
  "群体仇恨百分比",
  "区域探索持续发生",
  "未使用",
  "设置动作状态",
  "设置单位标识",
  "移除单位标识",
  "自动攻击",
  "运行移动战斗",
  "设置事件相位",
  "增加事件相位",
  "闪避",
  "逃跑",
  "群体事件发生",
  "被施法的生物或物体",
  "法术取消光环",
  "跟随",
  "随机相位",
  "随机相位距离",
  "重置物体",
  "召唤杀死的怪物",
  "设置副本数据",
  "设置副本数据64",
  "更新模板",
  "死亡",
  "设置进入战斗地区",
  "求助",
  "设置护套",
  "强制消失",
  "设置无敌血量等级",
  "骑上坐骑",
  "设置相位标识",
  "设置数据",
  "向前移动",
  "设置可见",
  "激活",
  "开始攻击",
  "召唤物体",
  "杀死单位",
  "激活交通工具",
  "开始寻路",
  "寻路暂停",
  "停止寻路",
  "添加物品",
  "移除物品",
  "安装AI模板",
  "设置为跑步状态",
  "设置为飞行状态",
  "设置为游泳状态",
  "传送",
  "设置计数器",
  "存储目标列表",
  "恢复寻路",
  "设置朝向",
  "创建定时事件",
  "播放影片",
  "移动到位置",
  "重刷新目标",
  "装备",
  "关闭对话框",
  "触发定时事件",
  "移除定时事件",
  "添加光环",
  "覆盖脚本基础目标",
  "重置脚本基础目标",
  "重置脚本",
  "远程攻击运动",
  "定时动作列表",
  "设置NPC标识",
  "添加NPC标识",
  "移除NPC标识",
  "简单对话",
  "调用者施法",
  "施法穿透",
  "调用随机定时动作列表",
  "调用随机定时远程动作列表",
  "随机移动",
  "设置单位字段",
  "移除单位字段",
  "打断法术",
  "自定义动画",
  "设置动态标识",
  "添加动态标识",
  "移除动态标识",
  "跳到位置点",
  "发送对话框",
  "设置掉落状态",
  "发送目标至目标",
  "设置家的位置",
  "设置血量回复",
  "设置根",
  "设置物体标识",
  "添加物体标识",
  "移除物体标识",
  "召唤生物群",
  "设置能量",
  "添加能量",
  "移除能量",
  "开始最近的路径点行动",
  "未知",
  "未知",
  "升起",
];

const actionParams = [
  [], // SMART_ACTION_NONE
  [
    { label: "GroupID", field: "action_param1", type: "el-input-number" },
    { label: "Duration", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_NONE
  [{ label: "阵营 ", field: "action_param1", type: "faction-selector" }], // SMART_ACTION_SET_FACTION
  [
    {
      label: "编号",
      field: "action_param1",
      type: "creature-template-selector",
    },
    { label: "modelidx", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL
  [
    { label: "SoundId", field: "action_param1", type: "el-input-number" },
    { label: "onlySelf", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_SOUND
  [{ label: "EmoteId", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_PLAY_EMOTE
  [{ label: "编号", field: "action_param1", type: "quest-template-selector" }], // SMART_ACTION_FAIL_QUEST
  [
    { label: "编号", field: "action_param1", type: "quest-template-selector" },
    { label: "directAdd ", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_OFFER_QUEST
  [{ label: "ReactState", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_REACT_STATE
  [], // SMART_ACTION_ACTIVATE_GOBJECT
  [
    { label: "EmoteId1", field: "action_param1", type: "el-input-number" },
    { label: "EmoteId2", field: "action_param2", type: "el-input-number" },
    { label: "EmoteId3", field: "action_param3", type: "el-input-number" },
    { label: "EmoteId4", field: "action_param4", type: "el-input-number" },
    { label: "EmoteId5", field: "action_param5", type: "el-input-number" },
    { label: "EmoteId6", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_RANDOM_EMOTE
  [
    { label: "法术技能", field: "action_param1", type: "spell-selector" },
    { label: "castFlags", field: "action_param2", type: "el-input-number" },
    { label: "limitTargets", field: "action_param3", type: "el-input-number" },
  ], // SMART_ACTION_CAST
  [
    {
      label: "编号",
      field: "action_param1",
      type: "creature-template-selector",
    },
    { label: "Summon type", field: "action_param2", type: "el-input-number" },
    { label: "duration", field: "action_param2", type: "el-input-number" },
    {
      label: "attackInvoker ",
      field: "action_param2",
      type: "el-input-number",
    },
    { label: "attackScriptOwner ", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_SUMMON_CREATURE
  [
    { label: "ThreatPctInc", field: "action_param1", type: "el-input-number" },
    { label: "ThreatPctDec", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_THREAT_SINGLE_PCT
  [
    { label: "ThreatPctInc", field: "action_param1", type: "el-input-number" },
    { label: "ThreatPctDec", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_THREAT_ALL_PCT
  [{ label: "任务", field: "action_param1", type: "quest-template-selector" }], // SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS
  [], // SMART_ACTION_RESERVED_16
  [{ label: "EmoteId", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_EMOTE_STATE
  [
    { label: "Param1", field: "action_param1", type: "el-input-number" },
    { label: "type", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_SET_UNIT_FLAG
  [
    { label: "Param1", field: "action_param1", type: "el-input-number" },
    { label: "type", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_REMOVE_UNIT_FLAG
  [
    {
      label: "AllowAttackState",
      field: "action_param1",
      type: "el-input-number",
    },
  ], // SMART_ACTION_AUTO_ATTACK
  [
    {
      label: "AllowCombatMovement",
      field: "action_param1",
      type: "el-input-number",
    },
  ], // SMART_ACTION_ALLOW_COMBAT_MOVEMENT
  [
    {
      label: "event_phase_mask",
      field: "action_param1",
      type: "el-input-number",
    },
  ], // SMART_ACTION_SET_EVENT_PHASE
  [
    { label: "Increment", field: "action_param1", type: "el-input-number" },
    { label: "Decrement", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_INC_EVENT_PHASE
  [], // SMART_ACTION_EVADE
  [{ label: "FleeText", field: "action_param1", type: "el-switch" }], // SMART_ACTION_FLEE_FOR_ASSIST
  [{ label: "任务", field: "action_param1", type: "quest-template-selector" }], // SMART_ACTION_CALL_GROUPEVENTHAPPENS
  [], // SMART_ACTION_COMBAT_STOP
  [
    { label: "法术技能", field: "action_param1", type: "spell-selector" },
    { label: "充能次数", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_REMOVEAURASFROMSPELL
  [
    { label: "Distance", field: "action_param1", type: "el-input-number" },
    { label: "Angle", field: "action_param2", type: "el-input-number" },
    {
      label: "编号",
      field: "action_param3",
      type: "creature-template-selector",
    },
    { label: "credit", field: "action_param4", type: "el-input-number" },
    { label: "creditType", field: "action_param5", type: "el-input-number" },
  ], // SMART_ACTION_FOLLOW
  [
    {
      label: "event_phase_mask1",
      field: "action_param1",
      type: "el-input-number",
    },
    {
      label: "event_phase_mask2",
      field: "action_param2",
      type: "el-input-number",
    },
    {
      label: "event_phase_mask3",
      field: "action_param3",
      type: "el-input-number",
    },
    {
      label: "event_phase_mask4",
      field: "action_param4",
      type: "el-input-number",
    },
    {
      label: "event_phase_mask5",
      field: "action_param5",
      type: "el-input-number",
    },
    {
      label: "event_phase_mask6",
      field: "action_param6",
      type: "el-input-number",
    },
  ], // SMART_ACTION_RANDOM_PHASE
  [
    { label: "minimum", field: "action_param1", type: "el-input-number" },
    { label: "maximum", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_RANDOM_PHASE_RANGE
  [], // SMART_ACTION_RESET_GOBJECT
  [
    {
      label: "编号",
      field: "action_param1",
      type: "creature-template-selector",
    },
  ], // SMART_ACTION_CALL_KILLEDMONSTER
  [
    { label: "Field", field: "action_param1", type: "el-input-number" },
    { label: "Data", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_INST_DATA
  [{ label: "Field", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_INST_DATA64
  [
    {
      label: "编号",
      field: "action_param1",
      type: "creature-template-selector",
    },
    { label: "Update Level", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_UPDATE_TEMPLATE
  [], // SMART_ACTION_DIE
  [{ label: "Range", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_IN_COMBAT_WITH_ZONE
  [
    { label: "Radius", field: "action_param1", type: "el-input-number" },
    { label: "Call for help", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_CALL_FOR_HELP
  [{ label: "Sheath", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_SHEATH
  [{ label: "Despawn", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_FORCE_DESPAWN
  [
    { label: "flat hp", field: "action_param1", type: "el-input-number" },
    { label: "percent hp", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL
  [
    {
      label: "编号",
      field: "action_param1",
      type: "creature-template-selector",
    },
    { label: "modelidx", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL
  [{ label: "phaseMask", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_INGAME_PHASE_MASK
  [
    { label: "Field", field: "action_param1", type: "el-input-number" },
    { label: "Data", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_DATA
  [{ label: "distance", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_MOVE_FORWARD
  [{ label: "Visibility", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_VISIBILITY
  [{ label: "active", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_ACTIVE
  [], // SMART_ACTION_ATTACK_START
  [
    {
      label: "gameObjectEntry",
      field: "action_param1",
      type: "el-input-number",
    },
    { label: "De-spawn", field: "action_param2", type: "el-input-number" },
    { label: "targetSummon ", field: "action_param3", type: "el-switch" },
  ], // SMART_ACTION_SUMMON_GO
  [], // SMART_ACTION_KILL_UNIT
  [{ label: "TaxiID", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_ACTIVATE_TAXI
  [
    { label: "奔跑", field: "action_param1", type: "el-switch" },
    {
      label: "waypointsEntry",
      field: "action_param2",
      type: "el-input-number",
    },
    { label: "canRepeat", field: "action_param3", type: "el-input-number" },
    { label: "QuestID", field: "action_param4", type: "el-input-number" },
    { label: "despawntime", field: "action_param5", type: "el-input-number" },
    { label: "reactState", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_WP_START
  [{ label: "Time", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_WP_PAUSE
  [
    { label: "despawnTime", field: "action_param1", type: "el-input-number" },
    { label: "QuestID", field: "action_param2", type: "el-input-number" },
    { label: "fail", field: "action_param3", type: "el-switch" },
  ], // SMART_ACTION_WP_STOP
  [
    {
      label: "物品编号",
      field: "action_param1",
      type: "item-template-selector",
    },
    { label: "数量", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_ADD_ITEM
  [
    {
      label: "物品编号",
      field: "action_param1",
      type: "item-template-selector",
    },
    { label: "数量", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_REMOVE_ITEM
  [{ label: "TemplateID ", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_INSTALL_AI_TEMPLATE
  [{ label: "奔跑", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_RUN
  [
    { label: "飞行", field: "action_param1", type: "el-switch" },
    { label: "speed", field: "action_param2", type: "el-input-number" },
    { label: "禁用重力", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_SET_FLY
  [{ label: "游泳", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_SWIM
  [
    { label: "地图ID", field: "action_param1", type: "map-selector" },
    { label: "X坐标", field: "target_x", type: "el-input-number" },
    { label: "Y坐标", field: "target_y", type: "el-input-number" },
    { label: "Z坐标", field: "target_z", type: "el-input-number" },
    { label: "方向", field: "target_o", type: "el-input-number" },
  ], // SMART_ACTION_TELEPORT
  [
    { label: "counterID", field: "action_param1", type: "el-input-number" },
    { label: "value", field: "action_param2", type: "el-input-number" },
    { label: "reset ", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_SET_COUNTER
  [{ label: "varID", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_STORE_TARGET_LIST
  [], // SMART_ACTION_WP_RESUME
  [
    { label: "orientation", field: "action_param1", type: "el-input-number" },
    { label: "Random orientation", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_SET_ORIENTATION
  [
    { label: "id", field: "action_param1", type: "el-input-number" },
    { label: "InitialMin", field: "action_param2", type: "el-input-number" },
    { label: "InitialMax", field: "action_param3", type: "el-input-number" },
    { label: "RepeatMin", field: "action_param4", type: "el-input-number" },
    { label: "RepeatMax", field: "action_param5", type: "el-input-number" },
    { label: "chance", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_CREATE_TIMED_EVENT
  [{ label: "entry", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_PLAYMOVIE
  [
    { label: "PointId", field: "action_param1", type: "el-input-number" },
    { label: "isTransport ", field: "action_param2", type: "el-switch" },
    { label: "controlled  ", field: "action_param3", type: "el-switch" },
    {
      label: "ContactDistance ",
      field: "action_param2",
      type: "el-input-number",
    },
  ], // SMART_ACTION_MOVE_TO_POS
  [{ label: "Respawntime ", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_RESPAWN_TARGET
  [
    { label: "EquipID", field: "action_param1", type: "el-input-number" },
    { label: "Slotmask", field: "action_param2", type: "el-input-number" },
    { label: "Slot1", field: "action_param3", type: "item-temlate-selector" },
    { label: "Slot2", field: "action_param4", type: "item-temlate-selector" },
    { label: "Slot3", field: "action_param5", type: "item-temlate-selector" },
  ], // SMART_ACTION_EQUIP
  [], // SMART_ACTION_CLOSE_GOSSIP
  [{ label: "ID", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_TRIGGER_TIMED_EVENT
  [{ label: "ID", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_REMOVE_TIMED_EVENT
  [{ label: "SpellID", field: "action_param1", type: "spell-selector" }], // SMART_ACTION_ADD_AURA
  [], // SMART_ACTION_OVERRIDE_SCRIPT_BASE_OBJECT
  [], // SMART_ACTION_RESET_SCRIPT_BASE_OBJECT
  [], // SMART_ACTION_CALL_SCRIPT_RESET
  [
    {
      label: "attackDistance",
      field: "action_param1",
      type: "el-input-number",
    },
    { label: "attackAngle", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_RANGED_MOVEMENT
  [
    { label: "EntryOrGuid", field: "action_param1", type: "el-input-number" },
    { label: "type", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_CALL_TIMED_ACTIONLIST
  [{ label: "npcflag", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_NPC_FLAG
  [{ label: "npcflag", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_ADD_NPC_FLAG
  [{ label: "npcflag", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_REMOVE_NPC_FLAG
  [{ label: "GroupID", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SIMPLE_TALK
  [
    { label: "SpellID", field: "action_param1", type: "spell-selector" },
    { label: "castFlags", field: "action_param2", type: "el-input-number" },
    {
      label: "triggeredFlags",
      field: "action_param3",
      type: "el-input-number",
    },
  ], // SMART_ACTION_INVOKER_CAST
  [
    { label: "SpellID", field: "action_param1", type: "spell-selector" },
    { label: "castFlags", field: "action_param2", type: "el-input-number" },
    {
      label: "CasterTargetType ",
      field: "action_param3",
      type: "el-input-number",
    },
    { label: "CasterTarget ", field: "action_param4", type: "el-input-number" },
    { label: "CasterTarget ", field: "action_param5", type: "el-input-number" },
    { label: "CasterTarget ", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_CROSS_CAST
  [
    { label: "EntryOrGuid1", field: "action_param1", type: "el-input-number" },
    { label: "EntryOrGuid2", field: "action_param2", type: "el-input-number" },
    { label: "EntryOrGuid3", field: "action_param3", type: "el-input-number" },
    { label: "EntryOrGuid4", field: "action_param4", type: "el-input-number" },
    { label: "EntryOrGuid5", field: "action_param5", type: "el-input-number" },
    { label: "EntryOrGuid6", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST
  [
    { label: "EntryOrGuid1", field: "action_param1", type: "el-input-number" },
    { label: "EntryOrGuid2", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST
  [{ label: "Radius", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_RANDOM_MOVE
  [
    { label: "Value", field: "action_param1", type: "el-input-number" },
    { label: "Type", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_UNIT_FIELD_BYTES_1
  [
    { label: "Value", field: "action_param1", type: "el-input-number" },
    { label: "Type", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1
  [
    { label: "delay ", field: "action_param1", type: "el-switch" },
    { label: "法术技能", field: "action_param2", type: "spell-selector" },
    { label: "Instant ", field: "action_param3", type: "el-switch" },
  ], // SMART_ACTION_INTERRUPT_SPELL
  [{ label: "animprogress", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SEND_GO_CUSTOM_ANIM
  [{ label: "dynamicflags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_DYNAMIC_FLAG
  [{ label: "dynamicflags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_ADD_DYNAMIC_FLAG
  [{ label: "dynamicflags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_REMOVE_DYNAMIC_FLAG
  [
    { label: "Speed XY", field: "action_param1", type: "el-input-number" },
    { label: "Speed Z", field: "action_param2", type: "el-input-number" },
    { label: "selfJump ", field: "action_param3", type: "el-switch" },
  ], // SMART_ACTION_JUMP_TO_POS
  [
    { label: "对话编号", field: "action_param1", type: "gossip-menu-selector" },
    { label: "text_id", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SEND_GOSSIP_MENU
  [{ label: "LootState ", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_GO_SET_LOOT_STATE
  [{ label: "ID", field: "action_param1", type: "el-input-number" }], // v
  [{ label: "Home", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_HOME_POS
  [{ label: "HealthRegen", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_HEALTH_REGEN
  [{ label: "Root", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_ROOT
  [{ label: "flags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_GO_FLAG
  [{ label: "flags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_ADD_GO_FLAG
  [{ label: "flags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_REMOVE_GO_FLAG
  [
    { label: "GroupID", field: "action_param1", type: "el-input-number" },
    { label: "attackInvoker ", field: "action_param2", type: "el-switch" },
    { label: "attackScriptOwner  ", field: "action_param3", type: "el-switch" },
  ], // SMART_ACTION_SUMMON_CREATURE_GROUP
  [
    { label: "type", field: "action_param1", type: "el-input-number" },
    { label: "New power", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_POWER
  [
    { label: "type", field: "action_param1", type: "el-input-number" },
    { label: "New power", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_ADD_POWER
  [
    { label: "type", field: "action_param1", type: "el-input-number" },
    { label: "New power", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_REMOVE_POWER
  [{ label: "eventEntry", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_GAME_EVENT_STOP
  [{ label: "eventEntry", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_GAME_EVENT_START
  [
    { label: "wp1", field: "action_param1", type: "el-input-number" },
    { label: "wp2", field: "action_param2", type: "el-input-number" },
    { label: "wp3", field: "action_param3", type: "el-input-number" },
    { label: "wp4", field: "action_param4", type: "el-input-number" },
    { label: "wp5", field: "action_param5", type: "el-input-number" },
    { label: "wp6", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_START_CLOSEST_WAYPOINT
  [{ label: "distance", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_RISE_UP
  [
    { label: "soundId1", field: "action_param1", type: "el-input-number" },
    { label: "soundId2", field: "action_param2", type: "el-input-number" },
    { label: "soundId3", field: "action_param3", type: "el-input-number" },
    { label: "soundId4", field: "action_param4", type: "el-input-number" },
    { label: "onlySelf ", field: "action_param5", type: "el-switch" },
  ], // SMART_ACTION_RANDOM_SOUND
  [],
  [],
  [],
  [],
  [],
  [{ label: "SightDistance", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_SIGHT_DIST
  [{ label: "FleeTime", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_FLEE
  [
    {
      label: "ThreatIncrement",
      field: "action_param1",
      type: "el-input-number",
    },
    {
      label: "ThreatDecrement",
      field: "action_param2",
      type: "el-input-number",
    },
  ], // SMART_ACTION_ADD_THREAT
  [
    { label: "ID", field: "action_param1", type: "el-input-number" },
    { label: "Force", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_LOAD_EQUIPMENT
  [
    { label: "id min range", field: "action_param1", type: "el-input-number" },
    { label: "id max range", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT
  [], // SMART_ACTION_REMOVE_ALL_GAMEOBJECTS
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [{ label: "pointId", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_MOVE_TO_POS_TARGET
  [{ label: "state", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_GO_STATE
  [], // SMART_ACTION_EXIT_VEHICLE
  [{ label: "flags", field: "action_param1", type: "el-input-number" }], // SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS
  [
    {
      label: "combatDistance",
      field: "action_param1",
      type: "el-input-number",
    },
  ], // SMART_ACTION_SET_COMBAT_DISTANCE
  [
    {
      label: "followDistance",
      field: "action_param1",
      type: "el-input-number",
    },
    { label: "resetToMax", field: "action_param2", type: "el-input-number" },
  ], // SMART_ACTION_SET_CASTER_COMBAT_DIST
  [{ label: "是/否", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_HOVER
  [
    { label: "type", field: "action_param1", type: "el-input-number" },
    { label: "id", field: "action_param2", type: "el-input-number" },
    { label: "value", field: "action_param3", type: "el-input-number" },
  ], // SMART_ACTION_ADD_IMMUNITY
  [
    { label: "type", field: "action_param1", type: "el-input-number" },
    { label: "id", field: "action_param2", type: "el-input-number" },
    { label: "value", field: "action_param3", type: "el-input-number" },
  ], // SMART_ACTION_REMOVE_IMMUNITY
  [], // SMART_ACTION_FALL
  [{ label: "是/否", field: "action_param1", type: "el-switch" }], // SMART_ACTION_SET_EVENT_FLAG_RESET
  [
    { label: "stopMoving", field: "action_param1", type: "el-input-number" },
    {
      label: "movementExpired",
      field: "action_param2",
      type: "el-input-number",
    },
  ], // SMART_ACTION_STOP_MOTION
  [],
  // SMART_ACTION_NO_ENVIRONMENT_UPDATE
  [], // SMART_ACTION_ZONE_UNDER_ATTACK
  [], // SMART_ACTION_LOAD_GRID
  [
    { label: "SoundId", field: "action_param1", type: "el-input-number" },
    { label: "onlySelf", field: "action_param2", type: "el-switch" },
    { label: "type", field: "action_param3", type: "el-input-number" },
  ], // SMART_ACTION_MUSIC
  [
    { label: "SoundId1", field: "action_param1", type: "el-input-number" },
    { label: "SoundId2", field: "action_param2", type: "el-input-number" },
    { label: "SoundId3", field: "action_param3", type: "el-input-number" },
    { label: "SoundId4", field: "action_param4", type: "el-input-number" },
    { label: "onlySelf", field: "action_param5", type: "el-switch" },
    { label: "type", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_RANDOM_MUSIC
  [
    { label: "SpellID", field: "action_param1", type: "el-input-number" },
    { label: "castFlag", field: "action_param2", type: "el-input-number" },
    { label: "bp0", field: "action_param3", type: "el-input-number" },
    { label: "bp1", field: "action_param4", type: "el-input-number" },
    { label: "bp2", field: "action_param5", type: "el-input-number" },
  ], // SMART_ACTION_CUSTOM_CAST
  [
    { label: "entry", field: "action_param1", type: "el-input-number" },
    { label: "Duration", field: "action_param2", type: "el-input-number" },
    {
      label: "Distance between rings",
      field: "action_param3",
      type: "el-input-number",
    },
    {
      label: "Distance between each summons in a row ",
      field: "action_param4",
      type: "el-switch",
    },
    {
      label: "Length of the cone",
      field: "action_param5",
      type: "el-input-number",
    },
    {
      label: "Width of the cone",
      field: "action_param6",
      type: "el-input-number",
    },
  ], // SMART_ACTION_CONE_SUMMON
  [
    {
      label: "acore_string.ID",
      field: "action_param1",
      type: "el-input-number",
    },
    { label: "yell", field: "action_param2", type: "el-switch" },
  ], // SMART_ACTION_PLAYER_TALK
  [
    { label: "entry", field: "action_param1", type: "el-input-number" },
    { label: "Duration", field: "action_param2", type: "el-input-number" },
    {
      label: "Spiral scaling",
      field: "action_param3",
      type: "el-input-number",
    },
    {
      label: "Spiral appearance",
      field: "action_param4",
      type: "el-input-number",
    },
    { label: "range max", field: "action_param5", type: "el-input-number" },
    { label: "phi_delta", field: "action_param6", type: "el-input-number" },
  ], // SMART_ACTION_VORTEX_SUMMON
  [], // SMART_ACTION_CU_ENCOUNTER_START
];

const targetTypes = [
  "无",
  "自身",
  "当前目标（最高仇恨）",
  "第二仇恨目标",
  "最后仇恨目标",
  "威胁值列表中的随机目标",
  "非最高威胁值随机目标",
  "事件触发者",
  "位置",
  "随机生物",
  "指定GUID的生物",
  "范围内生物",
  "存储",
  "随机物体",
  "指定GUID的物体",
  "距离内物体",
  "召唤者队伍",
  "远程玩家",
  "距离内玩家",
  "最近生物",
  "最近物体",
  "最近玩家",
  "调用者交通工具",
  "拥有者或者召唤者",
  "仇恨列表",
  "最近的敌方",
  "最近的友方",
];

const targetParams = [
  [], // SMART_TARGET_NONE
  [], // SMART_TARGET_SELF
  [], // SMART_TARGET_VICTIM
  [], // SMART_TARGET_HOSTILE_SECOND_AGGRO
  [], // SMART_TARGET_HOSTILE_LAST_AGGRO
  [], // SMART_TARGET_HOSTILE_RANDOM
  [], // SMART_TARGET_HOSTILE_RANDOM_NOT_TOP
  [], // SMART_TARGET_ACTION_INVOKER
  [
    { label: "x", field: "target_x", type: "el-input-number" },
    { label: "y", field: "target_y", type: "el-input-number" },
    { label: "z", field: "target_z", type: "el-input-number" },
    { label: "o", field: "target_o", type: "el-input-number" },
  ], // SMART_TARGET_POSITION
  [
    {
      label: "entry ",
      field: "target_param1",
      type: "creature-template-selector",
    },
    { label: "minDist", field: "target_param2", type: "el-input-number" },
    { label: "maxDist", field: "target_param3", type: "el-input-number" },
    { label: "alive state", field: "target_param4", type: "el-input-number" },
  ], // SMART_TARGET_CREATURE_RANGE
  [
    { label: "guid ", field: "target_param1", type: "el-input-number" },
    {
      label: "entry",
      field: "target_param2",
      type: "creature-template-selector",
    },
    { label: "getFromHashMap ", field: "target_param3", type: "el-switch" },
  ], // SMART_TARGET_CREATURE_GUID
  [
    {
      label: "entry ",
      field: "target_param1",
      type: "creature-template-selector",
    },
    { label: "maxDist", field: "target_param2", type: "el-input-number" },
    { label: "alive state", field: "target_param3", type: "el-input-number" },
  ], // SMART_TARGET_CREATURE_DISTANCE
  [{ label: "id ", field: "target_param1", type: "el-input-number" }], // SMART_TARGET_STORED
  [
    {
      label: "entry ",
      field: "target_param1",
      type: "creature-template-selector",
    },
    { label: "minDist", field: "target_param2", type: "el-input-number" },
    { label: "maxDist", field: "target_param3", type: "el-input-number" },
  ], // SMART_TARGET_GAMEOBJECT_RANGE
  [
    {
      label: "gameObjectGuid ",
      field: "target_param1",
      type: "el-input-number",
    },
    {
      label: "gameObjectEntry",
      field: "target_param2",
      type: "el-input-number",
    },
    { label: "getFromHashMap ", field: "target_param3", type: "el-switch" },
  ], // SMART_TARGET_GAMEOBJECT_GUID
  [
    {
      label: "gameObjectEntry ",
      field: "target_param1",
      type: "el-input-number",
    },
    { label: "maxDist", field: "target_param2", type: "el-input-number" },
  ], // SMART_TARGET_GAMEOBJECT_DISTANCE
  [], // SMART_TARGET_INVOKER_PARTY
  [
    {
      label: "minDist ",
      field: "target_param1",
      type: "el-input-number",
    },
    { label: "maxDist", field: "target_param2", type: "el-input-number" },
    { label: "maxCount", field: "target_param3", type: "el-input-number" },
    { label: "maxDist", field: "target_o", type: "el-input-number" },
  ], // SMART_TARGET_PLAYER_RANGE
  [
    {
      label: "maxDist ",
      field: "target_param1",
      type: "el-input-number",
    },
  ], // SMART_TARGET_PLAYER_DISTANCE
  [
    {
      label: "entry  ",
      field: "target_param1",
      type: "creature-template-selector",
    },
    { label: "maxDist", field: "target_param2", type: "el-input-number" },
    { label: "dead", field: "target_param3", type: "el-switch" },
  ], // SMART_TARGET_CLOSEST_CREATURE
  [
    {
      label: "gameObjectEntry ",
      field: "target_param1",
      type: "el-input-number",
    },
    { label: "maxDist", field: "target_param2", type: "el-input-number" },
  ], // SMART_TARGET_CLOSEST_GAMEOBJECT
  [
    {
      label: "maxDist ",
      field: "target_param1",
      type: "el-input-number",
    },
  ], // SMART_TARGET_CLOSEST_PLAYER
  [], // SMART_TARGET_ACTION_INVOKER_VEHICLE
  [
    {
      label: "Owner ",
      field: "target_param1",
      type: "el-switch",
    },
  ], // SMART_TARGET_OWNER_OR_SUMMONER
  [
    {
      label: "maxDist ",
      field: "target_param1",
      type: "el-input-number",
    },
  ], // SMART_TARGET_THREAT_LIST
  [
    {
      label: "maxDist ",
      field: "target_param1",
      type: "el-input-number",
    },
    { label: "playerOnly ", field: "target_param2", type: "el-switch" },
  ], // SMART_TARGET_CLOSEST_ENEMY
  [
    {
      label: "maxDist ",
      field: "target_param1",
      type: "el-input-number",
    },
    { label: "playerOnly ", field: "target_param2", type: "el-switch" },
  ], // SMART_TARGET_CLOSEST_FRIENDLY
  [],
  [
    {
      label: "maxDist ",
      field: "target_param1",
      type: "el-input-number",
    },
    { label: "playerOnly ", field: "target_param2", type: "el-switch" },
    { label: "isInLos  ", field: "target_param3", type: "el-switch" },
  ], // SMART_TARGET_FARTHEST// SMART_TARGET_GAMEOBJECT_GUID
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],

  [
    { label: "SpellID ", field: "target_param1", type: "spell-selector" },
    { label: "Negative", field: "target_param2", type: "el-switch" },
    { label: "MaxDist", field: "target_param3", type: "el-input-number" },
    { label: "MinDist", field: "target_param4", type: "el-input-number" },
    { label: "Number to resize", field: "target_o", type: "el-input-number" },
  ], // SMART_TARGET_PLAYER_WITH_AURA
  [
    { label: "range", field: "target_param1", type: "el-input-number" },
    { label: "amount", field: "target_param2", type: "el-switch" },
    {
      label: "self as middle",
      field: "target_param3",
      type: "el-input-number",
    },
  ], // SMART_TARGET_RANDOM_POINT
  [
    { label: "rangeMax", field: "target_param1", type: "el-input-number" },
    { label: "TargetMask", field: "target_param2", type: "el-switch" },
    { label: "Resize list", field: "target_param3", type: "el-input-number" },
  ], // SMART_TARGET_ROLE_SELECTION
];

export {
  sourceTypes,
  eventTypes,
  eventPhaseMasks,
  eventFlags,
  eventParams,
  actionTypes,
  actionParams,
  targetTypes,
  targetParams,
};
