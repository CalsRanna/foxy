const colors = ["grey", "#606266", "green", "blue", "purple", "orange", "red", "gold"];
const localeQualities = ["粗糙", "普通", "优秀", "精良", "史诗", "传说", "神器", "传家宝"];
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
  ["消耗品", "药水", "药剂", "合剂", "卷轴", "食物和饮料", "物品强化", "绷带", "其他"],
  ["背包", "灵魂袋", "草药包", "附魔材料包", "工程学材料包", "宝石袋", "矿物袋", "制皮材料包", "铭文包"],
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
  ["杂项", "布甲", "皮甲", "锁甲", "板甲", "小圆盾（弃用）", "盾", "圣契", "神像", "图腾", "魔印"],
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
  ["书籍", "制皮", "裁缝", "工程学", "锻造", "烹饪", "炼金术", "急救", "附魔", "钓鱼", "珠宝加工"],
  ["货币"],
  ["箭袋（弃用）", "弹药袋（弃用）", "箭袋", "弹药袋"],
  ["任务"],
  ["钥匙", "开锁工具"],
  ["永久的（弃用）"],
  ["垃圾", "施法材料", "伙伴", "节日", "其他", "坐骑"],
  ["", "战士", "圣骑士", "猎人", "盗贼", "牧师", "死亡骑士", "萨满", "法师", "术士", "", "德鲁伊"]
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

const localeMaterials = ["未定义", "金属", "木制品", "液体", "珠宝", "锁甲", "板甲", "布甲", "皮甲"]; //-1 消耗品（食物，试剂等）

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

const bondings = ["不绑定", "拾取时绑定", "装备后绑定", "使用后绑定", "任务物品", "任务物品1"];

export {
  colors,
  localeQualities,
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
  localeMaterials,
  localeStatTypes,
  bondings
};
