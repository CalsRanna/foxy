import 'package:foxy/constant/creature_flags.dart';

/// `SharedDefines.h::GameobjectTypes`，3.3.5a 共 0..35。
const kGameObjectTypeOptions = <int, String>{
  0: '门',
  1: '按钮',
  2: '任务发放者',
  3: '宝箱',
  4: '绑定者',
  5: '通用',
  6: '陷阱',
  7: '椅子',
  8: '法术焦点',
  9: '文本',
  10: 'Goober',
  11: '运输装置',
  12: '区域伤害',
  13: '相机',
  14: '地图对象',
  15: '地图运输',
  16: '决斗旗',
  17: '钓鱼浮标',
  18: '仪式',
  19: '邮箱',
  20: '保留类型',
  21: '守卫岗哨',
  22: '法术施放器',
  23: '集合石',
  24: '旗帜底座',
  25: '钓鱼水域',
  26: '掉落旗帜',
  27: '小游戏',
  28: '保留类型 2',
  29: '占领点',
  30: '光环生成器',
  31: '副本难度',
  32: '理发椅',
  33: '可破坏建筑',
  34: '公会银行',
  35: '活板门',
};

const kGameObjectBooleanOptions = <int, String>{0: '否', 1: '是'};
const kGameObjectTrapTypeOptions = <int, String>{
  0: '非炸弹陷阱',
  1: '炸弹陷阱',
  2: '自动关闭陷阱',
};
const kGameObjectChairHeightOptions = <int, String>{0: '低', 1: '中', 2: '高'};

/// `GameObjectFlags` 中 AzerothCore 实际使用的位。
const kGameObjectFlagItems = <FlagItem>[
  FlagItem(0x00000001, '正在使用'),
  FlagItem(0x00000002, '已锁定'),
  FlagItem(0x00000004, '受交互条件限制'),
  FlagItem(0x00000008, '运输对象'),
  FlagItem(0x00000010, '不可选中'),
  FlagItem(0x00000020, '不自动生成'),
  FlagItem(0x00000040, '已触发'),
  FlagItem(0x00000200, '已损坏'),
  FlagItem(0x00000400, '已摧毁'),
];

enum GameObjectDataReference {
  none,
  area,
  cinematicSequence,
  creatureTemplate,
  destructibleModelData,
  gameObjectLoot,
  gameObjectDisplayInfo,
  gameObjectTemplate,
  gossipMenu,
  lock,
  map,
  pageText,
  questTemplate,
  spell,
  spellFocusObject,
  taxiPath,
}

class GameObjectDataFieldConfig {
  final String label;
  final bool editable;
  final GameObjectDataReference reference;
  final Map<int, String>? options;

  const GameObjectDataFieldConfig(
    this.label, {
    this.editable = true,
    this.reference = GameObjectDataReference.none,
    this.options,
  });
}

const _unusedGameObjectData = GameObjectDataFieldConfig('未使用', editable: false);

