import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/entity/point_of_interest_entity.dart';
import './support/local_dart_library_source.dart';

void main() {
  test('gossip_menu 与全部关联 Entity 逐列覆盖物理结构', () {
    final rows = <Map<String, dynamic>>[
      const GossipMenuEntity().toJson(),
      const NpcTextEntity().toJson(),
      const NpcTextLocaleEntity().toJson(),
      const GossipMenuOptionEntity().toJson(),
      const GossipMenuOptionLocaleEntity().toJson(),
      const PointOfInterestEntity().toJson(),
    ];

    expect(rows.map((row) => row.length), [2, 90, 18, 14, 5, 7]);
    for (final row in rows) {
      expect(row.values.whereType<List<Object?>>(), isEmpty);
      expect(row.values.whereType<Map<Object?, Object?>>(), isEmpty);
    }
  });

  test('npc_text 八组字段均为独立标量且保持 SQL 物理顺序', () {
    final keys = const NpcTextEntity().toJson().keys.toList();
    expect(keys.first, 'ID');
    expect(keys.last, 'VerifiedBuild');
    for (var group = 0; group < 8; group++) {
      final offset = 1 + group * 11;
      expect(keys.sublist(offset, offset + 11), [
        'text${group}_0',
        'text${group}_1',
        'BroadcastTextID$group',
        'lang$group',
        'Probability$group',
        'em${group}_0',
        'em${group}_1',
        'em${group}_2',
        'em${group}_3',
        'em${group}_4',
        'em${group}_5',
      ]);
    }
  });

  test('npc_text 90 列 fromJson/toJson 不发生槽位错位', () {
    final source = <String, dynamic>{};
    final keys = const NpcTextEntity().toJson().keys;
    var number = 1;
    for (final key in keys) {
      if (key.startsWith('text')) {
        source[key] = 'value-$number';
      } else if (key.startsWith('Probability')) {
        source[key] = number + 0.25;
      } else {
        source[key] = number;
      }
      number++;
    }
    expect(NpcTextEntity.fromJson(source).toJson(), source);
  });

  test('npc_text_locale 精确覆盖 8 组 16 个文本字段', () {
    final keys = const NpcTextLocaleEntity().toJson().keys.toSet();
    expect(keys, {
      'ID',
      'Locale',
      for (var group = 0; group < 8; group++) ...{
        'Text${group}_0',
        'Text${group}_1',
      },
    });
  });

  test('Gossip option 类型、图标和语言枚举与当前 core 一致', () {
    expect(kGossipOptionTypes.keys.toSet(), {
      for (var value = 0; value <= 20; value++) value,
    });
    expect(kGossipOptionIcons.keys.toSet(), {
      for (var value = 0; value <= 13; value++) value,
      for (var value = 16; value <= 20; value++) value,
    });
    expect(kNpcTextLanguages.keys.toSet(), {
      0,
      1,
      2,
      3,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      33,
      35,
      36,
      37,
      38,
    });
    expect(kGossipBooleanOptions, {0: '否', 1: '是'});
  });

  test('NPC 文本 UI 与 ViewModel 不使用数组或 Map 管理重复字段', () {
    final entity = File('lib/entity/npc_text_entity.dart').readAsStringSync();
    final locale = File(
      'lib/entity/npc_text_locale_entity.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/gossip_menu/npc_text_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/gossip_menu/npc_text_single_editor_view_model.dart',
    ).readAsStringSync();

    for (final source in [entity, locale, view, viewModel]) {
      expect(source, isNot(contains('List.generate')));
      expect(source, isNot(contains('for (')));
    }
    expect(viewModel, isNot(contains('_stringControllers')));
    expect(viewModel, isNot(contains('_intControllers')));
    expect(viewModel, isNot(contains('_doubleControllers')));
  });

  test('表演、POI、布尔字段与父子 Tab 使用精确控件', () {
    final npcView = File(
      'lib/page/gossip_menu/npc_text_view.dart',
    ).readAsStringSync();
    final optionView = File(
      'lib/page/gossip_menu/gossip_menu_option_view.dart',
    ).readAsStringSync();
    final detailPage = File(
      'lib/page/gossip_menu/gossip_menu_detail_page.dart',
    ).readAsStringSync();
    final optionRepository = readLocalDartLibrarySource(
      'lib/repository/gossip_menu_option_repository.dart',
    );

    expect(npcView, contains('FoxyEntityPickerDelegates.dbcEmote'));
    expect(npcView, contains("_delayField('延迟 1'"));
    expect(optionView, contains('FoxyEntityPickerDelegates.pointOfInterest'));
    expect(optionView, contains('options: kGossipBooleanOptions'));
    expect(detailPage, contains('disabledIndexes:'));
    expect(detailPage, contains('const {1, 2}'));
    expect(optionRepository, contains('optionId < 32'));
  });
}
