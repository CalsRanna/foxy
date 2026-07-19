import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_loot_template_entity.dart';
import 'package:foxy/entity/brief_loot_template_entry_entity.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_entry_key.dart';
import 'package:foxy/entity/loot_template_key.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  group('loot template key shapes and Brief boundaries', () {
    test('两列 key 使用 Entry 和 Item 完整值相等', () {
      const entity = LootTemplateEntity(
        entry: 10,
        item: 20,
        reference: 30,
        groupId: 40,
      );
      final key = LootTemplateKey.fromEntity(LootTableType.item, entity);
      final same = LootTemplateKey.fromEntity(
        LootTableType.item,
        entity.copyWith(reference: 31, groupId: 41),
      );

      expect(key, isA<StandardLootTemplateKey>());
      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(
        key,
        isNot(
          LootTemplateKey.fromEntity(
            LootTableType.item,
            entity.copyWith(entry: 11),
          ),
        ),
      );
      expect(
        key,
        isNot(
          LootTemplateKey.fromEntity(
            LootTableType.item,
            entity.copyWith(item: 21),
          ),
        ),
      );
    });

    test('生物掉落 key 覆盖 Entry、Item、Reference 和 GroupId', () {
      const entity = LootTemplateEntity(
        entry: 10,
        item: 20,
        reference: 30,
        groupId: 40,
      );
      final key = LootTemplateKey.fromEntity(LootTableType.creature, entity);
      final same = LootTemplateKey.fromEntity(
        LootTableType.creature,
        entity.copyWith(chance: 50),
      );

      expect(key, isA<CreatureLootTemplateKey>());
      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(
        key,
        isNot(
          LootTemplateKey.fromEntity(
            LootTableType.creature,
            entity.copyWith(reference: 31),
          ),
        ),
      );
      expect(
        key,
        isNot(
          LootTemplateKey.fromEntity(
            LootTableType.creature,
            entity.copyWith(groupId: 41),
          ),
        ),
      );
    });

    test('行 Brief 提供对应表 key，Entry 聚合使用独立 Brief 类型', () {
      final creatureBrief = BriefLootTemplateEntity.fromJson(const {
        'Entry': 10,
        'Item': 20,
        'Reference': 30,
        'GroupId': 40,
      }, tableType: LootTableType.creature);
      final standardBrief = BriefLootTemplateEntity.fromJson(const {
        'Entry': 10,
        'Item': 20,
        'Reference': 30,
        'GroupId': 40,
      }, tableType: LootTableType.reference);
      final entryBrief = BriefLootTemplateEntryEntity.fromJson(const {
        'Entry': 10,
        'ItemCount': 5,
      }, tableType: LootTableType.reference);

      expect(
        creatureBrief.key,
        const CreatureLootTemplateKey(
          entry: 10,
          item: 20,
          reference: 30,
          groupId: 40,
        ),
      );
      expect(
        standardBrief.key,
        const StandardLootTemplateKey(entry: 10, item: 20),
      );
      expect(entryBrief.entry, 10);
      expect(entryBrief.itemCount, 5);
      expect(
        entryBrief.key,
        const LootTemplateEntryKey(
          tableType: LootTableType.reference,
          entry: 10,
        ),
      );
    });
  });

  group('LootTemplateRepository write contract', () {
    test('两列 UPDATE 使用旧 key 定位并写入 candidate 全部十列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestRepository(
        LootTableType.item,
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = StandardLootTemplateKey(entry: 10, item: 20);
      const candidate = LootTemplateEntity(
        entry: 11,
        item: 21,
        reference: 22,
        chance: 23,
        questRequired: true,
        lootMode: 1,
        groupId: 24,
        minCount: 25,
        maxCount: 26,
        comment: 'candidate',
      );

      await repository.updateLootTemplate(originalKey, candidate);

      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.entry,
        originalKey.item,
      ]);
    });

    test('生物掉落 UPDATE 使用旧四列 key 并写入完整 candidate', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestRepository(
        LootTableType.creature,
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = CreatureLootTemplateKey(
        entry: 10,
        item: 20,
        reference: 30,
        groupId: 40,
      );
      const candidate = LootTemplateEntity(
        entry: 11,
        item: 21,
        reference: 31,
        chance: 50,
        lootMode: 1,
        groupId: 41,
      );

      await repository.updateLootTemplate(originalKey, candidate);

      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.entry,
        originalKey.item,
        originalKey.reference,
        originalKey.groupId,
      ]);
    });

    test('UPDATE 和 DELETE 零行结果报告旧记录不存在', () async {
      final repository = _TestRepository(
        LootTableType.item,
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      const key = StandardLootTemplateKey(entry: 10, item: 20);

      await expectLater(
        repository.updateLootTemplate(key, const LootTemplateEntity()),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        repository.destroyLootTemplate(key),
        throwsA(isA<StateError>()),
      );
    });

    test('Brief 查询显式选择展示列和 locator，并分页', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestRepository(
        LootTableType.item,
        Laconic(_RecordingDriver(), listen: queries.add),
      );

      await repository.getBriefLootTemplates(10, page: 2);

      final query = queries.single;
      expect(query.sql, isNot(contains('lt.*')));
      expect(query.sql, isNot(contains('lt.LootMode')));
      expect(query.sql, isNot(contains('lt.Comment')));
      expect(query.sql.toLowerCase(), contains('limit ? offset ?'));
      expect(query.bindings.sublist(query.bindings.length - 2), [50, 50]);
    });
  });

  test('全部 loot consumer 使用 editingKey、完整加载和可编辑 key 控件', () {
    const viewModelPaths = [
      'lib/page/creature_template/creature_loot_template_view_model.dart',
      'lib/page/creature_template/pickpocketing_loot_template_view_model.dart',
      'lib/page/creature_template/skinning_loot_template_view_model.dart',
      'lib/page/game_object/game_object_loot_template_view_model.dart',
      'lib/page/item/item_loot_template_view_model.dart',
      'lib/page/item/disenchant_loot_template_view_model.dart',
      'lib/page/item/milling_loot_template_view_model.dart',
      'lib/page/item/prospecting_loot_template_view_model.dart',
    ];
    const viewPaths = [
      'lib/page/creature_template/creature_loot_template_view.dart',
      'lib/page/creature_template/pickpocketing_loot_template_view.dart',
      'lib/page/creature_template/skinning_loot_template_view.dart',
      'lib/page/game_object/game_object_loot_template_view.dart',
      'lib/page/item/item_loot_template_view.dart',
      'lib/page/item/disenchant_loot_template_view.dart',
      'lib/page/item/milling_loot_template_view.dart',
      'lib/page/item/prospecting_loot_template_view.dart',
    ];

    for (final path in viewModelPaths) {
      final source = File(path).readAsStringSync();
      expect(
        source,
        contains('final editingKey = signal<LootTemplateKey?>(null)'),
        reason: path,
      );
      expect(source, contains('getLootTemplate(key)'), reason: path);
      expect(
        source,
        matches(RegExp(r'destroyLootTemplate\(\w+\.key\)')),
        reason: path,
      );
      expect(source, isNot(contains('editingItem')), reason: path);
      expect(source, contains('Future<void> paginate(int page)'), reason: path);
    }
    for (final path in viewPaths) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('readOnly:')), reason: path);
      expect(source, contains('FoxyPagination('), reason: path);
    }

    final repository = File(
      'lib/repository/loot_template_repository.dart',
    ).readAsStringSync();
    final referenceViewModel = File(
      'lib/page/reference_loot_template/'
      'reference_loot_template_detail_view_model.dart',
    ).readAsStringSync();
    expect(repository, isNot(contains('saveLootTemplate')));
    expect(repository, isNot(contains('_validateReferences')));
    expect(repository, isNot(contains(".table('item_template')")));
    expect(
      referenceViewModel,
      contains('final persistedKey = signal<LootTemplateKey?>'),
    );
    final referenceView = File(
      'lib/page/reference_loot_template/reference_loot_template_view.dart',
    ).readAsStringSync();
    expect(referenceView, isNot(contains('readOnly:')));
  });
}

class _RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();
  final int affectedRows;

  _RecordingDriver({this.affectedRows = 1});

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async => affectedRows;

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async => 1;

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => const [];

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {}

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}

class _TestRepository extends LootTemplateRepository {
  @override
  final Laconic laconic;

  _TestRepository(super.tableType, this.laconic);
}
