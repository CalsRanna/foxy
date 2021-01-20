const colors = [
  "grey",
  "#606266",
  "green",
  "blue",
  "purple",
  "orange",
  "red",
  "gold"
];
const localeQualities = [
  "粗糙",
  "普通",
  "优秀",
  "精良",
  "史诗",
  "传说",
  "神器",
  "传家宝"
];
const localeClasses = [
  "消耗品",
  "容器",
  "武器",
  "珠宝",
  "护甲",
  "药剂",
  "弹药",
  "贸易品",
  "通用（弃用）",
  "配方",
  "货币",
  "箭袋",
  "任务",
  "钥匙",
  "永久的（弃用）",
  "杂项",
  "雕文"
];

const localeSubclasses = [
  [
    "消耗品",
    "药水",
    "药剂",
    "合剂",
    "卷轴",
    "食物和饮料",
    "物品强化",
    "绷带",
    "其他"
  ],
  [
    "背包",
    "灵魂袋",
    "草药包",
    "附魔材料包",
    "工程学材料包",
    "宝石袋",
    "矿物袋",
    "制皮材料包",
    "铭文包"
  ],
  [
    "单手斧",
    "双手斧",
    "弓",
    "枪",
    "单手杖",
    "双手锤",
    "长柄武器",
    "单手剑",
    "双手剑",
    "弃用",
    "法杖",
    "外来的",
    "外来的",
    "拳套",
    "杂项",
    "匕首",
    "投掷",
    "矛",
    "弩",
    "魔杖",
    "钓鱼竿"
  ],
  ["红色", "蓝色", "黄色", "紫色", "绿色", "橙色", "多彩", "简单", "棱彩"],
  [
    "杂项",
    "布甲",
    "皮甲",
    "锁甲",
    "板甲",
    "小圆盾（弃用）",
    "盾",
    "圣契",
    "神像",
    "图腾",
    "魔印"
  ],
  ["药剂"],
  ["魔杖（弃用）", "闪电（弃用）", "箭", "子弹", "投掷（弃用）"],
  [
    "贸易品",
    "零件",
    "爆炸物",
    "装置",
    "珠宝加工",
    "布料",
    "皮革",
    "金属和矿石",
    "肉类",
    "草药",
    "元素",
    "其他",
    "附魔",
    "原料",
    "护甲附魔",
    "武器附魔"
  ],
  ["通用（弃用）"],
  [
    "书籍",
    "制皮",
    "裁缝",
    "工程学",
    "锻造",
    "烹饪",
    "炼金术",
    "急救",
    "附魔",
    "钓鱼",
    "珠宝加工"
  ],
  ["货币"],
  ["箭袋（弃用）", "弹药袋（弃用）", "箭袋", "弹药袋"],
  ["任务"],
  ["钥匙", "开锁工具"],
  ["永久的（弃用）"],
  ["垃圾", "施法材料", "伙伴", "节日", "其他", "坐骑"],
  [
    "",
    "战士",
    "圣骑士",
    "猎人",
    "盗贼",
    "牧师",
    "死亡骑士",
    "萨满",
    "法师",
    "术士",
    "",
    "德鲁伊"
  ]
];
const localeInventoryTypes = [
  "其他",
  "头部",
  "颈部",
  "肩部",
  "衬衣",
  "胸部",
  "腰部",
  "腿部",
  "脚",
  "手腕",
  "手",
  "手指",
  "饰品",
  "单手",
  "副手（盾）",
  "远程（左手）",
  "背部",
  "双手",
  "背包",
  "披风",
  "战袍",
  "主手",
  "副手",
  "副手物品",
  "弹药",
  "投掷",
  "远程（右手）",
  "箭袋",
  "圣物"
];

const soundOverrideSubclassTooltip = `
  Weapons have special sounds on impact. This column is used to
  override these sounds by specifying another subclass. For
  example an item with misc subclass can sound like a stave on
  impact by overriding the subclass here.
`;

const materialTooltip = `
  The material that the item is made of. The value here affects
  the sound that the item makes when moved. Use -1 for
  consumable items like food, reagents, etc.
`;

const localeMaterials = [
  "未定义",
  "金属",
  "木制品",
  "液体",
  "珠宝",
  "锁甲",
  "板甲",
  "布甲",
  "皮甲"
]; //-1 消耗品（食物，试剂等）

