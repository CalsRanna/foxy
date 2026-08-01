import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/constant/loot_template_constants.dart';

void main() {
  test('Entity 精确覆盖 reference_loot_template 的 10 个标量物理列', () {
    final json = const ReferenceLootTemplateEntity().toJson();
    expect(json.keys.toList(), [
      'Entry',
      'Item',
      'Reference',
      'Chance',
      'QuestRequired',
      'LootMode',
      'GroupId',
      'MinCount',
      'MaxCount',
      'Comment',
    ]);
    expect(json['Chance'], isA<double>());
    expect(json['Comment'], isA<String>());
    for (final key in json.keys.where(
      (key) => key != 'Chance' && key != 'Comment',
    )) {
      expect(json[key], isA<int>(), reason: key);
    }
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('Entity 默认值与 AzerothCore core SQL 一致', () {
    final entity = const ReferenceLootTemplateEntity();
    expect(entity.entry, 0);
    expect(entity.item, 0);
    expect(entity.reference, 0);
    expect(entity.chance, 100);
    expect(entity.questRequired, isFalse);
    expect(entity.lootMode, 1);
    expect(entity.groupId, 0);
    expect(entity.minCount, 1);
    expect(entity.maxCount, 1);
    expect(entity.comment, '');
  });

  test('fromJson 接受 MySQL 数值类型并保持十列 round-trip', () {
    final entity = ReferenceLootTemplateEntity.fromJson({
      'Entry': 1001,
      'Item': 36917,
      'Reference': 0,
      'Chance': 16,
      'QuestRequired': 1,
      'LootMode': 0x8001,
      'GroupId': 1,
      'MinCount': 1,
      'MaxCount': 2,
      'Comment': 'Bloodstone',
    });
    expect(entity.chance, 16.0);
    expect(entity.questRequired, isTrue);
    expect(entity.toJson(), {
      'Entry': 1001,
      'Item': 36917,
      'Reference': 0,
      'Chance': 16.0,
      'QuestRequired': 1,
      'LootMode': 0x8001,
      'GroupId': 1,
      'MinCount': 1,
      'MaxCount': 2,
      'Comment': 'Bloodstone',
    });
  });

  test('LootMode Flags 覆盖 SharedDefines.h 及 core base 数据专用位', () {
    expect(kLootModeFlagOptions.map((flag) => flag.value).toSet(), {
      0x0001,
      0x0002,
      0x0004,
      0x0008,
      0x0010,
      0x0020,
      0x8000,
    });
    expect(kLootTemplateValidLootModeMask, 0x803f);
  });

}
