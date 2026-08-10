import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/integer_field_spec.dart';

abstract final class GameObjectConstants {
  static const unusedGameObjectDataField =
      IntegerNumberFieldSpec<GameObjectDataReference>('未使用', editable: false);

  /// `SharedDefines.h::GameobjectTypes`, 0..35 in 3.3.5a.
  static const gameObjectTypeOptions = <int, String>{
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
  static const gameObjectTrapTypeOptions = <int, String>{
    0: '非炸弹陷阱',
    1: '炸弹陷阱',
    2: '自动关闭陷阱',
  };

  /// Bits of `GameObjectFlags` actually used by AzerothCore.
  static const gameObjectFlagItems = <FlagItem>[
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

  /// Schema registry of the `GameObjectData.h::GameObjectTemplate` union,
  /// grouped by GameObject type.
  static const gameObjectDataSchemas = <int, GameObjectDataSchema>{
    // GameObjectDoor
    0: GameObjectDataSchema({
      0: IntegerSelectFieldSpec(
        '初始开启',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      1: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      2: IntegerNumberFieldSpec('自动关闭时间'),
      3: IntegerSelectFieldSpec(
        '无伤害免疫',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerNumberFieldSpec('开启文本 ID'),
      5: IntegerNumberFieldSpec('关闭文本 ID'),
      6: IntegerSelectFieldSpec(
        '寻路忽略',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectButton
    1: GameObjectDataSchema({
      0: IntegerSelectFieldSpec(
        '初始开启',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      1: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      2: IntegerNumberFieldSpec('自动关闭时间'),
      3: IntegerReferenceFieldSpec(
        '关联陷阱',
        reference: GameObjectDataReference.gameObjectTemplate,
      ),
      4: IntegerSelectFieldSpec(
        '无伤害免疫',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      5: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      6: IntegerNumberFieldSpec('开启文本 ID'),
      7: IntegerNumberFieldSpec('关闭文本 ID'),
      8: IntegerSelectFieldSpec(
        '忽略视线',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectQuestGiver
    2: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerNumberFieldSpec('任务列表 ID'),
      2: IntegerNumberFieldSpec('页面材质'),
      3: IntegerReferenceFieldSpec(
        '对话菜单',
        reference: GameObjectDataReference.gossipMenu,
      ),
      4: IntegerNumberFieldSpec('自定义动画'),
      5: IntegerSelectFieldSpec(
        '无伤害免疫',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      6: IntegerNumberFieldSpec('开启文本 ID'),
      7: IntegerSelectFieldSpec(
        '忽略视线',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      8: IntegerSelectFieldSpec(
        '允许骑乘使用',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      9: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectChest
    3: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerReferenceFieldSpec(
        '掉落模板',
        reference: GameObjectDataReference.gameObjectLoot,
      ),
      2: IntegerNumberFieldSpec('刷新时间'),
      3: IntegerSelectFieldSpec(
        '消耗型',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerNumberFieldSpec('废弃最少次数'),
      5: IntegerNumberFieldSpec('废弃最多次数'),
      6: IntegerNumberFieldSpec('事件 ID'),
      7: IntegerReferenceFieldSpec(
        '关联陷阱',
        reference: GameObjectDataReference.gameObjectTemplate,
      ),
      8: IntegerReferenceFieldSpec(
        '任务 ID',
        reference: GameObjectDataReference.questTemplate,
      ),
      9: IntegerNumberFieldSpec('等级'),
      10: IntegerSelectFieldSpec(
        '忽略视线',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      11: IntegerSelectFieldSpec(
        '离开保留掉落',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      12: IntegerSelectFieldSpec(
        '不受战斗限制',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      13: IntegerSelectFieldSpec(
        '记录掉落',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      14: IntegerNumberFieldSpec('开启文本 ID'),
      15: IntegerSelectFieldSpec(
        '组掉落规则',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      16: IntegerSelectFieldSpec(
        '浮动提示',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectGeneric
    5: GameObjectDataSchema({
      0: IntegerSelectFieldSpec(
        '浮动提示',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      1: IntegerSelectFieldSpec(
        '高亮',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      2: IntegerSelectFieldSpec(
        '仅服务端',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      3: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerSelectFieldSpec(
        '水面漂浮',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      5: IntegerReferenceFieldSpec(
        '任务 ID',
        reference: GameObjectDataReference.questTemplate,
      ),
    }),
    // GameObjectTrap
    6: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerNumberFieldSpec('等级'),
      2: IntegerNumberFieldSpec('触发直径'),
      3: IntegerReferenceFieldSpec(
        '法术 ID',
        reference: GameObjectDataReference.spell,
      ),
      4: IntegerSelectFieldSpec(
        '陷阱类型',
        options: GameObjectConstants.gameObjectTrapTypeOptions,
      ),
      5: IntegerNumberFieldSpec('冷却时间'),
      6: IntegerNumberFieldSpec('自动关闭时间'),
      7: IntegerNumberFieldSpec('启动延迟'),
      8: IntegerSelectFieldSpec(
        '仅服务端',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      9: IntegerSelectFieldSpec(
        '潜行',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      10: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      11: IntegerSelectFieldSpec(
        '不可见',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      12: IntegerNumberFieldSpec('开启文本 ID'),
      13: IntegerNumberFieldSpec('关闭文本 ID'),
      14: IntegerSelectFieldSpec(
        '忽略图腾',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectChair
    7: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('座位数量'),
      1: IntegerSelectFieldSpec(
        '椅子高度',
        options: GameObjectConstants.gameObjectChairHeightOptions,
      ),
      2: IntegerSelectFieldSpec(
        '仅创建者使用',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      3: IntegerNumberFieldSpec('触发事件 ID'),
    }),
    // GameObjectSpellFocus
    8: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '法术焦点 ID',
        reference: GameObjectDataReference.spellFocusObject,
      ),
      1: IntegerNumberFieldSpec('作用距离'),
      2: IntegerReferenceFieldSpec(
        '关联陷阱',
        reference: GameObjectDataReference.gameObjectTemplate,
      ),
      3: IntegerSelectFieldSpec(
        '仅服务端',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerReferenceFieldSpec(
        '任务 ID',
        reference: GameObjectDataReference.questTemplate,
      ),
      5: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      6: IntegerSelectFieldSpec(
        '浮动提示',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectText
    9: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '页面文本',
        reference: GameObjectDataReference.pageText,
      ),
      1: IntegerNumberFieldSpec('语言 ID'),
      2: IntegerNumberFieldSpec('页面材质'),
      3: IntegerSelectFieldSpec(
        '允许骑乘使用',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectGoober
    10: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerReferenceFieldSpec(
        '任务 ID',
        reference: GameObjectDataReference.questTemplate,
      ),
      2: IntegerNumberFieldSpec('事件 ID'),
      3: IntegerNumberFieldSpec('自动关闭时间'),
      4: IntegerNumberFieldSpec('自定义动画'),
      5: IntegerSelectFieldSpec(
        '消耗型',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      6: IntegerNumberFieldSpec('冷却时间'),
      7: IntegerReferenceFieldSpec(
        '页面文本',
        reference: GameObjectDataReference.pageText,
      ),
      8: IntegerNumberFieldSpec('语言 ID'),
      9: IntegerNumberFieldSpec('页面材质'),
      10: IntegerReferenceFieldSpec(
        '法术 ID',
        reference: GameObjectDataReference.spell,
      ),
      11: IntegerSelectFieldSpec(
        '无伤害免疫',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      12: IntegerReferenceFieldSpec(
        '关联陷阱',
        reference: GameObjectDataReference.gameObjectTemplate,
      ),
      13: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      14: IntegerNumberFieldSpec('开启文本 ID'),
      15: IntegerNumberFieldSpec('关闭文本 ID'),
      16: IntegerSelectFieldSpec(
        '忽略视线',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      17: IntegerSelectFieldSpec(
        '允许骑乘使用',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      18: IntegerSelectFieldSpec(
        '浮动提示',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      19: IntegerReferenceFieldSpec(
        '对话菜单',
        reference: GameObjectDataReference.gossipMenu,
      ),
      20: IntegerSelectFieldSpec(
        '设置世界状态',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectTransport
    11: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('暂停时间'),
      1: IntegerSelectFieldSpec(
        '初始开启',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      2: IntegerNumberFieldSpec('自动关闭时间'),
      3: IntegerNumberFieldSpec('首次暂停事件'),
      4: IntegerNumberFieldSpec('二次暂停事件'),
    }),
    // GameObjectAreaDamage
    12: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerNumberFieldSpec('半径'),
      2: IntegerNumberFieldSpec('最小伤害'),
      3: IntegerNumberFieldSpec('最大伤害'),
      4: IntegerNumberFieldSpec('法术学派'),
      5: IntegerNumberFieldSpec('自动关闭时间'),
      6: IntegerNumberFieldSpec('开启文本 ID'),
      7: IntegerNumberFieldSpec('关闭文本 ID'),
    }),
    // GameObjectCamera
    13: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerReferenceFieldSpec(
        '过场动画',
        reference: GameObjectDataReference.cinematicSequence,
      ),
      2: IntegerNumberFieldSpec('事件 ID'),
      3: IntegerNumberFieldSpec('开启文本 ID'),
    }),
    // GameObjectMapObjTransport
    15: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '飞行路径',
        reference: GameObjectDataReference.taxiPath,
      ),
      1: IntegerNumberFieldSpec('移动速度'),
      2: IntegerNumberFieldSpec('加速度'),
      3: IntegerNumberFieldSpec('开始事件 ID'),
      4: IntegerNumberFieldSpec('停止事件 ID'),
      5: IntegerNumberFieldSpec('物理行为'),
      6: IntegerReferenceFieldSpec(
        '地图 ID',
        reference: GameObjectDataReference.map,
      ),
      7: IntegerNumberFieldSpec('世界状态 ID'),
      8: IntegerSelectFieldSpec(
        '可停止',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectRitual
    18: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('参与人数'),
      1: IntegerReferenceFieldSpec(
        '法术 ID',
        reference: GameObjectDataReference.spell,
      ),
      2: IntegerReferenceFieldSpec(
        '动画法术',
        reference: GameObjectDataReference.spell,
      ),
      3: IntegerSelectFieldSpec(
        '持续存在',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerReferenceFieldSpec(
        '施法目标法术',
        reference: GameObjectDataReference.spell,
      ),
      5: IntegerNumberFieldSpec('目标数量'),
      6: IntegerSelectFieldSpec(
        '要求同组',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      7: IntegerSelectFieldSpec(
        '跳过目标检查',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectGuardPost
    21: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '生物模板',
        reference: GameObjectDataReference.creatureTemplate,
      ),
      1: IntegerNumberFieldSpec('使用次数'),
    }),
    // GameObjectSpellCaster
    22: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '法术 ID',
        reference: GameObjectDataReference.spell,
      ),
      1: IntegerNumberFieldSpec('使用次数'),
      2: IntegerSelectFieldSpec(
        '仅队伍',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      3: IntegerSelectFieldSpec(
        '允许骑乘使用',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectMeetingStone
    23: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('最低等级'),
      1: IntegerNumberFieldSpec('最高等级'),
      2: IntegerReferenceFieldSpec(
        '区域 ID',
        reference: GameObjectDataReference.area,
      ),
    }),
    // GameObjectFlagStand
    24: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerReferenceFieldSpec(
        '拾取法术',
        reference: GameObjectDataReference.spell,
      ),
      2: IntegerNumberFieldSpec('拾取半径'),
      3: IntegerReferenceFieldSpec(
        '归还光环',
        reference: GameObjectDataReference.spell,
      ),
      4: IntegerReferenceFieldSpec(
        '归还法术',
        reference: GameObjectDataReference.spell,
      ),
      5: IntegerSelectFieldSpec(
        '无伤害免疫',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      6: IntegerNumberFieldSpec('开启文本 ID'),
      7: IntegerSelectFieldSpec(
        '忽略视线',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectFishingHole
    25: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('半径'),
      1: IntegerReferenceFieldSpec(
        '掉落模板',
        reference: GameObjectDataReference.gameObjectLoot,
      ),
      2: IntegerNumberFieldSpec('最少开启次数'),
      3: IntegerNumberFieldSpec('最多开启次数'),
      4: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
    }),
    // GameObjectFlagDrop
    26: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '锁 ID',
        reference: GameObjectDataReference.lock,
      ),
      1: IntegerNumberFieldSpec('事件 ID'),
      2: IntegerReferenceFieldSpec(
        '拾取法术',
        reference: GameObjectDataReference.spell,
      ),
      3: IntegerSelectFieldSpec(
        '无伤害免疫',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      4: IntegerNumberFieldSpec('开启文本 ID'),
    }),
    // GameObjectMiniGame
    27: GameObjectDataSchema({0: IntegerNumberFieldSpec('游戏类型')}),
    // GameObjectCapturePoint
    29: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('半径'),
      1: IntegerReferenceFieldSpec(
        '法术 ID',
        reference: GameObjectDataReference.spell,
      ),
      2: IntegerNumberFieldSpec('世界状态 1'),
      3: IntegerNumberFieldSpec('世界状态 2'),
      4: IntegerNumberFieldSpec('占领事件 1'),
      5: IntegerNumberFieldSpec('占领事件 2'),
      6: IntegerNumberFieldSpec('争夺事件 1'),
      7: IntegerNumberFieldSpec('争夺事件 2'),
      8: IntegerNumberFieldSpec('进度事件 1'),
      9: IntegerNumberFieldSpec('进度事件 2'),
      10: IntegerNumberFieldSpec('中立事件 1'),
      11: IntegerNumberFieldSpec('中立事件 2'),
      12: IntegerNumberFieldSpec('中立百分比'),
      13: IntegerNumberFieldSpec('世界状态 3'),
      14: IntegerNumberFieldSpec('最小优势'),
      15: IntegerNumberFieldSpec('最大优势'),
      16: IntegerNumberFieldSpec('最短时间'),
      17: IntegerNumberFieldSpec('最长时间'),
      18: IntegerSelectFieldSpec(
        '大型对象',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      19: IntegerSelectFieldSpec(
        '高亮',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      20: IntegerNumberFieldSpec('初始值'),
      21: IntegerSelectFieldSpec(
        '单向',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectAuraGenerator
    30: GameObjectDataSchema({
      0: IntegerSelectFieldSpec(
        '初始开启',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      1: IntegerNumberFieldSpec('半径'),
      2: IntegerReferenceFieldSpec(
        '光环法术 1',
        reference: GameObjectDataReference.spell,
      ),
      3: IntegerNumberFieldSpec('条件 ID 1'),
      4: IntegerReferenceFieldSpec(
        '光环法术 2',
        reference: GameObjectDataReference.spell,
      ),
      5: IntegerNumberFieldSpec('条件 ID 2'),
      6: IntegerSelectFieldSpec(
        '仅服务端',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
    }),
    // GameObjectDungeonDifficulty
    31: GameObjectDataSchema({
      0: IntegerReferenceFieldSpec(
        '地图 ID',
        reference: GameObjectDataReference.map,
      ),
      1: IntegerNumberFieldSpec('难度 ID'),
    }),
    // GameObjectBarberChair
    32: GameObjectDataSchema({
      0: IntegerSelectFieldSpec(
        '椅子高度',
        options: GameObjectConstants.gameObjectChairHeightOptions,
      ),
      1: IntegerNumberFieldSpec('高度偏移'),
    }),
    // GameObjectDestructibleBuilding
    33: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('完整态生命值'),
      1: IntegerReferenceFieldSpec(
        '奖励生物',
        reference: GameObjectDataReference.creatureTemplate,
      ),
      2: IntegerNumberFieldSpec('状态名称 ID'),
      3: IntegerNumberFieldSpec('完整状态事件'),
      4: IntegerReferenceFieldSpec(
        '损坏显示 ID',
        reference: GameObjectDataReference.gameObjectDisplayInfo,
      ),
      5: IntegerNumberFieldSpec('损坏态生命值'),
      9: IntegerNumberFieldSpec('损坏状态事件'),
      10: IntegerReferenceFieldSpec(
        '摧毁显示 ID',
        reference: GameObjectDataReference.gameObjectDisplayInfo,
      ),
      14: IntegerNumberFieldSpec('摧毁状态事件'),
      16: IntegerNumberFieldSpec('重建秒数'),
      18: IntegerReferenceFieldSpec(
        '可破坏模型',
        reference: GameObjectDataReference.destructibleModelData,
      ),
      19: IntegerNumberFieldSpec('重建状态事件'),
      22: IntegerNumberFieldSpec('受损事件'),
    }),
    // GameObjectTrapDoor
    35: GameObjectDataSchema({
      0: IntegerNumberFieldSpec('暂停时触发'),
      1: IntegerSelectFieldSpec(
        '初始开启',
        options: GameObjectConstants.gameObjectBooleanOptions,
      ),
      2: IntegerNumberFieldSpec('自动关闭时间'),
    }),
  };
  static const gameObjectChairHeightOptions = <int, String>{
    0: '低',
    1: '中',
    2: '高',
  };
  static const gameObjectBooleanOptions = <int, String>{0: '否', 1: '是'};

  /// Looks up the edit spec for a Data slot of a GameObject type.
  ///
  /// Missing slots uniformly fall back to a read-only "unused" spec; sparse
  /// types (e.g. 33) need no placeholders.
  static IntegerFieldSpec<GameObjectDataReference> dataFieldSpec(
    int type,
    int index,
  ) {
    RangeError.checkValueInInterval(index, 0, 23, 'index');
    return GameObjectConstants.gameObjectDataSchemas[type]?.field(index) ??
        GameObjectConstants.unusedGameObjectDataField;
  }
}

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

/// Edit specs for Data0..Data23 of one GameObject type.
///
/// Corresponds to one struct of the
/// `GameObjectData.h::GameObjectTemplate` union; the Map only writes actual
/// fields, missing slots fall back through [field] to a read-only "unused"
/// spec.
class GameObjectDataSchema {
  final Map<int, IntegerFieldSpec<GameObjectDataReference>> fields;

  const GameObjectDataSchema(this.fields);

  IntegerFieldSpec<GameObjectDataReference> field(int index) =>
      fields[index] ?? GameObjectConstants.unusedGameObjectDataField;
}