const localeStatTypes = [
  "无",
  "生命值",
  "法力值",
  "敏捷",
  "力量",
  "智力",
  "精神",
  "耐力",
  "",
  "",
  "",
  "",
  "防御等级",
  "躲闪等级",
  "招架等级",
  "盾牌格挡",
  "近战命中",
  "远程命中",
  "法术命中",
  "近战暴击",
  "远程暴击",
  "法术暴击",
  "近战躲闪",
  "远程躲闪",
  "法术躲闪",
  "近战暴击躲闪",
  "远程暴击躲闪",
  "法术暴击躲闪",
  "近战攻击速度",
  "远程攻击速度",
  "法术攻击速度",
  "命中等级",
  "暴击等级",
  "命中躲闪",
  "暴击躲闪",
  "韧性",
  "急速攻击速度",
  "精准等级",
  "攻击强度",
  "远程攻击强度",
  "猎豹、熊、巨熊形态攻击强度",
  "法术治疗效果",
  "法术伤害效果",
  "5秒回蓝",
  "护甲穿透等级",
  "法术强度",
  "5秒回血",
  "法术穿透",
  "格挡值"
];

const bondings = [
  "不绑定",
  "拾取时绑定",
  "装备后绑定",
  "使用后绑定",
  "任务物品",
  "任务物品1"
];

const foodTypes = [
  "无",
  "肉",
  "鱼",
  "芝士",
  "面包",
  "菌类",
  "水果",
  "生肉",
  "生鱼"
];

const bagFamilies = [
  {
    index: 0,
    flag: 1,
    name: "箭袋",
    comment: ""
  },
  {
    index: 1,
    flag: 2,
    name: "弹药袋",
    comment: ""
  },
  {
    index: 2,
    flag: 4,
    name: "灵魂碎片",
    comment: ""
  },
  {
    index: 3,
    flag: 8,
    name: "皮革用品",
    comment: ""
  },
  {
    index: 4,
    flag: 16,
    name: "铭文袋",
    comment: ""
  },
  {
    index: 5,
    flag: 32,
    name: "草药袋",
    comment: ""
  },
  {
    index: 6,
    flag: 64,
    name: "附魔袋",
    comment: ""
  },
  {
    index: 7,
    flag: 128,
    name: "工程袋",
    comment: ""
  },
  {
    index: 8,
    flag: 256,
    name: "钥匙袋",
    comment: ""
  },
  {
    index: 9,
    flag: 512,
    name: "珠宝袋",
    comment: ""
  },
  {
    index: 10,
    flag: 1024,
    name: "矿石袋",
    comment: ""
  },
  {
    index: 11,
    flag: 2048,
    name: "灵魂绑定",
    comment: ""
  },
  {
    index: 12,
    flag: 4096,
    name: "宠物栏",
    comment: ""
  },
  {
    index: 13,
    flag: 8192,
    name: "钱袋",
    comment: ""
  },
  {
    index: 14,
    flag: 16384,
    name: "任务物品",
    comment: ""
  }
];

const sheaths = [
  "无",
  "双手，背在后面尖向下",
  "杖，背在后面尖向上",
  "单手，在旁边",
  "盾，在后边",
  "附魔棒",
  "拳套、火把、锄头等"
];

const flags = [
  {
    index: 0,
    flag: 1,
    name: "未知",
    comment: ""
  },
  {
    index: 1,
    flag: 2,
    name: "魔法制造",
    comment: ""
  },
  {
    index: 2,
    flag: 4,
    name: "可打开的",
    comment: ""
  },
  {
    index: 3,
    flag: 8,
    name: "上面有绿色的英雄文字",
    comment: ""
  },
  {
    index: 4,
    flag: 16,
    name: "废弃物品",
    comment: ""
  },
  {
    index: 5,
    flag: 32,
    name: "除非用法术，否则不能被摧毁",
    comment: ""
  },
  {
    index: 6,
    flag: 64,
    name: "未知",
    comment: ""
  },
  {
    index: 7,
    flag: 128,
    name: "装备时没有默认的30秒冷却",
    comment: ""
  },
  {
    index: 8,
    flag: 256,
    name: "未知",
    comment: ""
  },
  {
    index: 9,
    flag: 512,
    name: "包裹，可以盛放其他物品",
    comment: ""
  },
  {
    index: 10,
    flag: 1024,
    name: "未知",
    comment: ""
  },
  {
    index: 11,
    flag: 2048,
    name: "只有部分能掉落，不是全部",
    comment: ""
  },
  {
    index: 12,
    flag: 4096,
    name: "可退还",
    comment: ""
  },
  {
    index: 13,
    flag: 8192,
    name: "公会或竞技场登记表",
    comment: ""
  },
  {
    index: 14,
    flag: 16384,
    name: "未知，只有可以读的物品使用",
    comment: ""
  },
  {
    index: 15,
    flag: 32768,
    name: "未知",
    comment: ""
  },
  {
    index: 16,
    flag: 65536,
    name: "未知",
    comment: ""
  },
  {
    index: 17,
    flag: 131072,
    name: "未知",
    comment: ""
  },
  {
    index: 18,
    flag: 262144,
    name: "可勘探物品",
    comment: ""
  },
  {
    index: 19,
    flag: 524288,
    name: "装备唯一",
    comment: ""
  },
  {
    index: 20,
    flag: 1048576,
    name: "未知",
    comment: ""
  },
  {
    index: 21,
    flag: 2097152,
    name: "竞技场比赛中可用",
    comment: ""
  },
  {
    index: 22,
    flag: 4194304,
    name: "异常（游戏中的提示）",
    comment: ""
  },
  {
    index: 23,
    flag: 8388608,
    name: "变形时可用",
    comment: ""
  },
  {
    index: 24,
    flag: 16777216,
    name: "未知",
    comment: ""
  },
  {
    index: 25,
    flag: 33554432,
    name: "职业配方，只有当你符合条件时才会掉落",
    comment: ""
  },
  {
    index: 26,
    flag: 67108864,
    name: "竞技场不可用",
    comment: ""
  },
  {
    index: 27,
    flag: 134217728,
    name: "账号绑定（需要同时把Quality设置为7）",
    comment: ""
  },
  {
    index: 28,
    flag: 268435456,
    name: "在触发标志时使用法术",
    comment: ""
  },
  {
    index: 29,
    flag: 536870912,
    name: "有效",
    comment: ""
  },
  {
    index: 30,
    flag: 1073741824,
    name: "未知",
    comment: ""
  },
  {
    index: 31,
    flag: 2147483648,
    name: "拾取绑定，可交易",
    comment: ""
  }
];

