import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

enum ViewModelCategory {
  list('_list_view_model.dart'),
  detail('_detail_view_model.dart'),
  collectionEditor('_collection_editor_view_model.dart'),
  singleEditor('_single_editor_view_model.dart'),
  read('_read_view_model.dart'),
  workflow('_workflow_view_model.dart'),
  state('_state_view_model.dart');

  const ViewModelCategory(this.fileSuffix);

  final String fileSuffix;
}

const _listViewModels = <String>{
  'lib/page/achievement/achievement_list_view_model.dart',
  'lib/page/area_table/area_table_list_view_model.dart',
  'lib/page/condition/condition_list_view_model.dart',
  'lib/page/creature_template/creature_template_list_view_model.dart',
  'lib/page/currency_type/currency_type_list_view_model.dart',
  'lib/page/emote_text/emote_text_list_view_model.dart',
  'lib/page/game_object/game_object_template_list_view_model.dart',
  'lib/page/gem_property/gem_property_list_view_model.dart',
  'lib/page/glyph_property/glyph_property_list_view_model.dart',
  'lib/page/gossip_menu/gossip_menu_list_view_model.dart',
  'lib/page/item/item_template_list_view_model.dart',
  'lib/page/item_extended_cost/item_extended_cost_list_view_model.dart',
  'lib/page/item_set/item_set_list_view_model.dart',
  'lib/page/page_text/page_text_list_view_model.dart',
  'lib/page/player_create_info/player_create_info_list_view_model.dart',
  'lib/page/quest/quest_template_list_view_model.dart',
  'lib/page/quest_faction_reward/quest_faction_reward_list_view_model.dart',
  'lib/page/quest_info/quest_info_list_view_model.dart',
  'lib/page/quest_sort/quest_sort_list_view_model.dart',
  'lib/page/reference_loot_template/reference_loot_template_list_view_model.dart',
  'lib/page/scaling_stat_distribution/scaling_stat_distribution_list_view_model.dart',
  'lib/page/scaling_stat_value/scaling_stat_value_list_view_model.dart',
  'lib/page/smart_script/smart_script_list_view_model.dart',
  'lib/page/spell/spell_list_view_model.dart',
  'lib/page/spell_item_enchantment/spell_item_enchantment_list_view_model.dart',
  'lib/page/talent/talent_list_view_model.dart',
};

const _detailViewModels = <String>{
  'lib/page/achievement/achievement_detail_view_model.dart',
  'lib/page/area_table/area_table_detail_view_model.dart',
  'lib/page/condition/condition_detail_view_model.dart',
  'lib/page/creature_template/creature_template_detail_view_model.dart',
  'lib/page/currency_type/currency_type_detail_view_model.dart',
  'lib/page/emote_text/emote_text_detail_view_model.dart',
  'lib/page/game_object/game_object_template_detail_view_model.dart',
  'lib/page/gem_property/gem_property_detail_view_model.dart',
  'lib/page/glyph_property/glyph_property_detail_view_model.dart',
  'lib/page/gossip_menu/gossip_menu_detail_view_model.dart',
  'lib/page/item/item_template_detail_view_model.dart',
  'lib/page/item_extended_cost/item_extended_cost_detail_view_model.dart',
  'lib/page/item_set/item_set_detail_view_model.dart',
  'lib/page/page_text/page_text_detail_view_model.dart',
  'lib/page/player_create_info/player_create_info_detail_view_model.dart',
  'lib/page/quest/quest_template_detail_view_model.dart',
  'lib/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart',
  'lib/page/quest_info/quest_info_detail_view_model.dart',
  'lib/page/quest_sort/quest_sort_detail_view_model.dart',
  'lib/page/reference_loot_template/reference_loot_template_detail_view_model.dart',
  'lib/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart',
  'lib/page/scaling_stat_value/scaling_stat_value_detail_view_model.dart',
  'lib/page/smart_script/smart_script_detail_view_model.dart',
  'lib/page/spell/spell_detail_view_model.dart',
  'lib/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart',
  'lib/page/talent/talent_detail_view_model.dart',
};

