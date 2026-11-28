import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/setting_entry.dart';
import 'package:foxy/router/setting_section.dart';
import 'package:foxy/widget/directory/directory_setting_row.dart';
import 'package:foxy_agent/foxy_agent.dart';

final class FindFoxyFeatureTool extends AgentTool {
  static const _primaryTables = {
    RouterMenu.creatureTemplate: 'creature_template',
    RouterMenu.itemTemplate: 'item_template',
    RouterMenu.questTemplate: 'quest_template',
    RouterMenu.gameObjectTemplate: 'gameobject_template',
    RouterMenu.gossipMenu: 'gossip_menu',
    RouterMenu.smartScript: 'smart_scripts',
    RouterMenu.spell: 'dbc_spell',
    RouterMenu.referenceLootTemplate: 'reference_loot_template',
    RouterMenu.pageText: 'page_text',
    RouterMenu.condition: 'conditions',
    RouterMenu.playerCreateInfo: 'playercreateinfo',
    RouterMenu.areaTable: 'dbc_area_table',
    RouterMenu.emoteText: 'dbc_emotes_text',
    RouterMenu.questFactionReward: 'dbc_quest_faction_reward',
    RouterMenu.questSort: 'dbc_quest_sort',
    RouterMenu.questInfo: 'dbc_quest_info',
    RouterMenu.itemExtendedCost: 'dbc_item_extended_cost',
    RouterMenu.scalingStatDistribution: 'dbc_scaling_stat_distribution',
    RouterMenu.spellItemEnchantment: 'dbc_spell_item_enchantment',
    RouterMenu.gemProperty: 'dbc_gem_properties',
    RouterMenu.glyphProperty: 'dbc_glyph_properties',
    RouterMenu.talent: 'dbc_talent',
    RouterMenu.skillLine: 'dbc_skill_line',
    RouterMenu.currencyType: 'dbc_currency_types',
    RouterMenu.scalingStatValue: 'dbc_scaling_stat_values',
    RouterMenu.itemSet: 'dbc_item_set',
    RouterMenu.achievement: 'dbc_achievement',
  };

  static const _creatureLookup = '按「编号（entry）」或「名称（name）」查询，双击结果。';

  static const _templateGuides = {
    RouterMenu.creatureTemplate: (
      tab: '生物模板',
      lookup: _creatureLookup,
      keywords: ['NPC', '怪物'],
    ),
    RouterMenu.itemTemplate: (
      tab: '物品模板',
      lookup: '按「编号（entry）」或「名称（name）」查询，双击结果。',
      keywords: ['item', '装备', '购买价格', '出售价格'],
    ),
    RouterMenu.questTemplate: (
      tab: '任务模板',
      lookup: '按「编号（Entry）」或「标题（Title）」查询，双击结果。',
      keywords: ['quest', '任务奖励', '任务目标'],
    ),
  };

  final List<_FeatureEntry> _entries;

  FindFoxyFeatureTool(List<FeatureEntity> modules)
    : _entries = _buildEntries(modules);

