const flags = [
  {
    index: 0,
    flag: 1,
    name: "玩家必须存活",
    comment: "If the player dies, the quest is failed.",
  },
  {
    index: 1,
    flag: 2,
    name: "队伍内可接",
    comment:
      "Escort quests or any other event-driven quests. If player in party, all players that can accept this quest will receive confirmation box to accept quest.",
  },
  {
    index: 2,
    flag: 4,
    name: "探索",
    comment: "Involves the activation of an areatrigger.",
  },
  {
    index: 3,
    flag: 8,
    name: "可共享",
    comment: "Allows the quest to be shared with other players.",
  },
  {
    index: 4,
    flag: 16,
    name: "有条件",
    comment: "Not used currently",
  },
  {
    index: 5,
    flag: 32,
    name: "隐藏奖励POI",
    comment: "Not used currently: Unsure of content",
  },
  {
    index: 6,
    flag: 64,
    name: "团队内可完成",
    comment: "Can be completed while in raid",
  },
  {
    index: 7,
    flag: 128,
    name: "需要TBC",
    comment: "Not used currently: Available if TBC expansion enabled only",
  },
  {
    index: 8,
    flag: 256,
    name: "经验不转换为金钱",
    comment:
      "Not used currently: Experience is not converted to gold at max level",
  },
  {
    index: 9,
    flag: 512,
    name: "奖励隐藏",
    comment:
      "Item and monetary rewards are hidden in the initial quest details page and in the quest log but will appear once ready to be rewarded.",
  },
  {
    index: 10,
    flag: 1024,
    name: "不可追踪",
    comment:
      "These quests are automatically rewarded on quest complete and they will never appear in quest log client side.",
  },
  {
    index: 11,
    flag: 2048,
    name: "废弃声望",
    comment: "Not used currently",
  },
  {
    index: 12,
    flag: 4096,
    name: "日常任务",
    comment:
      "Daily repeatable quests (only flag that the core applies specific behavior for)",
  },
  {
    index: 13,
    flag: 8192,
    name: "强制PVP",
    comment: "Having this quest in log forces PvP flag",
  },
  {
    index: 14,
    flag: 16384,
    name: "不可用",
    comment: "Used on quests that are not generically available",
  },
  {
    index: 15,
    flag: 32768,
    name: "周常任务",
    comment:
      "Weekly repeatable quests (only flag that the core applies specific behavior for)",
  },
  {
    index: 16,
    flag: 65536,
    name: "自动完成",
    comment: "Auto complete",
  },
  {
    index: 17,
    flag: 131072,
    name: "展示可用物品",
    comment: "Displays usable item in quest tracker",
  },
  {
    index: 18,
    flag: 262144,
    name: "目标文本代替完成文本",
    comment: "Use Objective text as Complete text",
  },
  {
    index: 19,
    flag: 524288,
    name: "自动接受",
    comment:
      "The client recognizes this flag as auto-accept. However, NONE of the current quests (3.3.5a) have this flag. Maybe blizz used to use it, or will use it in the future.",
  },
  {
    index: 20,
    flag: 1048576,
    name: "特殊按钮接受任务",
    comment:
      "Quests with this flag player submit automatically by special button in player GUI",
  },
  {
    index: 21,
    flag: 2097152,
    name: "特殊按钮完成任务",
    comment: "Automatically suggestion of accepting quest. Not from npc.",
  },
  {
    index: 22,
    flag: 4194304,
    name: "UPDATE_PHASE_SHIFT",
    comment: "",
  },
  { index: 23, flag: 8388608, name: "SOR_WHITELIST", comment: "" },
  {
    index: 24,
    flag: 16777216,
    name: "LAUNCH_GOSSIP_COMPLETE",
    comment: "",
  },
  {
    index: 25,
    flag: 33554432,
    name: "EMOVE_EXTRA_GET_ITEMS",
    comment: "",
  },
  {
    index: 26,
    flag: 67108864,
    name: "发现前隐藏",
    comment: "",
  },
  {
    index: 27,
    flag: 134217728,
    name: "PORTRAIT_IN_QUEST_LOG",
    comment: "",
  },
  {
    index: 28,
    flag: 268435456,
    name: "SHOW_ITEM_WHEN_COMPLETED",
    comment: "",
  },
  {
    index: 29,
    flag: 536870912,
    name: "LAUNCH_GOSSIP_ACCEPT",
    comment: "",
  },
  {
    index: 30,
    flag: 1073741824,
    name: "ITEMS_GLOW_WHEN_DONE",
    comment: "",
  },
  {
    index: 31,
    flag: 2147483648,
    name: "退出游戏后失败",
    comment: "",
  },
];

const rewardFactionIdTooltip = `
  Faction Id (from Faction.dbc) for which the quest give reputation points. Number of gain or lost reputation points for Faction at quest completion. This is special reputation rewarding. Normal reputation reward to quest rewarding creature faction calculated and added automatically.
`;

const rewardFactionValueIdTooltip = `
This field is used for reputation lookup in QuestFactionReward.dbc if RewardFactionValueId is 0. Value X in this field indicates RepX column of QuestFactionReward.dbc. If RewardRepValueId is positive, reputation from the first row of QuestFactionReward.dbc will be used, for negative values the second row is used.
`;

const rewardFactionValueIdOverrideTooltip = `
  This field is used to give reputation values not present in QuestFactionReward.dbc or to override them if RewardRepValueId is wrong for some reason. The value in this field is 100× the intended reputation reward (if you want to give 400 rep, put 40000 in RewardFactionValueIdOverride).
`;

export {
  flags,
  rewardFactionIdTooltip,
  rewardFactionValueIdTooltip,
  rewardFactionValueIdOverrideTooltip,
};
