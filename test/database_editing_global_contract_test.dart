import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/form/field_controller.dart';

import 'support/local_dart_library_source.dart';

void main() {
  final entityFiles = Directory('lib/entity')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !file.path.endsWith('.g.dart'))
      .toList();
  final briefFiles = entityFiles
      .where((file) => file.uri.pathSegments.last.startsWith('brief_'))
      .toList();
  final repositoryFiles = Directory('lib/repository')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('_repository.dart'))
      .toList();
  final editingRepositoryFiles = repositoryFiles
      .where((file) => !file.path.endsWith('/feature_repository.dart'))
      .toList();
  final pageFiles = Directory('lib/page')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList();

  test('全部 Brief Entity 独立成文件并暴露完整标量或专用身份', () {
    final keyPattern = RegExp(
      r'(?:(?:final\s+)?(?:int|String|\w+Key)\s+key;|'
      r'(?:int|String|\w+Key)\s+get\s+key\s*(?:=>|\{))',
    );

    for (final file in briefFiles) {
      expect(
        readLocalDartLibrarySource(file.path),
        matches(keyPattern),
        reason: '${file.path} 缺少完整标量或专用 key',
      );
    }
    for (final file in entityFiles.where(
      (file) => !file.uri.pathSegments.last.startsWith('brief_'),
    )) {
      expect(
        file.readAsStringSync(),
        isNot(matches(RegExp(r'class\s+Brief\w+Entity'))),
        reason: '${file.path} 仍内嵌 Brief Entity',
      );
    }
  });

  test('全部 Brief Repository 查询返回 Brief、分页且数量一一对应', () {
    final source = editingRepositoryFiles
        .map((file) => file.readAsStringSync())
        .join('\n');
    final briefMethods = RegExp(r'getBrief\w+\s*\(').allMatches(source).length;
    final briefReturns = RegExp(
      r'Future<List<Brief\w+Entity>>\s+getBrief',
    ).allMatches(source).length;
    final pageLimits = '.limit(kPageSize)'.allMatches(source).length;

    expect(briefMethods, greaterThan(0));
    expect(briefReturns, briefMethods);
    expect(pageLimits, briefMethods);
  });

  test('全部候选 UPDATE 和行 DELETE 使用独立完整 locator 与写入结果', () {
    final updatePattern = RegExp(
      r'Future<void>\s+(update\w+)\s*\((.*?)\)\s*async\s*\{',
      dotAll: true,
    );
    final destroyPattern = RegExp(
      r'Future<void>\s+(destroy\w+)\s*\((.*?)\)\s*async\s*\{',
      dotAll: true,
    );
    var updateCount = 0;
    var destroyCount = 0;
    var matchedChecks = 0;
    var deletedChecks = 0;

    for (final file in editingRepositoryFiles) {
      final source = file.readAsStringSync();
      for (final match in updatePattern.allMatches(source)) {
        updateCount++;
        expect(
          match.group(2),
          matches(RegExp(r'(?:int|String|\w+Key)\s+originalKey')),
          reason: '${file.path}:${match.group(1)} 未接收独立 originalKey',
        );
      }
      for (final match in destroyPattern.allMatches(source)) {
        destroyCount++;
        expect(
          match.group(2),
          matches(RegExp(r'(?:int|String|\w+Key)\s+key')),
          reason: '${file.path}:${match.group(1)} 未接收完整 locator',
        );
      }
      matchedChecks += RegExp(
        r'if\s*\((?:matchedRows|affectedRows)\s*==\s*0\)',
      ).allMatches(source).length;
      deletedChecks += RegExp(
        r'if\s*\((?:deletedRows|affectedRows)\s*==\s*0\)',
      ).allMatches(source).length;
      expect(
        source,
        isNot(
          matches(
            RegExp(r'Future<void>\s+update\w+\([^)]*\)\s*async\s*\{\s*\}'),
          ),
        ),
        reason: '${file.path} 仍包含空 UPDATE',
      );
    }

    expect(matchedChecks, updateCount);
    expect(deletedChecks, destroyCount);
  });

  test('专用 Key 清单只保留联合或特殊定位器', () {
    const retainedKeyFiles = {
      'condition_key.dart',
      'creature_equip_template_key.dart',
      'creature_loot_template_key.dart',
      'creature_quest_ender_key.dart',
      'creature_quest_item_key.dart',
      'creature_quest_starter_key.dart',
      'creature_template_locale_key.dart',
      'creature_template_resistance_key.dart',
      'creature_template_spell_key.dart',
      'disenchant_loot_template_key.dart',
      'game_object_loot_template_key.dart',
      'game_object_quest_ender_key.dart',
      'game_object_quest_item_key.dart',
      'game_object_quest_starter_key.dart',
      'game_object_template_locale_key.dart',
      'gossip_menu_key.dart',
      'gossip_menu_option_key.dart',
      'gossip_menu_option_locale_key.dart',
      'item_enchantment_template_key.dart',
      'item_enchantment_template_parent_key.dart',
      'item_loot_template_key.dart',
      'item_template_locale_key.dart',
      'milling_loot_template_key.dart',
      'npc_text_locale_key.dart',
      'npc_trainer_key.dart',
      'npc_vendor_key.dart',
      'page_text_locale_key.dart',
      'player_create_info_action_key.dart',
      'player_create_info_cast_spell_key.dart',
      'player_create_info_item_key.dart',
      'player_create_info_key.dart',
      'player_create_info_skill_key.dart',
      'player_create_info_spell_custom_key.dart',
      'pickpocketing_loot_template_key.dart',
      'prospecting_loot_template_key.dart',
      'quest_offer_reward_locale_key.dart',
      'quest_request_items_locale_key.dart',
      'quest_template_locale_key.dart',
      'reference_loot_template_key.dart',
      'skinning_loot_template_key.dart',
      'smart_script_key.dart',
      'spell_area_key.dart',
      'spell_group_key.dart',
      'spell_linked_spell_key.dart',
      'spell_loot_template_key.dart',
      'spell_rank_key.dart',
      'waypoint_data_key.dart',
    };
    final actualKeyFiles = entityFiles
        .map((file) => file.uri.pathSegments.last)
        .where((name) => name.endsWith('_key.dart'))
        .toSet();

    expect(actualKeyFiles, retainedKeyFiles);
    expect(
      readLocalDartLibrarySource(
        'lib/entity/player_create_info_cast_spell_key.dart',
      ),
      contains('final String? note;'),
    );
    expect(
      File('lib/entity/waypoint_data_key.dart').readAsStringSync(),
      contains('不是单个 waypoint_data 物理行主键'),
    );
  });

  test('Repository 不再推断保存身份、返回替代键或执行隐式跨表删除', () {
    final source = editingRepositoryFiles
        .map((file) => file.readAsStringSync())
        .join('\n');
    final saveMethods = RegExp(r'Future<void>\s+(save\w+)\s*\(')
        .allMatches(source)
        .map((match) => match.group(1)!)
        .where((name) => !name.endsWith('Locale') && !name.endsWith('Locales'));

    expect(saveMethods, isEmpty);
    expect(
      source,
      isNot(matches(RegExp(r'Future<(?!void)[^>]+>\s+store\w+\s*\('))),
    );
    expect(source, isNot(contains('insertAndGetId')));
    expect(source, isNot(contains('destroyGossipMenuOptionLocales')));
  });

  test('全部独立详情 ViewModel 使用 persistedKey 且路由不重建详情身份', () {
    final detailViewModels = pageFiles.where(
      (file) => file.path.endsWith('_detail_view_model.dart'),
    );
    for (final file in detailViewModels) {
      expect(
        file.readAsStringSync(),
        contains('persistedKey'),
        reason: '${file.path} 缺少 persistedKey',
      );
    }

    final routerSource = Directory('lib/router')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .map((file) => file.readAsStringSync())
        .join('\n');
    expect(routerSource, isNot(contains('replaceCurrentDetail')));
    expect(
      File('lib/router/router_node.dart').readAsStringSync(),
      isNot(matches(RegExp(r'final\s+String\s+id'))),
    );
  });

  test('编辑表单没有永久只读字段，数值控制器拒绝非法输入', () {
    final pageSource = pageFiles
        .map((file) => file.readAsStringSync())
        .join('\n');
    expect(pageSource, isNot(matches(RegExp(r'readOnly:\s*true'))));
    expect(pageSource, isNot(contains('buildCredential')));
    expect(
      pageSource,
      isNot(
        matches(
          RegExp(
            r'Map<String,\s*dynamic>[^;\n]*(?:key|credential)',
            caseSensitive: false,
          ),
        ),
      ),
    );

    final flags = FlagFieldController();
    addTearDown(flags.dispose);
    flags.controller.text = 'invalid';
    expect(flags.collect, throwsFormatException);
    flags.controller.text = '';
    expect(flags.collect(), 0);
  });
}