const _collectionEditorViewModels = <String>{
  'lib/page/creature_template/creature_equip_template_collection_editor_view_model.dart',
  'lib/page/creature_template/creature_loot_template_collection_editor_view_model.dart',
  'lib/page/creature_template/creature_quest_item_collection_editor_view_model.dart',
  'lib/page/creature_template/creature_template_resistance_collection_editor_view_model.dart',
  'lib/page/creature_template/creature_template_spell_collection_editor_view_model.dart',
  'lib/page/creature_template/npc_trainer_collection_editor_view_model.dart',
  'lib/page/creature_template/npc_vendor_collection_editor_view_model.dart',
  'lib/page/creature_template/pickpocketing_loot_template_collection_editor_view_model.dart',
  'lib/page/creature_template/skinning_loot_template_collection_editor_view_model.dart',
  'lib/page/game_object/game_object_loot_template_collection_editor_view_model.dart',
  'lib/page/game_object/game_object_quest_item_collection_editor_view_model.dart',
  'lib/page/gossip_menu/gossip_menu_option_collection_editor_view_model.dart',
  'lib/page/item/disenchant_loot_template_collection_editor_view_model.dart',
  'lib/page/item/item_enchantment_template_collection_editor_view_model.dart',
  'lib/page/item/item_loot_template_collection_editor_view_model.dart',
  'lib/page/item/milling_loot_template_collection_editor_view_model.dart',
  'lib/page/item/prospecting_loot_template_collection_editor_view_model.dart',
  'lib/page/page_text/page_text_locale_collection_editor_view_model.dart',
  'lib/page/player_create_info/player_create_info_action_collection_editor_view_model.dart',
  'lib/page/player_create_info/player_create_info_cast_spell_collection_editor_view_model.dart',
  'lib/page/player_create_info/player_create_info_item_collection_editor_view_model.dart',
  'lib/page/player_create_info/player_create_info_skill_collection_editor_view_model.dart',
  'lib/page/player_create_info/player_create_info_spell_custom_collection_editor_view_model.dart',
  'lib/page/quest/creature_quest_ender_collection_editor_view_model.dart',
  'lib/page/quest/creature_quest_starter_collection_editor_view_model.dart',
  'lib/page/quest/game_object_quest_ender_collection_editor_view_model.dart',
  'lib/page/quest/game_object_quest_starter_collection_editor_view_model.dart',
  'lib/page/spell/spell_area_collection_editor_view_model.dart',
  'lib/page/spell/spell_group_collection_editor_view_model.dart',
  'lib/page/spell/spell_linked_spell_collection_editor_view_model.dart',
  'lib/page/spell/spell_loot_template_collection_editor_view_model.dart',
  'lib/page/spell/spell_rank_collection_editor_view_model.dart',
};

const _singleEditorViewModels = <String>{
  'lib/page/creature_template/creature_on_kill_reputation_single_editor_view_model.dart',
  'lib/page/creature_template/creature_template_addon_single_editor_view_model.dart',
  'lib/page/game_object/game_object_template_addon_single_editor_view_model.dart',
  'lib/page/gossip_menu/npc_text_single_editor_view_model.dart',
  'lib/page/quest/quest_offer_reward_single_editor_view_model.dart',
  'lib/page/quest/quest_request_items_single_editor_view_model.dart',
  'lib/page/quest/quest_template_addon_single_editor_view_model.dart',
  'lib/page/spell/spell_bonus_data_single_editor_view_model.dart',
  'lib/page/spell/spell_custom_attr_single_editor_view_model.dart',
};

const _readViewModels = <String>{
  'lib/page/dashboard/dashboard_read_view_model.dart',
  'lib/page/more/more_read_view_model.dart',
};

const _workflowViewModels = <String>{
  'lib/page/bootstrap/bootstrap_workflow_view_model.dart',
  'lib/page/setting/dbc_export_workflow_view_model.dart',
  'lib/page/setting/dbc_import_workflow_view_model.dart',
};

const _stateViewModels = <String>{
  'lib/page/feature/feature_state_view_model.dart',
  'lib/page/foxy_app/foxy_state_view_model.dart',
};