const flagsExtra = [
  {
    index: 0,
    flag: 1,
    name: "只用于部落",
    comment: ""
  },
  {
    index: 1,
    flag: 2,
    name: "只用于联盟",
    comment: ""
  },
  {
    index: 2,
    flag: 4,
    name: "附带金钱",
    comment:
      "当物品使用npc_vendor表的ExtendedCost字段时，还需要附带金钱才能购买"
  },
  {
    index: 3,
    flag: 8,
    name: "未知",
    comment: ""
  },
  {
    index: 4,
    flag: 16,
    name: "未知",
    comment: ""
  },
  {
    index: 5,
    flag: 32,
    name: "未知",
    comment: ""
  },
  {
    index: 6,
    flag: 64,
    name: "未知",
    comment: ""
  },
  {
    index: 7,
    flag: 128,
    name: "未知",
    comment: ""
  },
  {
    index: 8,
    flag: 256,
    name: "该物品不用roll点",
    comment: ""
  },
  {
    index: 9,
    flag: 512,
    name: "取消roll点",
    comment: ""
  },
  {
    index: 10,
    flag: 1024,
    name: "未知",
    comment: ""
  },
  {
    index: 11,
    flag: 2048,
    name: "未知",
    comment: ""
  },
  {
    index: 12,
    flag: 4096,
    name: "未知",
    comment: ""
  },
  {
    index: 13,
    flag: 8192,
    name: "未知",
    comment: ""
  },
  {
    index: 14,
    flag: 16384,
    name: "普通标价",
    comment: ""
  },
  {
    index: 15,
    flag: 32768,
    name: "未知",
    comment: ""
  },
  {
    index: 16,
    flag: 65536,
    name: "未知",
    comment: ""
  },
  {
    index: 17,
    flag: 131072,
    name: "账号绑定",
    comment: ""
  },
  {
    index: 18,
    flag: 262144,
    name: "未知",
    comment: ""
  },
  {
    index: 19,
    flag: 524288,
    name: "未知",
    comment: ""
  },
  {
    index: 20,
    flag: 1048576,
    name: "未知",
    comment: ""
  },
  {
    index: 21,
    flag: 2097152,
    name: "不能被变形",
    comment: ""
  },
  {
    index: 22,
    flag: 4194304,
    name: "不能变形",
    comment: ""
  },
  {
    index: 23,
    flag: 8388608,
    name: "可以变形",
    comment: ""
  }
];

const flagsCustom = [
  {
    index: 0,
    flag: 1,
    name: "玩家下线也计时",
    comment: ""
  },
  {
    index: 1,
    flag: 2,
    name: "掉落时不检测任务状态",
    comment: ""
  },
  {
    index: 2,
    flag: 4,
    name: "点贪婪前遵守掉落规则",
    comment: ""
  }
];

export {
  colors,
  localeQualities,
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
  soundOverrideSubclassTooltip,
  materialTooltip,
  localeMaterials,
  localeStatTypes,
  bondings,
  foodTypes,
  bagFamilies,
  sheaths,
  flags,
  flagsExtra,
  flagsCustom
};
