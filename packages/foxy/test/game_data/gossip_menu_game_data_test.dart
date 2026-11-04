import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/entity/point_of_interest_entity.dart';

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

  test('NPC 标识掩码展开为标签，未命中回退', () {
    const option = BriefGossipMenuOptionEntity(optionNpcFlag: 0x01 | 0x80);
    expect(option.optionNpcFlagLabel, '对话, 商人');
    expect(
      const BriefGossipMenuOptionEntity(optionNpcFlag: 0).optionNpcFlagLabel,
      '0',
    );
  });
}
