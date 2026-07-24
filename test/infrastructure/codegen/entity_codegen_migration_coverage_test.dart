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
}
