import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/constant/spell_enums.dart';

class ConditionValueConfig {
  static final conditionAuraTypeOptions = Map<int, String>.unmodifiable(
    Map<int, String>.from(SpellEnums.spellAuraTypeOptions)..remove(0),
  );
  static const _unused = IntegerNumberFieldSpec<ConditionValueReference>(
    '未使用',
    editable: false,
  );
  static const conditionUnitStateFlags = <FlagItem>[
    FlagItem(0x00000001, '死亡'),
    FlagItem(0x00000002, '近战攻击'),
    FlagItem(0x00000004, '被魅惑'),
    FlagItem(0x00000008, '昏迷'),
    FlagItem(0x00000010, '漫游'),
    FlagItem(0x00000020, '追逐'),
    FlagItem(0x00000080, '逃跑'),
    FlagItem(0x00000100, '飞行'),
    FlagItem(0x00000200, '跟随'),
    FlagItem(0x00000400, '定身'),
    FlagItem(0x00000800, '困惑'),
    FlagItem(0x00001000, '分心'),
    FlagItem(0x00002000, '隔离'),
    FlagItem(0x00004000, '攻击玩家'),
    FlagItem(0x00008000, '施法'),
    FlagItem(0x00010000, '被占据'),
    FlagItem(0x00020000, '冲锋'),
    FlagItem(0x00040000, '跳跃'),
    FlagItem(0x00100000, '移动'),
    FlagItem(0x00200000, '旋转'),
    FlagItem(0x00400000, '闪避'),
    FlagItem(0x00800000, '漫游移动'),
    FlagItem(0x01000000, '困惑移动'),
    FlagItem(0x02000000, '逃跑移动'),
    FlagItem(0x04000000, '追逐移动'),
    FlagItem(0x08000000, '跟随移动'),
    FlagItem(0x10000000, '忽略寻路'),
    FlagItem(0x20000000, '不更新环境'),
  ];
  static const conditionTargetOptions = <int, String>{
    0: '目标 0',
    1: '目标 1',
    2: '目标 2',
  };
  static const conditionSpawnMaskFlags = <FlagItem>[
    FlagItem(0x01, '普通 / 10人普通'),
    FlagItem(0x02, '英雄 / 25人普通'),
    FlagItem(0x04, '10人英雄'),
    FlagItem(0x08, '25人英雄'),
  ];
  static const conditionReputationRankFlags = <FlagItem>[
    FlagItem(0x01, '仇恨'),
    FlagItem(0x02, '敌对'),
    FlagItem(0x04, '冷淡'),
    FlagItem(0x08, '中立'),
    FlagItem(0x10, '友善'),
    FlagItem(0x20, '尊敬'),
    FlagItem(0x40, '崇敬'),
    FlagItem(0x80, '崇拜'),
  ];
  static const conditionRaceFlags = <FlagItem>[
    FlagItem(0x001, '人类'),
    FlagItem(0x002, '兽人'),
    FlagItem(0x004, '矮人'),
    FlagItem(0x008, '暗夜精灵'),
    FlagItem(0x010, '亡灵'),
    FlagItem(0x020, '牛头人'),
    FlagItem(0x040, '侏儒'),
    FlagItem(0x080, '巨魔'),
    FlagItem(0x200, '血精灵'),
    FlagItem(0x400, '德莱尼'),
  ];
  static const conditionQuestStatusFlags = <FlagItem>[
    FlagItem(0x01, '无任务'),
    FlagItem(0x02, '已完成'),
    FlagItem(0x08, '未完成'),
    FlagItem(0x20, '失败'),
    FlagItem(0x40, '已奖励'),
  ];
  static const conditionPetTypeFlags = <FlagItem>[
    FlagItem(0x01, '召唤宠物'),
    FlagItem(0x02, '猎人宠物'),
  ];
  static const conditionObjectTypeMaskFlags = <FlagItem>[
    FlagItem(0x08, '单位'),
    FlagItem(0x10, '玩家'),
    FlagItem(0x20, '游戏对象'),
    FlagItem(0x80, '尸体'),
  ];
  static const conditionDifficultyOptions = <int, String>{
    0: '普通 / 10人普通',
    1: '英雄 / 25人普通',
    2: '史诗 / 10人英雄',
    3: '25人英雄',
  };
  static const conditionComparisonOptions = <int, String>{
    0: '等于',
    1: '大于',
    2: '小于',
    3: '大于等于',
    4: '小于等于',
  };
  static const conditionClassFlags = <FlagItem>[
    FlagItem(0x001, '战士'),
    FlagItem(0x002, '圣骑士'),
    FlagItem(0x004, '猎人'),
    FlagItem(0x008, '潜行者'),
    FlagItem(0x010, '牧师'),
    FlagItem(0x020, '死亡骑士'),
    FlagItem(0x040, '萨满祭司'),
    FlagItem(0x080, '法师'),
    FlagItem(0x100, '术士'),
    FlagItem(0x400, '德鲁伊'),
  ];
  static const conditionBooleanOptions = <int, String>{0: '否', 1: '是'};