  @override
  String get description =>
      'Find Foxy desktop menus, module pages and settings by name or table. '
      'Use for where-to-find or how-to-use questions and to guide users from '
      'database results to the GUI. This tool only returns guidance.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'query': {
        'type': 'string',
        'description':
            'A short feature keyword or table name, e.g. NPC 商人, npc_vendor, '
            '天赋, or 导入 DBC. Omit record names and IDs.',
      },
    },
    'required': ['query'],
    'additionalProperties': false,
  };

  @override
  String get name => 'find_foxy_feature';

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
        .map((keyword) => keyword.replaceFirst(databasePrefix, ''))
        .toList();
    final exactQuery = keywords.join(' ');
    final exact = _entries.where((entry) => entry.terms.contains(exactQuery));
    final matches = exact.isNotEmpty
        ? exact
        : _entries.where((entry) => keywords.every(entry.searchText.contains));
    return {'features': matches.map((entry) => entry.toJson()).toList()};
  }

  static List<_FeatureEntry> _buildEntries(List<FeatureEntity> modules) {
    final modulesByMenu = {
      for (final module in modules) module.routerMenu: module,
    };
    final fixedMenus = RouterMenu.sidebarMenus(const []);
    return [
      ...fixedMenus.map(_sidebarEntry),
      ...RouterMenu.values.where((menu) => !fixedMenus.contains(menu)).expand((
        menu,
      ) {
        final module = modulesByMenu[menu.name];
        return module == null
            ? const <_FeatureEntry>[]
            : _moduleEntries(menu, module);
      }),
      ...SettingSection.values.map(
        (section) => _FeatureEntry(section.label, [
          RouterMenu.setting.label,
          section.label,
        ], '在侧栏打开「${RouterMenu.setting.label}」，选择「${section.label}」。'),
      ),
      ...SettingEntry.values.map(_settingEntry),
      ...DirectoryConfigTarget.values.map(
        (target) => _FeatureEntry(target.title, [
          RouterMenu.setting.label,
          SettingSection.environment.label,
          DirectoryConfigTarget.groupLabel,
          target.title,
        ], '点击「浏览目录」，选择目录后点击「保存」。'),
      ),
      _FeatureEntry(
        '动态',
        [RouterMenu.dashboard.label, '动态'],
        '在「${RouterMenu.dashboard.label}」的「动态」卡片查看最近的操作记录。',
        keywords: const ['activity_log', '操作日志', '最近修改'],
      ),
      _FeatureEntry(
        '版本信息',
        [RouterMenu.dashboard.label, '版本信息'],
        '在「${RouterMenu.dashboard.label}」查看核心、数据库和软件版本。',
        keywords: const ['核心版本', '数据库版本', '软件版本'],
      ),
    ];
  }

  static List<_FeatureEntry> _moduleEntries(
    RouterMenu menu,
    FeatureEntity module,
  ) {
    final path = [
      if (!module.isPinned) ...[RouterMenu.more.label, module.name],
      menu.label,
    ];
    final open = module.isPinned
        ? '在侧栏打开「${menu.label}」。'
        : '在「${RouterMenu.more.label}」搜索并打开「${module.name}」。';
    final template = _templateGuides[menu];
    final lookup = template?.lookup ?? '查询目标记录后双击结果。';
    final save = template == null ? '' : '在「${template.tab}」修改字段后点击「保存」。';
    return [
      _FeatureEntry(
        module.name,
        path,
        '$open$lookup 打开「${menu.detailLabel}」。$save',
        description: module.description,
        keywords: [
          menu.name,
          menu.route.routeName,
          menu.detailLabel,
          ?_primaryTables[menu],
          ?template?.tab,
          ...?template?.keywords,
        ],
      ),
      if (menu == RouterMenu.creatureTemplate) ...[
        _FeatureEntry(
          'NPC 商人',
          [...path, menu.detailLabel, '商人'],
          '$open$_creatureLookup 打开「商人」后，点击「新增」添加物品，或双击现有行编辑并点击「更新」。',
          keywords: const ['npc_vendor', 'NPC商人', 'vendor', '售卖物品', '售卖列表'],
        ),
        _FeatureEntry(
          '生物击杀掉落',
          [...path, menu.detailLabel, '击杀掉落'],
          '$open$_creatureLookup 打开「击杀掉落」后，点击「新增」添加物品，或双击现有行编辑掉落几率等设置。',
          keywords: const ['creature_loot_template', '怪物掉落', 'loot', '掉率'],
        ),
      ],
    ];
  }

  static _FeatureEntry _settingEntry(SettingEntry entry) {
    final steps = switch (entry) {
      SettingEntry.combinedExport =>
        '设置「DBC 输出目录」「MPQ 输出目录」和「MPQ 文件名」，选中要导出的表，再点击「导出」。',
      SettingEntry.dbcImport =>
        '导入会整表替换与本次导入文件对应的已有 `foxy.dbc_*` 表。'
            '先在「${RouterMenu.setting.label} → ${SettingSection.environment.label} → '
            '${DirectoryConfigTarget.groupLabel} → ${DirectoryConfigTarget.serverDir.title}」核对服务端目录。'
            '已配置 DBC 目录时，点击「${entry.actionLabel}」会自动开始导入。',
      SettingEntry.dbcExport => '在弹窗设置「输出目录」，选中要导出的表，再点击「导出」。',
      SettingEntry.mpqExport => '在弹窗设置「输出目录」和「MPQ 文件名」，选中要打包的表，再点击「导出」。',
      SettingEntry.databaseConnection =>
        '查看当前数据库连接摘要；点击「${entry.actionLabel}」可关闭当前连接并返回连接页面以切换其他数据库。',
      SettingEntry.iconExtract =>
        '点击「${entry.actionLabel}」，从已配置的客户端 MPQ 归档提取游戏图标。',
      SettingEntry.localeTables =>
        '打开「${entry.title}」开关，优先显示本地化表中的文本。检测到本地化表时可以使用。',
      SettingEntry.aiModel =>
        '在「${entry.title}」点击「${entry.actionLabel}」，填写服务商的 Base URL、模型名称和 API Key。',
      SettingEntry.appUpdates => '点击「${entry.actionLabel}」查看 Foxy 是否有新版本。',
      SettingEntry.projectPage =>
        '在「${entry.title}」点击「${entry.actionLabel}」，前往 GitHub 查看文档、更新记录和问题反馈。',
    };
    final keywords = switch (entry) {
      SettingEntry.combinedExport => const ['同时导出', '联合导出'],
      SettingEntry.dbcImport => const ['导入DBC', 'import dbc'],
      SettingEntry.dbcExport => const ['导出DBC', 'export dbc'],
      SettingEntry.mpqExport => const ['导出MPQ', 'export mpq', '客户端补丁'],
      SettingEntry.databaseConnection => const [
        '断开连接',
        '切换数据库',
        '切换连接',
        '重新连接',
        'MySQL',
      ],
      SettingEntry.iconExtract => const ['游戏图标', '图标提取'],
      SettingEntry.localeTables => const ['本地化表', '翻译', '中文显示'],
      SettingEntry.aiModel => const ['配置模型', '模型服务商', 'API Key'],
      SettingEntry.appUpdates => const ['应用更新'],
      SettingEntry.projectPage => const ['GitHub', '问题反馈'],
    };
    return _FeatureEntry(
      entry.title,
      [
        RouterMenu.setting.label,
        entry.section.label,
        if (entry.section != SettingSection.data &&
            entry.title != entry.actionLabel)
          entry.title,
        entry.actionLabel,
      ],
      steps,
      keywords: keywords,
    );
  }

  static _FeatureEntry _sidebarEntry(RouterMenu menu) => _FeatureEntry(
    menu.label,
    [menu.label],
    menu == RouterMenu.more
        ? '在侧栏打开「${menu.label}」，使用「搜索模块名称」查找功能卡片。'
        : '在侧栏打开「${menu.label}」。',
    keywords: [menu.name, menu.route.routeName],
  );
}

final class _FeatureEntry {
  final String name;
  final List<String> path;
  final String steps;
  final String description;
  final List<String> terms;
  late final String searchText = [
    ...terms,
    ...path,
    description,
  ].join(' ').toLowerCase();

  _FeatureEntry(
    this.name,
    this.path,
    this.steps, {
    List<String> keywords = const [],
    this.description = '',
  }) : terms = [
         name,
         path.last,
         ...keywords,
       ].map((term) => term.toLowerCase()).toList();

  Map<String, Object?> toJson() => {'name': name, 'path': path, 'steps': steps};
}
