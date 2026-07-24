import 'dart:io';

import 'package:test/test.dart';

void main() {
  const intentionallyHandwritten = {
    // App-owned rows with DateTime/enum conversion or no persisted row identity.
    'activity_log_entity.dart',
    'feature_entity.dart',
    'version_entity.dart',

    // Dynamic DBC row passthrough models backed by Map<String, dynamic>.
    'holiday_entity.dart',
    'item_bag_family_entity.dart',
    'item_limit_category_entity.dart',
    'totem_category_entity.dart',

    // Joined values, compatibility aliases, or otherwise non-symmetric mapping.
    'creature_model_data_entity.dart',
    'creature_on_kill_reputation_entity.dart',
    'creature_quest_item_entity.dart',
    'creature_template_resistance_entity.dart',
    'creature_template_spell_entity.dart',
    'game_object_display_info_entity.dart',
    'game_object_template_addon_entity.dart',
    'gossip_menu_entity.dart',
    'gossip_menu_option_entity.dart',
    'item_template_entity.dart',
    'item_template_locale_entity.dart',
    'npc_text_entity.dart',
    'npc_text_locale_entity.dart',
    'quest_offer_reward_locale_entity.dart',
    'quest_request_items_locale_entity.dart',
    'quest_template_entity.dart',
    'quest_template_locale_entity.dart',
    'spell_loot_template_entity.dart',
    'vehicle_entity.dart',
  };

  final fullFiles =
      Directory('lib/entity')
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('_entity.dart'))
          .where((file) => !file.path.endsWith('.g.dart'))
          .where(
            (file) =>
                !file.uri.pathSegments.last.startsWith('brief_') &&
                !file.uri.pathSegments.last.endsWith('_filter_entity.dart'),
          )
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));

  test('所有标准 Full Entity 已迁移，手写清单只包含设计边界例外', () {
    final handwritten = {
      for (final file in fullFiles)
        if (!file.readAsStringSync().contains('@FoxyFullEntity'))
          file.uri.pathSegments.last,
    };

    expect(handwritten, intentionallyHandwritten);
    expect(fullFiles.length - handwritten.length, 102);
  });

  test('拆分完成后每个 Full Entity 文件只声明一个 Full Entity class', () {
    for (final file in fullFiles) {
      final source = file.readAsStringSync();
      final classes = RegExp(
        r'\bclass\s+(?!Brief)\w+Entity\b',
      ).allMatches(source);
      expect(classes.length, 1, reason: '${file.path} 必须只声明一个 Full Entity');
    }
  });

  test('生成型 Full Entity 不依赖抽象字段 getter 或 lint 忽略', () {
    for (final file in fullFiles) {
      final source = file.readAsStringSync();
      if (!source.contains('@FoxyFullEntity')) continue;

      expect(
        source,
        isNot(contains('ignore_for_file: annotate_overrides')),
        reason: '${file.path} 不应通过文件级忽略隐藏 Mixin 字段覆盖',
      );

      final className = RegExp(
        r'class\s+(\w+Entity)\s+with\s+_\w+EntityMixin',
      ).firstMatch(source)?.group(1);
      expect(className, isNotNull, reason: '${file.path} 缺少约定 Mixin');

      final generated = File(
        file.path.replaceFirst(RegExp(r'\.dart$'), '.g.dart'),
      ).readAsStringSync();
      expect(
        generated,
        isNot(
          contains(
            RegExp(
              r'^\s+(?:int|double|String|bool)\??\s+get\s+\w+;\s*$',
              multiLine: true,
            ),
          ),
        ),
        reason: '${file.path} 的 Full Mixin 不应生成抽象字段 getter',
      );
      expect(
        generated,
        contains('final self = this as $className;'),
        reason: '${file.path} 的实例方法应在生成代码内部转换具体 Entity',
      );
    }
  });

  test('三个历史多实体文件完成独立文件拆分', () {
    for (final path in const [
      'lib/entity/player_create_info_action_entity.dart',
      'lib/entity/player_create_info_cast_spell_entity.dart',
      'lib/entity/player_create_info_item_entity.dart',
      'lib/entity/player_create_info_skill_entity.dart',
      'lib/entity/player_create_info_spell_custom_entity.dart',
      'lib/entity/quest_offer_reward_locale_entity.dart',
      'lib/entity/quest_request_items_locale_entity.dart',
    ]) {
      expect(File(path).existsSync(), isTrue, reason: '$path 尚未拆分');
    }
  });

  test('迁移工具不会重新创建旧 Brief/Key 生成壳', () {
    final source = File('tool/entity_codegen_migrate.dart').readAsStringSync();

    expect(
      source,
      isNot(contains("_generatedName(migration.fullFile, 'brief')")),
    );
    expect(
      source,
      isNot(contains("_generatedName(migration.fullFile, 'key')")),
    );
    expect(source, contains('file.deleteSync();'));
  });
}