  static ConditionValueConfig forType(int type, {int value1 = 0}) {
    if (type < 0) return const ConditionValueConfig(_unused, _unused, _unused);
    if (type == 31) {
      return _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '对象类型',
          options: {3: '单位', 4: '玩家', 5: '游戏对象', 7: '尸体'},
        ),
        switch (value1) {
          3 => const IntegerReferenceFieldSpec<ConditionValueReference>(
            '对象条目',
            reference: ConditionValueReference.creature,
          ),
          5 => const IntegerReferenceFieldSpec<ConditionValueReference>(
            '对象条目',
            reference: ConditionValueReference.gameObject,
          ),
          _ => const IntegerNumberFieldSpec<ConditionValueReference>('对象条目'),
        },
        const IntegerNumberFieldSpec<ConditionValueReference>('生成/可攻击'),
      );
    }
    if (type == 42) {
      return _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '状态模式',
          options: {0: '精确状态', 1: '站立/坐下分类'},
        ),
        IntegerSelectFieldSpec<ConditionValueReference>(
          '站立状态',
          options: value1 == 0
              ? const {
                  0: '站立',
                  1: '坐下',
                  2: '坐椅',
                  3: '睡眠',
                  4: '低椅',
                  5: '中椅',
                  6: '高椅',
                  7: '死亡',
                  8: '跪下',
                  9: '浸没',
                }
              : ConditionValueConfig.conditionBooleanOptions,
        ),
      );
    }
    return switch (type) {
      1 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '法术 ID',
          reference: ConditionValueReference.spell,
        ),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '效果索引',
          options: {0: '效果 0', 1: '效果 1', 2: '效果 2'},
        ),
      ),
      2 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '物品 ID',
          reference: ConditionValueReference.item,
        ),
        const IntegerNumberFieldSpec<ConditionValueReference>('数量'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '包含银行',
          options: ConditionValueConfig.conditionBooleanOptions,
        ),
      ),
      3 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '物品 ID',
          reference: ConditionValueReference.item,
        ),
      ),
      4 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '区域 ID',
          reference: ConditionValueReference.area,
        ),
      ),
      5 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '阵营 ID',
          reference: ConditionValueReference.faction,
        ),
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '声望等级掩码',
          flags: ConditionValueConfig.conditionReputationRankFlags,
        ),
      ),
      6 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '阵营',
          options: {469: '联盟', 67: '部落'},
        ),
      ),
      7 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '技能线 ID',
          reference: ConditionValueReference.skill,
        ),
        const IntegerNumberFieldSpec<ConditionValueReference>('技能值'),
      ),
      8 || 9 || 14 || 28 || 43 || 101 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '任务 ID',
          reference: ConditionValueReference.quest,
        ),
      ),
      10 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '最低醉酒状态',
          options: {0: '清醒', 1: '微醺', 2: '醉酒', 3: '酩酊'},
        ),
      ),
      11 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('世界状态 ID'),
        const IntegerNumberFieldSpec<ConditionValueReference>('数值'),
      ),
      12 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('游戏事件 ID'),
      ),
      13 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('数据条目'),
        const IntegerNumberFieldSpec<ConditionValueReference>('期望值'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '实例信息类型',
          options: {0: '数据', 1: 'GUID 数据', 2: '首领状态', 3: '64位数据'},
        ),
      ),
      15 => _config(
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '职业掩码',
          flags: ConditionValueConfig.conditionClassFlags,
        ),
      ),
      16 => _config(
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '种族掩码',
          flags: ConditionValueConfig.conditionRaceFlags,
        ),
      ),
      17 || 39 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '成就 ID',
          reference: ConditionValueReference.achievement,
        ),
      ),
      18 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '称号 ID',
          reference: ConditionValueReference.title,
        ),
      ),
      19 => _config(
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '生成模式掩码',
          flags: ConditionValueConfig.conditionSpawnMaskFlags,
        ),
      ),
      20 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '性别',
          options: {0: '男性', 1: '女性'},
        ),
      ),
      21 => _config(
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '单位状态掩码',
          flags: ConditionValueConfig.conditionUnitStateFlags,
        ),
      ),
      22 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '地图 ID',
          reference: ConditionValueReference.map,
        ),
      ),
      23 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '区域 ID',
          reference: ConditionValueReference.area,
        ),
      ),
      24 => _config(
        IntegerSelectFieldSpec<ConditionValueReference>(
          '生物类型',
          options: {
            for (final entry in CreatureEnums.creatureTypeOptions.entries)
              if (entry.key != 0) entry.key: entry.value,
          },
        ),
      ),
      25 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '法术 ID',
          reference: ConditionValueReference.spell,
        ),
      ),
      26 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('相位掩码'),
      ),
      27 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('等级'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '比较类型',
          options: ConditionValueConfig.conditionComparisonOptions,
        ),
      ),
      29 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '生物 Entry',
          reference: ConditionValueReference.creature,
        ),
        const IntegerNumberFieldSpec<ConditionValueReference>('搜索距离'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '搜索死亡生物',
          options: ConditionValueConfig.conditionBooleanOptions,
        ),
      ),
      30 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '游戏对象 ID',
          reference: ConditionValueReference.gameObject,
        ),
        const IntegerNumberFieldSpec<ConditionValueReference>('搜索距离'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '对象状态',
          options: {0: '不检查', 1: '就绪', 2: '非就绪'},
        ),
      ),
      32 => _config(
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '对象类型掩码',
          flags: ConditionValueConfig.conditionObjectTypeMaskFlags,
        ),
      ),
      33 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '另一条件目标',
          options: ConditionValueConfig.conditionTargetOptions,
        ),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '关系类型',
          options: {
            0: '自身',
            1: '同队伍',
            2: '同团队或队伍',
            3: '被其拥有',
            4: '其载具乘客',
            5: '由其创建',
          },
        ),
      ),
      34 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '另一条件目标',
          options: ConditionValueConfig.conditionTargetOptions,
        ),
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '反应等级掩码',
          flags: ConditionValueConfig.conditionReputationRankFlags,
        ),
      ),
      35 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '另一条件目标',
          options: ConditionValueConfig.conditionTargetOptions,
        ),
        const IntegerNumberFieldSpec<ConditionValueReference>('距离'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '比较类型',
          options: ConditionValueConfig.conditionComparisonOptions,
        ),
      ),
      36 ||
      40 ||
      44 ||
      46 ||
      106 => const ConditionValueConfig(_unused, _unused, _unused),
      37 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('生命值'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '比较类型',
          options: ConditionValueConfig.conditionComparisonOptions,
        ),
      ),
      38 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('生命值百分比'),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '比较类型',
          options: ConditionValueConfig.conditionComparisonOptions,
        ),
      ),
      45 => _config(
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '宠物类型掩码',
          flags: ConditionValueConfig.conditionPetTypeFlags,
        ),
      ),
      47 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '任务 ID',
          reference: ConditionValueReference.quest,
        ),
        const IntegerFlagsFieldSpec<ConditionValueReference>(
          '任务状态掩码',
          flags: ConditionValueConfig.conditionQuestStatusFlags,
        ),
      ),
      48 => _config(
        IntegerReferenceFieldSpec<ConditionValueReference>(
          '任务 ID',
          reference: ConditionValueReference.quest,
        ),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '目标索引',
          options: {0: '目标 0', 1: '目标 1', 2: '目标 2', 3: '目标 3'},
        ),
        const IntegerNumberFieldSpec<ConditionValueReference>('目标计数'),
      ),
      49 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '地图难度',
          options: ConditionValueConfig.conditionDifficultyOptions,
        ),
      ),
      102 => _config(
        IntegerSelectFieldSpec<ConditionValueReference>(
          '光环类型',
          options: ConditionValueConfig.conditionAuraTypeOptions,
        ),
      ),
      103 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('世界脚本 ID'),
        const IntegerNumberFieldSpec<ConditionValueReference>('状态'),
      ),
      104 => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('AI 数据 ID'),
        const IntegerNumberFieldSpec<ConditionValueReference>('期望值'),
      ),
      105 => _config(
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '检查当前难度',
          options: ConditionValueConfig.conditionBooleanOptions,
        ),
        const IntegerSelectFieldSpec<ConditionValueReference>(
          '地图难度',
          options: ConditionValueConfig.conditionDifficultyOptions,
        ),
      ),
      _ => _config(
        const IntegerNumberFieldSpec<ConditionValueReference>('参数 1'),
        const IntegerNumberFieldSpec<ConditionValueReference>('参数 2'),
        const IntegerNumberFieldSpec<ConditionValueReference>('参数 3'),
      ),
    };
  }

  static ConditionValueConfig _config(
    IntegerFieldSpec<ConditionValueReference> value1, [
    IntegerFieldSpec<ConditionValueReference> value2 = _unused,
    IntegerFieldSpec<ConditionValueReference> value3 = _unused,
  ]) => ConditionValueConfig(value1, value2, value3);

  final IntegerFieldSpec<ConditionValueReference> value1;
  final IntegerFieldSpec<ConditionValueReference> value2;
  final IntegerFieldSpec<ConditionValueReference> value3;

  const ConditionValueConfig(this.value1, this.value2, this.value3);
}

enum ConditionValueReference {
  achievement,
  area,
  creature,
  faction,
  gameObject,
  item,
  map,
  quest,
  skill,
  spell,
  title,
}
