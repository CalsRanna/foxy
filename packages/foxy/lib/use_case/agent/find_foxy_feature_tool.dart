import 'package:foxy_agent/foxy_agent.dart';

final class FindFoxyFeatureTool extends AgentTool {
  const FindFoxyFeatureTool();

  static const _creaturePath = ['更多', '生物', '生物列表', '生物详情'];
  static const _creatureLookup = '在「生物列表」按「编号（entry）」或「姓名（name）」查询，双击结果。';
  static const _dataToolsPath = ['设置', '数据工具'];

  static const _features = [
    (
      name: '生物模板',
      keywords: ['creature_template', 'NPC', '怪物'],
      path: [..._creaturePath, '生物模板'],
      steps: '$_creatureLookup 在「生物模板」修改字段后点击「保存」。',
    ),
    (
      name: 'NPC 商人',
      keywords: ['npc_vendor', 'NPC商人', 'vendor', '售卖物品', '售卖列表'],
      path: [..._creaturePath, '商人'],
      steps: '$_creatureLookup 打开「商人」后，点击「新增」添加物品，或双击现有行编辑并点击「更新」。',
    ),
    (
      name: '生物击杀掉落',
      keywords: ['creature_loot_template', '怪物掉落', 'loot', '掉率'],
      path: [..._creaturePath, '击杀掉落'],
      steps: '$_creatureLookup 打开「击杀掉落」后，点击「新增」添加物品，或双击现有行编辑掉落几率等设置。',
    ),
    (
      name: '物品模板',
      keywords: ['item_template', 'item', '装备', '购买价格', '出售价格'],
      path: ['更多', '物品', '物品列表', '物品详情', '物品模板'],
      steps: '在「物品列表」按「编号（entry）」或「名称（name）」查询，双击结果。在「物品模板」修改字段后点击「保存」。',
    ),
    (
      name: '任务模板',
      keywords: ['quest_template', 'quest', '任务奖励', '任务目标'],
      path: ['更多', '任务', '任务列表', '任务详情', '任务模板'],
      steps: '在「任务列表」按「编号（Entry）」或「标题（Title）」查询，双击结果。在「任务模板」修改字段后点击「保存」。',
    ),
    (
      name: '导入 DBC 文件',
      keywords: ['导入DBC', 'import dbc'],
      path: [..._dataToolsPath, '导入 DBC'],
      steps: '在「导入 DBC」弹窗确认服务端 DBC 目录，点击「开始导入」。导入会覆盖 Foxy 数据库中的对应表。',
    ),
    (
      name: '导出 DBC 文件',
      keywords: ['导出DBC', 'export dbc'],
      path: [..._dataToolsPath, '导出 DBC'],
      steps: '在「导出 DBC」弹窗设置「输出目录」，选中要导出的表，再点击「开始导出」。',
    ),
    (
      name: '导出 MPQ 补丁',
      keywords: ['导出MPQ', 'export mpq', '客户端补丁'],
      path: [..._dataToolsPath, '导出 MPQ'],
      steps: '在「导出 MPQ 补丁」弹窗设置「输出目录」和「MPQ 文件名」，选中要打包的表，再点击「开始导出」。',
    ),
    (
      name: '一键导出 DBC 与 MPQ',
      keywords: ['一键导出', '同时导出', '联合导出'],
      path: [..._dataToolsPath, '一键导出'],
      steps: '设置「DBC 输出目录」「MPQ 输出目录」和「MPQ 文件名」，选中要导出的表，再点击「开始导出」。',
    ),
  ];

  @override
  String get name => 'find_foxy_feature';

  @override
  String get description =>
      'Find verified Foxy desktop GUI paths and steps for viewing or editing '
      'records and for DBC/MPQ workflows. Use for where-to-find or how-to-use '
      'questions and to guide users from database results to the GUI. '
      'This tool only returns guidance.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'query': {
        'type': 'string',
        'description':
            'A short feature keyword or table name, e.g. NPC 商人, npc_vendor, '
            '击杀掉落, or 导入 DBC. Omit record names and IDs.',
      },
    },
    'required': ['query'],
    'additionalProperties': false,
  };

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final query = arguments['query'];
    if (query is! String || query.trim().isEmpty) {
      return 'Provide a non-empty "query" with a feature keyword or table name.';
    }

    final databasePrefix = RegExp(r'^[\w-]+\.(?=\w+$)');
    final keywords = query
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .map((keyword) => keyword.replaceFirst(databasePrefix, ''));
    final matches = _features.where((feature) {
      final searchText = [
        feature.name,
        ...feature.keywords,
        ...feature.path,
      ].join(' ').toLowerCase();
      return keywords.every(searchText.contains);
    });

    return {
      'features': matches.map((feature) {
        return {
          'name': feature.name,
          'path': feature.path,
          'steps': feature.steps,
        };
      }).toList(),
    };
  }
}