Iterable<String> _writeMethodBlocks(String source) sync* {
  final methodPattern = RegExp(
    r'^  Future<void> (persist|destroy|copy)\([^\n]*\) async \{',
    multiLine: true,
  );
  for (final match in methodPattern.allMatches(source)) {
    var depth = 0;
    for (
      var index = source.indexOf('{', match.start);
      index < source.length;
      index++
    ) {
      if (source[index] == '{') depth++;
      if (source[index] == '}') {
        depth--;
        if (depth == 0) {
          yield source.substring(match.start, index + 1);
          break;
        }
      }
    }
  }
}

void _expectOrdered(String path, String source, List<String> tokens) {
  var previous = -1;
  for (final token in tokens) {
    final position = source.indexOf(token);
    expect(position, isNonNegative, reason: '$path 缺少 $token');
    expect(
      position,
      greaterThan(previous),
      reason: '$path 的 $token 排列顺序不符合类别协议',
    );
    previous = position;
  }
}

void main() {
  final inventory =
      <({String currentPath, String targetPath, ViewModelCategory category})>[
        for (final path in _listViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.list,
          ),
        for (final path in _detailViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.detail,
          ),
        for (final path in _collectionEditorViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.collectionEditor,
          ),
        for (final path in _singleEditorViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.singleEditor,
          ),
        for (final path in _readViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.read,
          ),
        for (final path in _workflowViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.workflow,
          ),
        for (final path in _stateViewModels)
          (
            currentPath: path,
            targetPath: path,
            category: ViewModelCategory.state,
          ),
      ];

  test('全部当前 ViewModel 都有且只有一个目标类别', () {
    final actualFiles = Directory('lib/page')
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.path)
        .where((path) => path.endsWith('_view_model.dart'))
        .toSet();
    final classifiedFiles = inventory.map((entry) => entry.currentPath).toSet();

    // 原 SettingViewModel 已拆成两个独立 workflow，因此当前总数为 100。
    expect(inventory, hasLength(100));
    expect(classifiedFiles, hasLength(100));
    expect(actualFiles.difference(classifiedFiles), isEmpty);
    expect(classifiedFiles.difference(actualFiles), isEmpty);
  });

  test('每个迁移目标使用七类允许后缀之一', () {
    for (final entry in inventory) {
      expect(
        entry.targetPath.endsWith(entry.category.fileSuffix),
        isTrue,
        reason: '${entry.currentPath} -> ${entry.targetPath}',
      );
    }
  });

  test('当前类声明和 DI 注册可由分类清单相互核对', () {
    final diSource = File('lib/di.dart').readAsStringSync();

    for (final entry in inventory) {
      final source = File(entry.currentPath).readAsStringSync();
      final match = RegExp(
        r'class\s+([A-Za-z0-9_]+ViewModel)\b',
      ).firstMatch(source);
      expect(match, isNotNull, reason: entry.currentPath);
      final className = match!.group(1)!;
      expect(
        diSource.contains('$className()'),
        isTrue,
        reason: '$className 未在 lib/di.dart 注册',
      );
    }
  });

  test('全部 WorkflowViewModel 执行统一协议', () {
    const requiredMembers = [
      'final status = signal(WorkflowStatus.idle)',
      'final progress = signal<double?>(null)',
      "final progressLabel = signal('')",
      "final progressDetail = signal('')",
      'final errorMessage = signal<String?>(null)',
      'Future<void> prepare()',
      'Future<void> start()',
      'Future<void> cancel()',
      'Future<void> retry()',
      'void reset()',
      'void dispose()',
      '_attemptToken',
      'final token = ++_attemptToken',
      'if (token != _attemptToken) return',
      'bool get _isActive',
    ];
    const forbidden = [
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'Database.instance',
      '.transaction',
    ];

    for (final path in _workflowViewModels) {
      final source = File(path).readAsStringSync();
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      for (final token in forbidden) {
        expect(source.contains(token), isFalse, reason: '$path 包含 $token');
      }
    }
  });

  test('全部 ListViewModel 执行统一列表协议', () {
    final diSource = File('lib/di.dart').readAsStringSync();
    const requiredMembers = [
      'final items = signal',
      'final page = signal(1)',
      'final total = signal(0)',
      'final loading = signal(false)',
      'final submitting = signal(false)',
      'final errorMessage = signal<String?>(null)',
      'int _refreshToken = 0',
      'Future<void> initSignals()',
      'Future<void> search()',
      'Future<void> reset()',
      'Future<void> paginate(int page)',
      'Future<void> destroy(',
      'Future<void> _refresh()',
      'void dispose()',
    ];
    const forbidden = [
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'navigateToDetail',
      'showFoxyDialog',
      'Future<void> delete',
      'ActivityLogRepository',
    ];

    for (final path in _listViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+ListViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      for (final token in forbidden) {
        expect(source.contains(token), isFalse, reason: '$path 包含 $token');
      }
      expect(
        RegExp(r'final\s+repository\s*=').hasMatch(source),
        isFalse,
        reason: '$path 暴露 repository',
      );
      expect(
        RegExp(
          'registerFactory\\(\\s*\\(\\) => $className\\(\\)\\s*,?\\s*\\)',
        ).hasMatch(diSource),
        isTrue,
        reason: '$className 必须注册为 factory',
      );
    }
  });

  test('全部 DetailViewModel 执行统一详情协议', () {
    final diSource = File('lib/di.dart').readAsStringSync();
    const requiredMembers = [
      'final entity = signal<',
      'final persistedKey = signal<',
      'final loading = signal(false)',
      'final submitting = signal(false)',
      'final errorMessage = signal<String?>(null)',
      'Future<void> initSignals({',
      'Future<void> persist()',
      '_collectCandidate()',
      'void _applyCandidate(',
      'void dispose()',
    ];
    const forbidden = [
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'updateCurrentLabel',
      'Future<void> save(',
      'Future<bool> save(',
      'void pop(',
      'final isNew =',
      'ActivityLogRepository',
    ];

    for (final path in _detailViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+DetailViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      for (final token in forbidden) {
        expect(source.contains(token), isFalse, reason: '$path 包含 $token');
      }
      expect(
        RegExp(r'final\s+repository\s*=').hasMatch(source),
        isFalse,
        reason: '$path 暴露 repository',
      );
      expect(
        RegExp(
          'registerFactory\\(\\s*\\(\\) => $className\\(\\)\\s*,?\\s*\\)',
        ).hasMatch(diSource),
        isTrue,
        reason: '$className 必须注册为 factory',
      );
    }
  });

  test('全部 SingleEditorViewModel 执行统一单行编辑协议', () {
    final diSource = File('lib/di.dart').readAsStringSync();
    const requiredMembers = [
      'final parentKey = signal<',
      'final editingKey = signal<',
      'final entity = signal<',
      'final loading = signal(false)',
      'final submitting = signal(false)',
      'final errorMessage = signal<String?>(null)',
      'int _refreshToken = 0',
      'Future<void> initSignals({required int parentKey})',
      'Future<void> setParentKey(int parentKey)',
      'Future<void> persist()',
      'Future<void> destroy()',
      '_collectCandidate()',
      'void _applyCandidate(',
      'Future<void> _refresh()',
      'void dispose()',
    ];
    const forbidden = [
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'Database.instance',
      '.laconic',
      '.transaction',
      'Future<void> save(',
      'Future<bool> save(',
      'void pop(',
      'final items =',
      'final page =',
      'final total =',
      'selectedIndex',
    ];

    for (final path in _singleEditorViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+SingleEditorViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      for (final token in forbidden) {
        expect(source.contains(token), isFalse, reason: '$path 包含 $token');
      }
      expect(
        RegExp(r'final\s+(repository|useCase)\s*=').hasMatch(source),
        isFalse,
        reason: '$path 暴露依赖',
      );
      expect(
        RegExp(
          'registerFactory\\(\\s*\\(\\) => $className\\(\\)\\s*,?\\s*\\)',
        ).hasMatch(diSource),
        isTrue,
        reason: '$className 必须注册为 factory',
      );
    }
  });

  test('全部 CollectionEditorViewModel 执行统一集合编辑协议', () {
    final diSource = File('lib/di.dart').readAsStringSync();
    const requiredMembers = [
      'final parentKey = signal<',
      'final items = signal<List<',
      'final editingKey = signal<',
      'final selectedKey = signal<',
      'final page = signal(1)',
      'final total = signal(0)',
      'final loading = signal(false)',
      'final submitting = signal(false)',
      'final errorMessage = signal<String?>(null)',
      'int _refreshToken = 0',
      'Future<void> initSignals({required ',
      'Future<void> setParentKey(',
      'Future<void> create()',
      'Future<void> edit(',
      'Future<void> persist()',
      'Future<void> destroy(',
      'Future<void> paginate(int page)',
      '_collectCandidate()',
      'void _applyCandidate(',
      'Future<void> _refresh()',
      'void dispose()',
    ];
    const forbidden = [
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'Database.instance',
      '.laconic',
      '.transaction',
      'Future<void> save(',
      'Future<bool> save(',
      'Future<void> update(',
      'selectedIndex',
      'final creating =',
      'final editing =',
    ];

    for (final path in _collectionEditorViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+CollectionEditorViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      for (final token in forbidden) {
        expect(source.contains(token), isFalse, reason: '$path 包含 $token');
      }
      expect(
        RegExp(r'final\s+(repository|useCase)\s*=').hasMatch(source),
        isFalse,
        reason: '$path 暴露依赖',
      );
      expect(
        RegExp(
          'registerFactory\\(\\s*\\(\\) => $className\\(\\)\\s*,?\\s*\\)',
        ).hasMatch(diSource),
        isTrue,
        reason: '$className 必须注册为 factory',
      );
    }
  });

  test('全部 StateViewModel 执行统一协议并注册为 singleton', () {
    final diSource = File('lib/di.dart').readAsStringSync();
    const requiredMembers = [
      'final initialized = signal(false)',
      'final loading = signal(false)',
      'final errorMessage = signal<String?>(null)',
      'Future<void> initSignals()',
      'Future<void> refresh()',
      'void dispose()',
    ];

    for (final path in _stateViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+StateViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      expect(
        diSource.contains('registerSingleton($className())'),
        isTrue,
        reason: '$className 必须是 singleton',
      );
    }
  });

  test('全部 ReadViewModel 执行统一只读刷新协议', () {
    final diSource = File('lib/di.dart').readAsStringSync();
    const requiredMembers = [
      'final loading = signal(false)',
      'final errorMessage = signal<String?>(null)',
      'int _refreshToken = 0',
      'Future<void> initSignals()',
      'Future<void> refresh()',
      'Future<void> _refresh()',
      'void dispose()',
    ];
    const forbidden = [
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'Database.instance',
      '.laconic',
      '.transaction',
      'store',
      'destroy',
      'persist',
    ];

    for (final path in _readViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+ReadViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      for (final member in requiredMembers) {
        expect(source.contains(member), isTrue, reason: '$path 缺少 $member');
      }
      for (final token in forbidden) {
        expect(source.contains(token), isFalse, reason: '$path 包含 $token');
      }
      expect(
        RegExp(
          'registerFactory\\(\\s*\\(\\) => $className\\(\\)\\s*,?\\s*\\)',
        ).hasMatch(diSource),
        isTrue,
        reason: '$className 必须注册为 factory',
      );
    }
  });

  test('UseCase 不依赖 Flutter、路由或 ViewModel', () {
    final files = Directory('lib/use_case')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    expect(files, isNotEmpty);

    for (final file in files) {
      final source = file.readAsStringSync();
      expect(source.contains("package:flutter/"), isFalse, reason: file.path);
      expect(source.contains('shadcn_ui'), isFalse, reason: file.path);
      expect(source.contains('/router/'), isFalse, reason: file.path);
      expect(source.contains('ViewModel'), isFalse, reason: file.path);
      expect(
        RegExp(
          r'class\s+(Base|Crud|Generic|RepositoryUseCaseAdapter)',
        ).hasMatch(source),
        isFalse,
        reason: file.path,
      );
    }
  });

  test('全部 ViewModel 与 UI、数据库和其他页面 ViewModel 保持边界', () {
    const forbidden = [
      "package:flutter/",
      'BuildContext',
      'DialogUtil',
      'ShadSonner',
      'RouterFacade',
      'Database.instance',
      'Laconic',
      '.laconic',
      '.transaction',
    ];
    for (final entry in inventory) {
      final source = File(entry.currentPath).readAsStringSync();
      for (final token in forbidden) {
        expect(
          source.contains(token),
          isFalse,
          reason: '${entry.currentPath} 包含 $token',
        );
      }
      expect(
        RegExp(r"GetIt\.instance\.get<\w+ViewModel>").hasMatch(source),
        isFalse,
        reason: '${entry.currentPath} 依赖另一个 ViewModel',
      );
    }
  });

  test('全部写入 ViewModel 拒绝并发提交并在 finally 恢复状态', () {
    final writablePaths = {
      ..._listViewModels,
      ..._detailViewModels,
      ..._collectionEditorViewModels,
      ..._singleEditorViewModels,
    };
    for (final path in writablePaths) {
      final source = File(path).readAsStringSync();
      final methods = _writeMethodBlocks(source).toList();
      expect(methods, isNotEmpty, reason: '$path 没有写入方法');
      for (final method in methods) {
        expect(
          method.contains('if (submitting.value)'),
          isTrue,
          reason: '$path 写入方法缺少并发保护',
        );
        expect(
          method.contains('submitting.value = true'),
          isTrue,
          reason: '$path 写入方法未进入 submitting',
        );
        expect(
          method.contains('finally'),
          isTrue,
          reason: '$path 写入方法缺少 finally',
        );
        expect(
          method.contains('submitting.value = false'),
          isTrue,
          reason: '$path 写入方法未恢复 submitting',
        );
      }
    }
  });

  test('分页和父范围刷新捕获快照并保护最终状态', () {
    for (final path in _listViewModels) {
      final source = File(path).readAsStringSync();
      expect(
        source.contains('final currentPage = page.value'),
        isTrue,
        reason: '$path 未捕获 page 快照',
      );
      expect(
        source.contains('final filter = _collectFilter()'),
        isTrue,
        reason: '$path 未复用 filter 快照',
      );
      expect(
        source.contains('if (token != _refreshToken) return'),
        isTrue,
        reason: '$path 未保护刷新结果',
      );
    }
    for (final path in _collectionEditorViewModels) {
      final source = File(path).readAsStringSync();
      expect(
        source.contains('final parent = parentKey.value'),
        isTrue,
        reason: '$path 未捕获 parent 快照',
      );
      expect(
        source.contains('final currentPage = page.value'),
        isTrue,
        reason: '$path 未捕获 page 快照',
      );
      expect(
        source.contains('page: nextPage'),
        isTrue,
        reason: '$path 查询未使用 page 快照',
      );
      expect(
        source.contains('if (token != _refreshToken) return'),
        isTrue,
        reason: '$path 未保护刷新结果',
      );
    }
    for (final path in {..._singleEditorViewModels, ..._readViewModels}) {
      final source = File(path).readAsStringSync();
      expect(
        source.contains('if (token != _refreshToken) return'),
        isTrue,
        reason: '$path 未保护刷新结果',
      );
    }
  });

  test('List、Detail、Collection、Single 使用统一成员排列顺序', () {
    for (final path in _listViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final _repository',
        'final items = signal',
        'final page = signal(1)',
        'final total = signal(0)',
        'final loading = signal(false)',
        'final submitting = signal(false)',
        'final errorMessage = signal<String?>(null)',
        'Controller = registerController',
        'int _refreshToken = 0',
        'Future<void> initSignals()',
        'Future<void> search()',
        'Future<void> reset()',
        'Future<void> paginate(int page)',
        'Future<void> destroy(',
        '_collectFilter()',
        'Future<void> _refresh()',
        'void dispose()',
      ]);
    }
    for (final path in _detailViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final _repository',
        'final entity = signal<',
        'final persistedKey = signal<',
        'final loading = signal(false)',
        'final submitting = signal(false)',
        'final errorMessage = signal<String?>(null)',
        'Controller = registerController',
        'Future<void> initSignals({',
        'Future<void> persist()',
        'void dispose()',
      ]);
    }
    for (final path in _collectionEditorViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final _repository',
        'final parentKey = signal<',
        'final items = signal<List<',
        'final editingKey = signal<',
        'final selectedKey = signal<',
        'final page = signal(1)',
        'final total = signal(0)',
        'final loading = signal(false)',
        'final submitting = signal(false)',
        'final errorMessage = signal<String?>(null)',
        'Controller = registerController',
        'int _refreshToken = 0',
        'Future<void> initSignals({required ',
        'Future<void> setParentKey(',
        'Future<void> create()',
        'Future<void> edit(',
        'Future<void> persist()',
        'Future<void> destroy(',
        'Future<void> paginate(int page)',
        'Future<void> _refresh()',
        'void dispose()',
      ]);
    }
    for (final path in _singleEditorViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final _repository',
        'final parentKey = signal<',
        'final editingKey = signal<',
        'final entity = signal<',
        'final loading = signal(false)',
        'final submitting = signal(false)',
        'final errorMessage = signal<String?>(null)',
        'Controller = registerController',
        'int _refreshToken = 0',
        'Future<void> initSignals({required int parentKey})',
        'Future<void> setParentKey(int parentKey)',
        'Future<void> persist()',
        'Future<void> destroy()',
        'Future<void> _refresh()',
        'void dispose()',
      ]);
    }
  });

  test('Workflow、State、Read 使用统一成员分组顺序', () {
    for (final path in _workflowViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final status = signal(WorkflowStatus.idle)',
        'final progress = signal<double?>(null)',
        "final progressLabel = signal('')",
        "final progressDetail = signal('')",
        'final errorMessage = signal<String?>(null)',
        '_attemptToken',
        'Future<void> prepare()',
        'Future<void> start()',
        'Future<void> cancel()',
        'Future<void> retry()',
        'void reset()',
        'void dispose()',
      ]);
    }
    for (final path in _stateViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final initialized = signal(false)',
        'final loading = signal(false)',
        'final errorMessage = signal<String?>(null)',
        'Future<void> initSignals()',
        'Future<void> refresh()',
        'void dispose()',
      ]);
    }
    for (final path in _readViewModels) {
      final source = File(path).readAsStringSync();
      _expectOrdered(path, source, const [
        'final loading = signal(false)',
        'final errorMessage = signal<String?>(null)',
        'int _refreshToken = 0',
        'Future<void> initSignals()',
        'Future<void> refresh()',
        'Future<void> _refresh()',
        'void dispose()',
      ]);
    }
  });

  test('UI、Repository 和 UseCase 的依赖方向固定', () {
    final uiFiles = Directory('lib/page')
        .listSync(recursive: true)
        .whereType<File>()
        .where(
          (file) =>
              file.path.endsWith('_page.dart') ||
              file.path.endsWith('_view.dart') ||
              file.path.endsWith('_dialogs.dart'),
        );
    for (final file in uiFiles) {
      final source = file.readAsStringSync();
      expect(
        source.contains("package:foxy/repository/"),
        isFalse,
        reason: file.path,
      );
      expect(
        source.contains("package:foxy/infrastructure/database/"),
        isFalse,
        reason: file.path,
      );
    }

    final repositoryFiles = Directory('lib/repository')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    for (final file in repositoryFiles) {
      final source = file.readAsStringSync();
      expect(source.contains('/use_case/'), isFalse, reason: file.path);
      expect(source.contains('_view_model.dart'), isFalse, reason: file.path);
    }
  });

  test('全部写入 UI 观察 submitting 并禁用重复提交入口', () {
    for (final path in _listViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+ListViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      final pages = Directory('lib/page')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('_list_page.dart'))
          .where((file) => file.readAsStringSync().contains(className))
          .toList();
      expect(pages, hasLength(1), reason: className);
      final pageSource = pages.single.readAsStringSync();
      expect(
        pageSource.contains('viewModel.submitting.value'),
        isTrue,
        reason: pages.single.path,
      );
      expect(
        pageSource.contains('enabled: !viewModel.submitting.value'),
        isTrue,
        reason: pages.single.path,
      );
    }

    final editorPaths = {
      ..._detailViewModels,
      ..._collectionEditorViewModels,
      ..._singleEditorViewModels,
    };
    for (final path in editorPaths) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+ViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      final views = Directory('lib/page')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('_view.dart'))
          .where((file) => file.readAsStringSync().contains(className))
          .toList();
      expect(views, hasLength(1), reason: className);
      final viewSource = views.single.readAsStringSync();
      expect(
        viewSource.contains('viewModel.submitting.value'),
        isTrue,
        reason: views.single.path,
      );
      expect(
        viewSource.contains('enabled: !viewModel.submitting.value'),
        isTrue,
        reason: views.single.path,
      );
      expect(
        viewSource.contains('Watch('),
        isTrue,
        reason: '${views.single.path} 未响应 submitting signal',
      );
    }
  });

  test('Collection 删除确认与反馈位于各自 UI 交互面', () {
    for (final path in _collectionEditorViewModels) {
      final source = File(path).readAsStringSync();
      final className = RegExp(
        r'class\s+([A-Za-z0-9_]+CollectionEditorViewModel)\b',
      ).firstMatch(source)!.group(1)!;
      final views = Directory('lib/page')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('_view.dart'))
          .where((file) => file.readAsStringSync().contains(className))
          .toList();
      expect(views, hasLength(1), reason: className);
      final viewSource = views.single.readAsStringSync();
      expect(
        viewSource.contains('Future<void> _destroy('),
        isTrue,
        reason: views.single.path,
      );
      expect(
        viewSource.contains('DialogUtil.instance.confirm('),
        isTrue,
        reason: views.single.path,
      );
      expect(
        viewSource.contains('if (!confirmed) return'),
        isTrue,
        reason: '${views.single.path} 取消确认后仍可能执行删除',
      );
      expect(
        viewSource.contains("DialogUtil.instance.success('删除成功')"),
        isTrue,
        reason: views.single.path,
      );
      expect(
        viewSource.contains("DialogUtil.instance.error('删除失败："),
        isTrue,
        reason: views.single.path,
      );
      expect(
        RegExp(r'(context\.mounted|\bmounted\b)').hasMatch(viewSource),
        isTrue,
        reason: '${views.single.path} await 后缺少 mounted 保护',
      );
      if (viewSource.contains('showFoxyDialog(')) {
        expect(
          RegExp(r'Navigator\.of\([^)]+\)\.pop\(\)').hasMatch(viewSource),
          isTrue,
          reason: '${views.single.path} 保存成功后未关闭编辑 Dialog',
        );
      }
    }
  });

  test('未引入通用 CRUD、UseCase 或 UI action 框架', () {
    expect(
      File('lib/widget/detail_view_interaction.dart').existsSync(),
      isFalse,
    );
    expect(File('lib/entity/loot_template_entity.dart').existsSync(), isFalse);
    final sourceFiles = [
      ...Directory('lib').listSync(recursive: true).whereType<File>(),
    ].where((file) => file.path.endsWith('.dart'));
    const forbiddenDeclarations = [
      'class BaseUseCase',
      'class CrudUseCase',
      'class GenericEditorViewModel',
      'class BaseDetailViewModel',
      'class UiEffect',
      'enum LootTableType',
    ];
    for (final file in sourceFiles) {
      final source = file.readAsStringSync();
      for (final declaration in forbiddenDeclarations) {
        expect(
          source.contains(declaration),
          isFalse,
          reason: '${file.path} 包含 $declaration',
        );
      }
    }
  });
}
