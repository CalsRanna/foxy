import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/constant/loot_template_constants.dart';
import 'package:foxy/repository/loot_template_repository.dart';

void main() {
  test('Entity 精确覆盖 reference_loot_template 的 10 个标量物理列', () {
    final json = const LootTemplateEntity().toJson();
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
    final entity = const LootTemplateEntity();
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
    final entity = LootTemplateEntity.fromJson({
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

  test('Entity 拒绝 LootMgr 会跳过、修正或忽略的值', () {
    expect(const LootTemplateEntity(item: 1).validate, returnsNormally);
    expect(
      const LootTemplateEntity(
        item: 1,
        reference: 1001,
        minCount: 2,
        maxCount: 2,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const LootTemplateEntity(item: 1, lootMode: 0).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, lootMode: 0x40).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, groupId: 128).validate(),
      throwsRangeError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, minCount: 0).validate(),
      throwsRangeError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, chance: 0).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, chance: 100.1).validate(),
      throwsRangeError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, minCount: 2).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(
        item: 1,
        reference: 1001,
        questRequired: true,
      ).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(
        item: 1,
        reference: 1001,
        minCount: 1,
        maxCount: 2,
      ).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(item: -1).validate(),
      throwsRangeError,
    );
  });

  test('Repository 使用正确复合主键并按行类型校验真实引用', () {
    expect(
      LootTemplateRepository.primaryKeyColumnsFor(LootTableType.reference),
      {'Entry', 'Item'},
    );
    final source = File(
      'lib/repository/loot_template_repository.dart',
    ).readAsStringSync();
    expect(source, contains(".table('item_template')"));
    expect(source, contains(".table(LootTableType.reference.tableName)"));
    expect(source, contains(".where('Entry', loot.reference.abs())"));
    expect(source, contains("builder = builder.groupBy('Entry')"));
    expect(source, contains('tableType == LootTableType.reference'));
    expect(source, contains("nextMaxPlusOne(_table, 'Entry')"));
  });

  test('Repository 复制行时保留 Reference 并复用引用校验写入路径', () {
    final source = File(
      'lib/repository/loot_template_repository.dart',
    ).readAsStringSync();
    expect(
      source,
      contains('source.copyWith(item: await getNextItemId(entry))'),
    );
    expect(source, contains('await storeLootTemplate(copied);'));
    expect(source, isNot(contains("json['Reference'] = nextItem")));
  });

  test('详情表单按字段语义使用 Picker/Flags 且每行四列等宽', () {
    final view = File(
      'lib/page/reference_loot_template/reference_loot_template_view.dart',
    ).readAsStringSync();
    expect(view, contains('FoxyEntityPickerDelegates.itemTemplate'));
    expect(view, contains('FoxyEntityPickerDelegates.referenceLoot'));
    expect(view, contains("label: '引用模板 ID'"));
    expect(view, contains('FoxyFlagPicker('));
    expect(view, contains('flags: kLootModeFlagOptions'));
    expect(view, contains('enabled: !viewModel.hasReference.value'));
    expect('Expanded(child:'.allMatches(view), hasLength(12));
    expect(view, isNot(contains('flex:')));
    expect(view, isNot(contains('description:')));
  });

  test('ViewModel 十个 Controller 与实体字段逐一初始化和收集', () {
    final source = File(
      'lib/page/reference_loot_template/'
      'reference_loot_template_detail_view_model.dart',
    ).readAsStringSync();
    expect('registerController('.allMatches(source), hasLength(10));
    expect(source, contains('FlagFieldController()'));
    expect(source, contains('referenceController.addListener'));
    expect(source, contains('questRequiredController.init(0)'));
    expect(source, contains('reference: referenceController.collect()'));
    expect(source, contains('lootMode: lootModeController.collect()'));
  });
}