/// `GameObjectData.h::GameObjectTemplate` 联合体的逐字段映射。
GameObjectDataFieldConfig gameObjectDataFieldConfig(int type, int index) {
  return switch ((type, index)) {
    (0, 0) => const GameObjectDataFieldConfig(
      '初始开启',
      options: kGameObjectBooleanOptions,
    ),
    (0, 1) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (0, 2) => const GameObjectDataFieldConfig('自动关闭时间'),
    (0, 3) => const GameObjectDataFieldConfig(
      '无伤害免疫',
      options: kGameObjectBooleanOptions,
    ),
    (0, 4) => const GameObjectDataFieldConfig('开启文本 ID'),
    (0, 5) => const GameObjectDataFieldConfig('关闭文本 ID'),
    (0, 6) => const GameObjectDataFieldConfig(
      '寻路忽略',
      options: kGameObjectBooleanOptions,
    ),
    (1, 0) => const GameObjectDataFieldConfig(
      '初始开启',
      options: kGameObjectBooleanOptions,
    ),
    (1, 1) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (1, 2) => const GameObjectDataFieldConfig('自动关闭时间'),
    (1, 3) => const GameObjectDataFieldConfig(
      '关联陷阱',
      reference: GameObjectDataReference.gameObjectTemplate,
    ),
    (1, 4) => const GameObjectDataFieldConfig(
      '无伤害免疫',
      options: kGameObjectBooleanOptions,
    ),
    (1, 5) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (1, 6) => const GameObjectDataFieldConfig('开启文本 ID'),
    (1, 7) => const GameObjectDataFieldConfig('关闭文本 ID'),
    (1, 8) => const GameObjectDataFieldConfig(
      '忽略视线',
      options: kGameObjectBooleanOptions,
    ),
    (2, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (2, 1) => const GameObjectDataFieldConfig('任务列表 ID'),
    (2, 2) => const GameObjectDataFieldConfig('页面材质'),
    (2, 3) => const GameObjectDataFieldConfig(
      '对话菜单',
      reference: GameObjectDataReference.gossipMenu,
    ),
    (2, 4) => const GameObjectDataFieldConfig('自定义动画'),
    (2, 5) => const GameObjectDataFieldConfig(
      '无伤害免疫',
      options: kGameObjectBooleanOptions,
    ),
    (2, 6) => const GameObjectDataFieldConfig('开启文本 ID'),
    (2, 7) => const GameObjectDataFieldConfig(
      '忽略视线',
      options: kGameObjectBooleanOptions,
    ),
    (2, 8) => const GameObjectDataFieldConfig(
      '允许骑乘使用',
      options: kGameObjectBooleanOptions,
    ),
    (2, 9) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (3, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (3, 1) => const GameObjectDataFieldConfig(
      '掉落模板',
      reference: GameObjectDataReference.gameObjectLoot,
    ),
    (3, 2) => const GameObjectDataFieldConfig('刷新时间'),
    (3, 3) => const GameObjectDataFieldConfig(
      '消耗型',
      options: kGameObjectBooleanOptions,
    ),
    (3, 4) => const GameObjectDataFieldConfig('最少成功次数（废弃）'),
    (3, 5) => const GameObjectDataFieldConfig('最多成功次数（废弃）'),
    (3, 6) => const GameObjectDataFieldConfig('事件 ID'),
    (3, 7) => const GameObjectDataFieldConfig(
      '关联陷阱',
      reference: GameObjectDataReference.gameObjectTemplate,
    ),
    (3, 8) => const GameObjectDataFieldConfig(
      '任务 ID',
      reference: GameObjectDataReference.questTemplate,
    ),
    (3, 9) => const GameObjectDataFieldConfig('等级'),
    (3, 10) => const GameObjectDataFieldConfig(
      '忽略视线',
      options: kGameObjectBooleanOptions,
    ),
    (3, 11) => const GameObjectDataFieldConfig(
      '离开时保留掉落',
      options: kGameObjectBooleanOptions,
    ),
    (3, 12) => const GameObjectDataFieldConfig(
      '不受战斗限制',
      options: kGameObjectBooleanOptions,
    ),
    (3, 13) => const GameObjectDataFieldConfig(
      '记录掉落',
      options: kGameObjectBooleanOptions,
    ),
    (3, 14) => const GameObjectDataFieldConfig('开启文本 ID'),
    (3, 15) => const GameObjectDataFieldConfig(
      '组掉落规则',
      options: kGameObjectBooleanOptions,
    ),
    (3, 16) => const GameObjectDataFieldConfig(
      '浮动提示',
      options: kGameObjectBooleanOptions,
    ),
    (5, 0) => const GameObjectDataFieldConfig(
      '浮动提示',
      options: kGameObjectBooleanOptions,
    ),
    (5, 1) => const GameObjectDataFieldConfig(
      '高亮',
      options: kGameObjectBooleanOptions,
    ),
    (5, 2) => const GameObjectDataFieldConfig(
      '仅服务端',
      options: kGameObjectBooleanOptions,
    ),
    (5, 3) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (5, 4) => const GameObjectDataFieldConfig(
      '水面漂浮',
      options: kGameObjectBooleanOptions,
    ),
    (5, 5) => const GameObjectDataFieldConfig(
      '任务 ID',
      reference: GameObjectDataReference.questTemplate,
    ),
    (6, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (6, 1) => const GameObjectDataFieldConfig('等级'),
    (6, 2) => const GameObjectDataFieldConfig('触发直径'),
    (6, 3) => const GameObjectDataFieldConfig(
      '法术 ID',
      reference: GameObjectDataReference.spell,
    ),
    (6, 4) => const GameObjectDataFieldConfig(
      '陷阱类型',
      options: kGameObjectTrapTypeOptions,
    ),
    (6, 5) => const GameObjectDataFieldConfig('冷却时间'),
    (6, 6) => const GameObjectDataFieldConfig('自动关闭时间'),
    (6, 7) => const GameObjectDataFieldConfig('启动延迟'),
    (6, 8) => const GameObjectDataFieldConfig(
      '仅服务端',
      options: kGameObjectBooleanOptions,
    ),
    (6, 9) => const GameObjectDataFieldConfig(
      '潜行',
      options: kGameObjectBooleanOptions,
    ),
    (6, 10) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (6, 11) => const GameObjectDataFieldConfig(
      '不可见',
      options: kGameObjectBooleanOptions,
    ),
    (6, 12) => const GameObjectDataFieldConfig('开启文本 ID'),
    (6, 13) => const GameObjectDataFieldConfig('关闭文本 ID'),
    (6, 14) => const GameObjectDataFieldConfig(
      '忽略图腾',
      options: kGameObjectBooleanOptions,
    ),
    (7, 0) => const GameObjectDataFieldConfig('座位数量'),
    (7, 1) => const GameObjectDataFieldConfig(
      '椅子高度',
      options: kGameObjectChairHeightOptions,
    ),
    (7, 2) => const GameObjectDataFieldConfig(
      '仅创建者使用',
      options: kGameObjectBooleanOptions,
    ),
    (7, 3) => const GameObjectDataFieldConfig('触发事件 ID'),
    (8, 0) => const GameObjectDataFieldConfig(
      '法术焦点 ID',
      reference: GameObjectDataReference.spellFocusObject,
    ),
    (8, 1) => const GameObjectDataFieldConfig('作用距离'),
    (8, 2) => const GameObjectDataFieldConfig(
      '关联陷阱',
      reference: GameObjectDataReference.gameObjectTemplate,
    ),
    (8, 3) => const GameObjectDataFieldConfig(
      '仅服务端',
      options: kGameObjectBooleanOptions,
    ),
    (8, 4) => const GameObjectDataFieldConfig(
      '任务 ID',
      reference: GameObjectDataReference.questTemplate,
    ),
    (8, 5) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (8, 6) => const GameObjectDataFieldConfig(
      '浮动提示',
      options: kGameObjectBooleanOptions,
    ),
    (9, 0) => const GameObjectDataFieldConfig(
      '页面文本',
      reference: GameObjectDataReference.pageText,
    ),
    (9, 1) => const GameObjectDataFieldConfig('语言 ID'),
    (9, 2) => const GameObjectDataFieldConfig('页面材质'),
    (9, 3) => const GameObjectDataFieldConfig(
      '允许骑乘使用',
      options: kGameObjectBooleanOptions,
    ),
    (10, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (10, 1) => const GameObjectDataFieldConfig(
      '任务 ID',
      reference: GameObjectDataReference.questTemplate,
    ),
    (10, 2) => const GameObjectDataFieldConfig('事件 ID'),
    (10, 3) => const GameObjectDataFieldConfig('自动关闭时间'),
    (10, 4) => const GameObjectDataFieldConfig('自定义动画'),
    (10, 5) => const GameObjectDataFieldConfig(
      '消耗型',
      options: kGameObjectBooleanOptions,
    ),
    (10, 6) => const GameObjectDataFieldConfig('冷却时间'),
    (10, 7) => const GameObjectDataFieldConfig(
      '页面文本',
      reference: GameObjectDataReference.pageText,
    ),
    (10, 8) => const GameObjectDataFieldConfig('语言 ID'),
    (10, 9) => const GameObjectDataFieldConfig('页面材质'),
    (10, 10) => const GameObjectDataFieldConfig(
      '法术 ID',
      reference: GameObjectDataReference.spell,
    ),
    (10, 11) => const GameObjectDataFieldConfig(
      '无伤害免疫',
      options: kGameObjectBooleanOptions,
    ),
    (10, 12) => const GameObjectDataFieldConfig(
      '关联陷阱',
      reference: GameObjectDataReference.gameObjectTemplate,
    ),
    (10, 13) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (10, 14) => const GameObjectDataFieldConfig('开启文本 ID'),
    (10, 15) => const GameObjectDataFieldConfig('关闭文本 ID'),
    (10, 16) => const GameObjectDataFieldConfig(
      '忽略视线',
      options: kGameObjectBooleanOptions,
    ),
    (10, 17) => const GameObjectDataFieldConfig(
      '允许骑乘使用',
      options: kGameObjectBooleanOptions,
    ),
    (10, 18) => const GameObjectDataFieldConfig(
      '浮动提示',
      options: kGameObjectBooleanOptions,
    ),
    (10, 19) => const GameObjectDataFieldConfig(
      '对话菜单',
      reference: GameObjectDataReference.gossipMenu,
    ),
    (10, 20) => const GameObjectDataFieldConfig(
      '设置世界状态',
      options: kGameObjectBooleanOptions,
    ),
    (11, 0) => const GameObjectDataFieldConfig('暂停时间'),
    (11, 1) => const GameObjectDataFieldConfig(
      '初始开启',
      options: kGameObjectBooleanOptions,
    ),
    (11, 2) => const GameObjectDataFieldConfig('自动关闭时间'),
    (11, 3) => const GameObjectDataFieldConfig('首次暂停事件'),
    (11, 4) => const GameObjectDataFieldConfig('第二次暂停事件'),
    (12, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (12, 1) => const GameObjectDataFieldConfig('半径'),
    (12, 2) => const GameObjectDataFieldConfig('最小伤害'),
    (12, 3) => const GameObjectDataFieldConfig('最大伤害'),
    (12, 4) => const GameObjectDataFieldConfig('法术学派'),
    (12, 5) => const GameObjectDataFieldConfig('自动关闭时间'),
    (12, 6) => const GameObjectDataFieldConfig('开启文本 ID'),
    (12, 7) => const GameObjectDataFieldConfig('关闭文本 ID'),
    (13, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (13, 1) => const GameObjectDataFieldConfig(
      '过场动画',
      reference: GameObjectDataReference.cinematicSequence,
    ),
    (13, 2) => const GameObjectDataFieldConfig('事件 ID'),
    (13, 3) => const GameObjectDataFieldConfig('开启文本 ID'),
    (15, 0) => const GameObjectDataFieldConfig(
      '飞行路径',
      reference: GameObjectDataReference.taxiPath,
    ),
    (15, 1) => const GameObjectDataFieldConfig('移动速度'),
    (15, 2) => const GameObjectDataFieldConfig('加速度'),
    (15, 3) => const GameObjectDataFieldConfig('开始事件 ID'),
    (15, 4) => const GameObjectDataFieldConfig('停止事件 ID'),
    (15, 5) => const GameObjectDataFieldConfig('物理行为'),
    (15, 6) => const GameObjectDataFieldConfig(
      '地图 ID',
      reference: GameObjectDataReference.map,
    ),
    (15, 7) => const GameObjectDataFieldConfig('世界状态 ID'),
    (15, 8) => const GameObjectDataFieldConfig(
      '可停止',
      options: kGameObjectBooleanOptions,
    ),
    (18, 0) => const GameObjectDataFieldConfig('参与人数'),
    (18, 1) => const GameObjectDataFieldConfig(
      '法术 ID',
      reference: GameObjectDataReference.spell,
    ),
    (18, 2) => const GameObjectDataFieldConfig(
      '动画法术',
      reference: GameObjectDataReference.spell,
    ),
    (18, 3) => const GameObjectDataFieldConfig(
      '持续存在',
      options: kGameObjectBooleanOptions,
    ),
    (18, 4) => const GameObjectDataFieldConfig(
      '施法者目标法术',
      reference: GameObjectDataReference.spell,
    ),
    (18, 5) => const GameObjectDataFieldConfig('目标数量'),
    (18, 6) => const GameObjectDataFieldConfig(
      '要求同组',
      options: kGameObjectBooleanOptions,
    ),
    (18, 7) => const GameObjectDataFieldConfig(
      '跳过目标检查',
      options: kGameObjectBooleanOptions,
    ),
    (21, 0) => const GameObjectDataFieldConfig(
      '生物模板',
      reference: GameObjectDataReference.creatureTemplate,
    ),
    (21, 1) => const GameObjectDataFieldConfig('使用次数'),
    (22, 0) => const GameObjectDataFieldConfig(
      '法术 ID',
      reference: GameObjectDataReference.spell,
    ),
    (22, 1) => const GameObjectDataFieldConfig('使用次数'),
    (22, 2) => const GameObjectDataFieldConfig(
      '仅队伍',
      options: kGameObjectBooleanOptions,
    ),
    (22, 3) => const GameObjectDataFieldConfig(
      '允许骑乘使用',
      options: kGameObjectBooleanOptions,
    ),
    (22, 4) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (23, 0) => const GameObjectDataFieldConfig('最低等级'),
    (23, 1) => const GameObjectDataFieldConfig('最高等级'),
    (23, 2) => const GameObjectDataFieldConfig(
      '区域 ID',
      reference: GameObjectDataReference.area,
    ),
    (24, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (24, 1) => const GameObjectDataFieldConfig(
      '拾取法术',
      reference: GameObjectDataReference.spell,
    ),
    (24, 2) => const GameObjectDataFieldConfig('拾取半径'),
    (24, 3) => const GameObjectDataFieldConfig(
      '归还光环',
      reference: GameObjectDataReference.spell,
    ),
    (24, 4) => const GameObjectDataFieldConfig(
      '归还法术',
      reference: GameObjectDataReference.spell,
    ),
    (24, 5) => const GameObjectDataFieldConfig(
      '无伤害免疫',
      options: kGameObjectBooleanOptions,
    ),
    (24, 6) => const GameObjectDataFieldConfig('开启文本 ID'),
    (24, 7) => const GameObjectDataFieldConfig(
      '忽略视线',
      options: kGameObjectBooleanOptions,
    ),
    (25, 0) => const GameObjectDataFieldConfig('半径'),
    (25, 1) => const GameObjectDataFieldConfig(
      '掉落模板',
      reference: GameObjectDataReference.gameObjectLoot,
    ),
    (25, 2) => const GameObjectDataFieldConfig('最少开启次数'),
    (25, 3) => const GameObjectDataFieldConfig('最多开启次数'),
    (25, 4) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (26, 0) => const GameObjectDataFieldConfig(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    (26, 1) => const GameObjectDataFieldConfig('事件 ID'),
    (26, 2) => const GameObjectDataFieldConfig(
      '拾取法术',
      reference: GameObjectDataReference.spell,
    ),
    (26, 3) => const GameObjectDataFieldConfig(
      '无伤害免疫',
      options: kGameObjectBooleanOptions,
    ),
    (26, 4) => const GameObjectDataFieldConfig('开启文本 ID'),
    (27, 0) => const GameObjectDataFieldConfig('游戏类型'),
    (29, 0) => const GameObjectDataFieldConfig('半径'),
    (29, 1) => const GameObjectDataFieldConfig(
      '法术 ID',
      reference: GameObjectDataReference.spell,
    ),
    (29, 2) => const GameObjectDataFieldConfig('世界状态 1'),
    (29, 3) => const GameObjectDataFieldConfig('世界状态 2'),
    (29, 4) => const GameObjectDataFieldConfig('占领事件 1'),
    (29, 5) => const GameObjectDataFieldConfig('占领事件 2'),
    (29, 6) => const GameObjectDataFieldConfig('争夺事件 1'),
    (29, 7) => const GameObjectDataFieldConfig('争夺事件 2'),
    (29, 8) => const GameObjectDataFieldConfig('进度事件 1'),
    (29, 9) => const GameObjectDataFieldConfig('进度事件 2'),
    (29, 10) => const GameObjectDataFieldConfig('中立事件 1'),
    (29, 11) => const GameObjectDataFieldConfig('中立事件 2'),
    (29, 12) => const GameObjectDataFieldConfig('中立百分比'),
    (29, 13) => const GameObjectDataFieldConfig('世界状态 3'),
    (29, 14) => const GameObjectDataFieldConfig('最小优势'),
    (29, 15) => const GameObjectDataFieldConfig('最大优势'),
    (29, 16) => const GameObjectDataFieldConfig('最短时间'),
    (29, 17) => const GameObjectDataFieldConfig('最长时间'),
    (29, 18) => const GameObjectDataFieldConfig(
      '大型对象',
      options: kGameObjectBooleanOptions,
    ),
    (29, 19) => const GameObjectDataFieldConfig(
      '高亮',
      options: kGameObjectBooleanOptions,
    ),
    (29, 20) => const GameObjectDataFieldConfig('初始值'),
    (29, 21) => const GameObjectDataFieldConfig(
      '单向',
      options: kGameObjectBooleanOptions,
    ),
    (30, 0) => const GameObjectDataFieldConfig(
      '初始开启',
      options: kGameObjectBooleanOptions,
    ),
    (30, 1) => const GameObjectDataFieldConfig('半径'),
    (30, 2) => const GameObjectDataFieldConfig(
      '光环法术 1',
      reference: GameObjectDataReference.spell,
    ),
    (30, 3) => const GameObjectDataFieldConfig('条件 ID 1'),
    (30, 4) => const GameObjectDataFieldConfig(
      '光环法术 2',
      reference: GameObjectDataReference.spell,
    ),
    (30, 5) => const GameObjectDataFieldConfig('条件 ID 2'),
    (30, 6) => const GameObjectDataFieldConfig(
      '仅服务端',
      options: kGameObjectBooleanOptions,
    ),
    (31, 0) => const GameObjectDataFieldConfig(
      '地图 ID',
      reference: GameObjectDataReference.map,
    ),
    (31, 1) => const GameObjectDataFieldConfig('难度 ID'),
    (32, 0) => const GameObjectDataFieldConfig(
      '椅子高度',
      options: kGameObjectChairHeightOptions,
    ),
    (32, 1) => const GameObjectDataFieldConfig('高度偏移'),
    (33, 0) => const GameObjectDataFieldConfig('完整状态生命值'),
    (33, 1) => const GameObjectDataFieldConfig(
      '奖励生物',
      reference: GameObjectDataReference.creatureTemplate,
    ),
    (33, 2) => const GameObjectDataFieldConfig('状态名称 ID'),
    (33, 3) => const GameObjectDataFieldConfig('完整状态事件'),
    (33, 4) => const GameObjectDataFieldConfig(
      '损坏显示 ID',
      reference: GameObjectDataReference.gameObjectDisplayInfo,
    ),
    (33, 5) => const GameObjectDataFieldConfig('损坏状态生命值'),
    (33, 9) => const GameObjectDataFieldConfig('损坏状态事件'),
    (33, 10) => const GameObjectDataFieldConfig(
      '摧毁显示 ID',
      reference: GameObjectDataReference.gameObjectDisplayInfo,
    ),
    (33, 14) => const GameObjectDataFieldConfig('摧毁状态事件'),
    (33, 16) => const GameObjectDataFieldConfig('重建秒数'),
    (33, 18) => const GameObjectDataFieldConfig(
      '可破坏模型数据',
      reference: GameObjectDataReference.destructibleModelData,
    ),
    (33, 19) => const GameObjectDataFieldConfig('重建状态事件'),
    (33, 22) => const GameObjectDataFieldConfig('受损事件'),
    (35, 0) => const GameObjectDataFieldConfig('暂停时触发'),
    (35, 1) => const GameObjectDataFieldConfig(
      '初始开启',
      options: kGameObjectBooleanOptions,
    ),
    (35, 2) => const GameObjectDataFieldConfig('自动关闭时间'),
    _ => _unusedGameObjectData,
  };
}
