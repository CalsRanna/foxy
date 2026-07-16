import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/spell_enums.dart';

const kConditionBooleanOptions = <int, String>{0: '否', 1: '是'};

const kConditionClassFlags = <FlagItem>[
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

const kConditionComparisonOptions = <int, String>{
  0: '等于',
  1: '大于',
  2: '小于',
  3: '大于等于',
  4: '小于等于',
};

const kConditionDifficultyOptions = <int, String>{
  0: '普通 / 10人普通',
  1: '英雄 / 25人普通',
  2: '史诗 / 10人英雄',
  3: '25人英雄',
};
const kConditionObjectTypeMaskFlags = <FlagItem>[
  FlagItem(0x08, '单位'),
  FlagItem(0x10, '玩家'),
  FlagItem(0x20, '游戏对象'),
  FlagItem(0x80, '尸体'),
];
const kConditionPetTypeFlags = <FlagItem>[
  FlagItem(0x01, '召唤宠物'),
  FlagItem(0x02, '猎人宠物'),
];
const kConditionQuestStatusFlags = <FlagItem>[
  FlagItem(0x01, '无任务'),
  FlagItem(0x02, '已完成'),
  FlagItem(0x08, '未完成'),
  FlagItem(0x20, '失败'),
  FlagItem(0x40, '已奖励'),
];

const kConditionRaceFlags = <FlagItem>[
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

const kConditionReputationRankFlags = <FlagItem>[
  FlagItem(0x01, '仇恨'),
  FlagItem(0x02, '敌对'),
  FlagItem(0x04, '冷淡'),
  FlagItem(0x08, '中立'),
  FlagItem(0x10, '友善'),
  FlagItem(0x20, '尊敬'),
  FlagItem(0x40, '崇敬'),
  FlagItem(0x80, '崇拜'),
];

const kConditionSpawnMaskFlags = <FlagItem>[
  FlagItem(0x01, '普通 / 10人普通'),
  FlagItem(0x02, '英雄 / 25人普通'),
  FlagItem(0x04, '10人英雄'),
  FlagItem(0x08, '25人英雄'),
];

const kConditionTargetOptions = <int, String>{0: '目标 0', 1: '目标 1', 2: '目标 2'};

const kConditionUnitStateFlags = <FlagItem>[
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

const _unused = ConditionValueFieldConfig('未使用', editable: false);

final kConditionAuraTypeOptions = Map<int, String>.unmodifiable(
  Map<int, String>.from(kSpellAuraTypeOptions)..remove(0),
);

ConditionValueConfig conditionValueConfig(int type, {int value1 = 0}) {
  if (type < 0) return const ConditionValueConfig(_unused, _unused, _unused);
  if (type == 31) {
    final entryReference = switch (value1) {
      3 => ConditionValueReference.creature,
      5 => ConditionValueReference.gameObject,
      _ => ConditionValueReference.none,
    };
    return _config(
      const ConditionValueFieldConfig(
        '对象类型',
        options: {3: '单位', 4: '玩家', 5: '游戏对象', 7: '尸体'},
      ),
      ConditionValueFieldConfig('对象条目', reference: entryReference),
      const ConditionValueFieldConfig('生成 GUID / 可攻击检查'),
    );
  }
  if (type == 42) {
    return _config(
      const ConditionValueFieldConfig(
        '状态模式',
        options: {0: '精确状态', 1: '站立/坐下分类'},
      ),
      ConditionValueFieldConfig(
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
            : kConditionBooleanOptions,
      ),
    );
  }
  return switch (type) {
    1 => _config(
      _reference('法术 ID', ConditionValueReference.spell),
      const ConditionValueFieldConfig(
        '效果索引',
        options: {0: '效果 0', 1: '效果 1', 2: '效果 2'},
      ),
    ),
    2 => _config(
      _reference('物品 ID', ConditionValueReference.item),
      const ConditionValueFieldConfig('数量'),
      const ConditionValueFieldConfig(
        '包含银行',
        options: kConditionBooleanOptions,
      ),
    ),
    3 => _config(_reference('物品 ID', ConditionValueReference.item)),
    4 => _config(_reference('区域 ID', ConditionValueReference.area)),
    5 => _config(
      _reference('阵营 ID', ConditionValueReference.faction),
      const ConditionValueFieldConfig(
        '声望等级掩码',
        flags: kConditionReputationRankFlags,
      ),
    ),
    6 => _config(
      const ConditionValueFieldConfig('阵营', options: {469: '联盟', 67: '部落'}),
    ),
    7 => _config(
      _reference('技能线 ID', ConditionValueReference.skill),
      const ConditionValueFieldConfig('技能值'),
    ),
    8 ||
    9 ||
    14 ||
    28 ||
    43 ||
    101 => _config(_reference('任务 ID', ConditionValueReference.quest)),
    10 => _config(
      const ConditionValueFieldConfig(
        '最低醉酒状态',
        options: {0: '清醒', 1: '微醺', 2: '醉酒', 3: '酩酊'},
      ),
    ),
    11 => _config(
      const ConditionValueFieldConfig('世界状态 ID'),
      const ConditionValueFieldConfig('数值'),
    ),
    12 => _config(const ConditionValueFieldConfig('游戏事件 ID')),
    13 => _config(
      const ConditionValueFieldConfig('数据条目'),
      const ConditionValueFieldConfig('期望值'),
      const ConditionValueFieldConfig(
        '实例信息类型',
        options: {0: '数据', 1: 'GUID 数据', 2: '首领状态', 3: '64位数据'},
      ),
    ),
    15 => _config(
      const ConditionValueFieldConfig('职业掩码', flags: kConditionClassFlags),
    ),
    16 => _config(
      const ConditionValueFieldConfig('种族掩码', flags: kConditionRaceFlags),
    ),
    17 ||
    39 => _config(_reference('成就 ID', ConditionValueReference.achievement)),
    18 => _config(_reference('称号 ID', ConditionValueReference.title)),
    19 => _config(
      const ConditionValueFieldConfig(
        '生成模式掩码',
        flags: kConditionSpawnMaskFlags,
      ),
    ),
    20 => _config(
      const ConditionValueFieldConfig('性别', options: {0: '男性', 1: '女性'}),
    ),
    21 => _config(
      const ConditionValueFieldConfig(
        '单位状态掩码',
        flags: kConditionUnitStateFlags,
      ),
    ),
    22 => _config(_reference('地图 ID', ConditionValueReference.map)),
    23 => _config(_reference('区域 ID', ConditionValueReference.area)),
    24 => _config(
      ConditionValueFieldConfig(
        '生物类型',
        options: {
          for (final entry in kCreatureTypeOptions.entries)
            if (entry.key != 0) entry.key: entry.value,
        },
      ),
    ),
    25 => _config(_reference('法术 ID', ConditionValueReference.spell)),
    26 => _config(const ConditionValueFieldConfig('相位掩码')),
    27 => _config(
      const ConditionValueFieldConfig('等级'),
      const ConditionValueFieldConfig(
        '比较类型',
        options: kConditionComparisonOptions,
      ),
    ),
    29 => _config(
      _reference('生物 Entry', ConditionValueReference.creature),
      const ConditionValueFieldConfig('搜索距离'),
      const ConditionValueFieldConfig(
        '搜索死亡生物',
        options: kConditionBooleanOptions,
      ),
    ),
    30 => _config(
      _reference('游戏对象 Entry', ConditionValueReference.gameObject),
      const ConditionValueFieldConfig('搜索距离'),
      const ConditionValueFieldConfig(
        '对象状态',
        options: {0: '不检查', 1: '就绪', 2: '非就绪'},
      ),
    ),
    32 => _config(
      const ConditionValueFieldConfig(
        '对象类型掩码',
        flags: kConditionObjectTypeMaskFlags,
      ),
    ),
    33 => _config(
      const ConditionValueFieldConfig(
        '另一条件目标',
        options: kConditionTargetOptions,
      ),
      const ConditionValueFieldConfig(
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
      const ConditionValueFieldConfig(
        '另一条件目标',
        options: kConditionTargetOptions,
      ),
      const ConditionValueFieldConfig(
        '反应等级掩码',
        flags: kConditionReputationRankFlags,
      ),
    ),
    35 => _config(
      const ConditionValueFieldConfig(
        '另一条件目标',
        options: kConditionTargetOptions,
      ),
      const ConditionValueFieldConfig('距离'),
      const ConditionValueFieldConfig(
        '比较类型',
        options: kConditionComparisonOptions,
      ),
    ),
    36 ||
    40 ||
    44 ||
    46 ||
    106 => const ConditionValueConfig(_unused, _unused, _unused),
    37 => _config(
      const ConditionValueFieldConfig('生命值'),
      const ConditionValueFieldConfig(
        '比较类型',
        options: kConditionComparisonOptions,
      ),
    ),
    38 => _config(
      const ConditionValueFieldConfig('生命值百分比'),
      const ConditionValueFieldConfig(
        '比较类型',
        options: kConditionComparisonOptions,
      ),
    ),
    45 => _config(
      const ConditionValueFieldConfig('宠物类型掩码', flags: kConditionPetTypeFlags),
    ),
    47 => _config(
      _reference('任务 ID', ConditionValueReference.quest),
      const ConditionValueFieldConfig(
        '任务状态掩码',
        flags: kConditionQuestStatusFlags,
      ),
    ),
    48 => _config(
      _reference('任务 ID', ConditionValueReference.quest),
      const ConditionValueFieldConfig(
        '目标索引',
        options: {0: '目标 0', 1: '目标 1', 2: '目标 2', 3: '目标 3'},
      ),
      const ConditionValueFieldConfig('目标计数'),
    ),
    49 => _config(
      const ConditionValueFieldConfig(
        '地图难度',
        options: kConditionDifficultyOptions,
      ),
    ),
    102 => _config(
      ConditionValueFieldConfig('光环类型', options: kConditionAuraTypeOptions),
    ),
    103 => _config(
      const ConditionValueFieldConfig('世界脚本条件 ID'),
      const ConditionValueFieldConfig('状态'),
    ),
    104 => _config(
      const ConditionValueFieldConfig('AI 数据 ID'),
      const ConditionValueFieldConfig('期望值'),
    ),
    105 => _config(
      const ConditionValueFieldConfig(
        '检查当前难度',
        options: kConditionBooleanOptions,
      ),
      const ConditionValueFieldConfig(
        '地图难度',
        options: kConditionDifficultyOptions,
      ),
    ),
    _ => _config(
      const ConditionValueFieldConfig('参数 1'),
      const ConditionValueFieldConfig('参数 2'),
      const ConditionValueFieldConfig('参数 3'),
    ),
  };
}

ConditionValueConfig _config(
  ConditionValueFieldConfig value1, [
  ConditionValueFieldConfig value2 = _unused,
  ConditionValueFieldConfig value3 = _unused,
]) => ConditionValueConfig(value1, value2, value3);

ConditionValueFieldConfig _reference(
  String label,
  ConditionValueReference reference,
) => ConditionValueFieldConfig(label, reference: reference);

class ConditionValueConfig {
  final ConditionValueFieldConfig value1;
  final ConditionValueFieldConfig value2;
  final ConditionValueFieldConfig value3;

  const ConditionValueConfig(this.value1, this.value2, this.value3);
}

class ConditionValueFieldConfig {
  final String label;
  final bool editable;
  final ConditionValueReference reference;
  final Map<int, String>? options;
  final List<FlagItem>? flags;

  const ConditionValueFieldConfig(
    this.label, {
    this.editable = true,
    this.reference = ConditionValueReference.none,
    this.options,
    this.flags,
  });
}

enum ConditionValueReference {
  none,
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
