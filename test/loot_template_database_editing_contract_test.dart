import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_loot_template_entity.dart';
import 'package:foxy/entity/brief_creature_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_disenchant_loot_template_entity.dart';
import 'package:foxy/entity/brief_disenchant_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_game_object_loot_template_entity.dart';
import 'package:foxy/entity/brief_game_object_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_item_loot_template_entity.dart';
import 'package:foxy/entity/brief_item_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_milling_loot_template_entity.dart';
import 'package:foxy/entity/brief_milling_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_pickpocketing_loot_template_entity.dart';
import 'package:foxy/entity/brief_pickpocketing_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_prospecting_loot_template_entity.dart';
import 'package:foxy/entity/brief_prospecting_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_reference_loot_template_entity.dart';
import 'package:foxy/entity/brief_reference_loot_template_entry_entity.dart';
import 'package:foxy/entity/brief_skinning_loot_template_entity.dart';
import 'package:foxy/entity/brief_skinning_loot_template_entry_entity.dart';
import 'package:foxy/entity/creature_loot_template_key.dart';
import 'package:foxy/entity/disenchant_loot_template_key.dart';
import 'package:foxy/entity/game_object_loot_template_key.dart';
import 'package:foxy/entity/item_loot_template_key.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/milling_loot_template_key.dart';
import 'package:foxy/entity/pickpocketing_loot_template_key.dart';
import 'package:foxy/entity/prospecting_loot_template_key.dart';
import 'package:foxy/entity/reference_loot_template_key.dart';
import 'package:foxy/entity/skinning_loot_template_key.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/repository/disenchant_loot_template_repository.dart';
import 'package:foxy/repository/game_object_loot_template_repository.dart';
import 'package:foxy/repository/item_loot_template_repository.dart';
import 'package:foxy/repository/milling_loot_template_repository.dart';
import 'package:foxy/repository/pickpocketing_loot_template_repository.dart';
import 'package:foxy/repository/prospecting_loot_template_repository.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/repository/skinning_loot_template_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  group('loot template dedicated key and Brief boundaries', () {
    test('八张两列主键表使用各自具体 key', () {
      const entity = LootTemplateEntity(
        entry: 10,
        item: 20,
        reference: 30,
        groupId: 40,
      );
      final keys = <Object>[
        PickpocketingLootTemplateKey.fromEntity(entity),
        SkinningLootTemplateKey.fromEntity(entity),
        ItemLootTemplateKey.fromEntity(entity),
        DisenchantLootTemplateKey.fromEntity(entity),
        ProspectingLootTemplateKey.fromEntity(entity),
        MillingLootTemplateKey.fromEntity(entity),
        ReferenceLootTemplateKey.fromEntity(entity),
        GameObjectLootTemplateKey.fromEntity(entity),
      ];
      final sameKeys = <Object>[
        PickpocketingLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        SkinningLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        ItemLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        DisenchantLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        ProspectingLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        MillingLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        ReferenceLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
        GameObjectLootTemplateKey.fromEntity(
          entity.copyWith(reference: 31, groupId: 41),
        ),
      ];

      for (var index = 0; index < keys.length; index++) {
        expect(keys[index], sameKeys[index]);
        expect(keys[index].hashCode, sameKeys[index].hashCode);
      }
      expect(keys.toSet(), hasLength(8));
      expect(
        ItemLootTemplateKey.fromEntity(entity),
        isNot(ItemLootTemplateKey.fromEntity(entity.copyWith(entry: 11))),
      );
      expect(
        ItemLootTemplateKey.fromEntity(entity),
        isNot(ItemLootTemplateKey.fromEntity(entity.copyWith(item: 21))),
      );
    });

    test('生物掉落 key 覆盖 Entry、Item、Reference 和 GroupId', () {
      const entity = LootTemplateEntity(
        entry: 10,
        item: 20,
        reference: 30,
        groupId: 40,
      );
      final key = CreatureLootTemplateKey.fromEntity(entity);
      final same = CreatureLootTemplateKey.fromEntity(
        entity.copyWith(chance: 50),
      );

      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(
        key,
        isNot(
          CreatureLootTemplateKey.fromEntity(entity.copyWith(reference: 31)),
        ),
      );
      expect(
        key,
        isNot(CreatureLootTemplateKey.fromEntity(entity.copyWith(groupId: 41))),
      );
    });

    test('九张表的行 Brief 返回各自具体 key，Entry Brief 使用标量 key', () {
      const row = {'Entry': 10, 'Item': 20, 'Reference': 30, 'GroupId': 40};
      final briefs = <dynamic>[
        BriefCreatureLootTemplateEntity.fromJson(row),
        BriefPickpocketingLootTemplateEntity.fromJson(row),
        BriefSkinningLootTemplateEntity.fromJson(row),
        BriefItemLootTemplateEntity.fromJson(row),
        BriefDisenchantLootTemplateEntity.fromJson(row),
        BriefProspectingLootTemplateEntity.fromJson(row),
        BriefMillingLootTemplateEntity.fromJson(row),
        BriefReferenceLootTemplateEntity.fromJson(row),
        BriefGameObjectLootTemplateEntity.fromJson(row),
      ];
      expect(briefs[0].key, isA<CreatureLootTemplateKey>());
      expect(briefs[1].key, isA<PickpocketingLootTemplateKey>());
      expect(briefs[2].key, isA<SkinningLootTemplateKey>());
      expect(briefs[3].key, isA<ItemLootTemplateKey>());
      expect(briefs[4].key, isA<DisenchantLootTemplateKey>());
      expect(briefs[5].key, isA<ProspectingLootTemplateKey>());
      expect(briefs[6].key, isA<MillingLootTemplateKey>());
      expect(briefs[7].key, isA<ReferenceLootTemplateKey>());
      expect(briefs[8].key, isA<GameObjectLootTemplateKey>());

      const entryRow = {'Entry': 10, 'ItemCount': 5};
      final entryBriefs = <dynamic>[
        BriefCreatureLootTemplateEntryEntity.fromJson(entryRow),
        BriefPickpocketingLootTemplateEntryEntity.fromJson(entryRow),
        BriefSkinningLootTemplateEntryEntity.fromJson(entryRow),
        BriefItemLootTemplateEntryEntity.fromJson(entryRow),
        BriefDisenchantLootTemplateEntryEntity.fromJson(entryRow),
        BriefProspectingLootTemplateEntryEntity.fromJson(entryRow),
        BriefMillingLootTemplateEntryEntity.fromJson(entryRow),
        BriefReferenceLootTemplateEntryEntity.fromJson(entryRow),
        BriefGameObjectLootTemplateEntryEntity.fromJson(entryRow),
      ];
      for (final brief in entryBriefs) {
        expect(brief.entry, 10);
        expect(brief.itemCount, 5);
        expect(brief.key, 10);
      }
    });
  });

  group('dedicated loot template repository write contracts', () {
    test('八张两列主键表均使用旧 key 定位并写入完整 candidate', () async {
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
      for (final spec in _standardRepositorySpecs()) {
        final queries = <LaconicQuery>[];
        final repository = spec.create(
          Laconic(_RecordingDriver(), listen: queries.add),
        );

        await repository.updateLootTemplate(spec.key, candidate);

        expect(queries.single.sql, contains(spec.table), reason: spec.table);
        expect(queries.single.bindings, [
          ...candidate.toJson().values,
          10,
          20,
        ], reason: spec.table);
      }
    });

    test('生物掉落 UPDATE 使用旧四列 key 并写入完整 candidate', () async {
      final queries = <LaconicQuery>[];
      final repository = _CreatureTestRepository(
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

    test('九张表的 UPDATE、DELETE 与复制均报告原记录不存在', () async {
      for (final spec in _allRepositorySpecs(affectedRows: 0)) {
        await expectLater(
          spec.repository.updateLootTemplate(
            spec.key,
            const LootTemplateEntity(),
          ),
          throwsA(isA<StateError>()),
          reason: '${spec.table} update',
        );
        await expectLater(
          spec.repository.destroyLootTemplate(spec.key),
          throwsA(isA<StateError>()),
          reason: '${spec.table} delete',
        );
        await expectLater(
          spec.repository.copyLootTemplate(spec.key),
          throwsA(isA<StateError>()),
          reason: '${spec.table} copy',
        );
      }
    });

    test('九张表的 Brief 查询显式选择展示列、使用正确表并分页', () async {
      for (final spec in _allRepositorySpecs()) {
        final queries = <LaconicQuery>[];
        final repository = spec.create(
          Laconic(_RecordingDriver(), listen: queries.add),
        );

        await repository.getBriefLootTemplates(10, page: 2);

        final query = queries.single;
        expect(query.sql, contains(spec.table), reason: spec.table);
        expect(query.sql, isNot(contains('lt.*')), reason: spec.table);
        expect(query.sql, isNot(contains('lt.LootMode')), reason: spec.table);
        expect(query.sql, isNot(contains('lt.Comment')), reason: spec.table);
        expect(
          query.sql.toLowerCase(),
          contains('limit ? offset ?'),
          reason: spec.table,
        );
        expect(query.bindings.sublist(query.bindings.length - 2), [
          50,
          50,
        ], reason: spec.table);
      }
    });
  });

  test('全部 loot consumer 使用具体 editingKey、完整加载和可编辑 key 控件', () {
    const viewModelKeyTypes = {
      'lib/page/creature_template/creature_loot_template_view_model.dart':
          'CreatureLootTemplateKey',
      'lib/page/creature_template/'
              'pickpocketing_loot_template_view_model.dart':
          'PickpocketingLootTemplateKey',
      'lib/page/creature_template/skinning_loot_template_view_model.dart':
          'SkinningLootTemplateKey',
      'lib/page/game_object/game_object_loot_template_view_model.dart':
          'GameObjectLootTemplateKey',
      'lib/page/item/item_loot_template_view_model.dart': 'ItemLootTemplateKey',
      'lib/page/item/disenchant_loot_template_view_model.dart':
          'DisenchantLootTemplateKey',
      'lib/page/item/milling_loot_template_view_model.dart':
          'MillingLootTemplateKey',
      'lib/page/item/prospecting_loot_template_view_model.dart':
          'ProspectingLootTemplateKey',
    };
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

    for (final entry in viewModelKeyTypes.entries) {
      final source = File(entry.key).readAsStringSync();
      expect(
        source,
        contains('final editingKey = signal<${entry.value}?>(null)'),
        reason: entry.key,
      );
      expect(source, contains('getLootTemplate(key)'), reason: entry.key);
      expect(
        source,
        matches(RegExp(r'destroyLootTemplate\(\w+\.key\)')),
        reason: entry.key,
      );
      expect(source, isNot(contains('editingItem')), reason: entry.key);
      expect(
        source,
        contains('Future<void> paginate(int page)'),
        reason: entry.key,
      );
    }
    for (final path in viewPaths) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('readOnly:')), reason: path);
      expect(source, contains('FoxyPagination('), reason: path);
    }

    final repository = File(
      'lib/repository/creature_loot_template_repository.dart',
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
      contains('final persistedKey = signal<ReferenceLootTemplateKey?>'),
    );
    final referenceView = File(
      'lib/page/reference_loot_template/reference_loot_template_view.dart',
    ).readAsStringSync();
    expect(referenceView, isNot(contains('readOnly:')));
  });

  test('通用 LootTableType、key 和 Brief 类型已完全移除', () {
    const removedPaths = [
      'lib/entity/loot_table_type.dart',
      'lib/entity/loot_template_key.dart',
      'lib/entity/loot_template_entry_key.dart',
      'lib/entity/brief_loot_template_entity.dart',
      'lib/entity/brief_loot_template_entry_entity.dart',
    ];
    for (final path in removedPaths) {
      expect(File(path).existsSync(), isFalse, reason: path);
    }
  });
}

List<({String table, dynamic Function(Laconic) create, dynamic key})>
_standardRepositorySpecs() {
  return [
    (
      table: 'pickpocketing_loot_template',
      create: (laconic) => _PickpocketingTestRepository(laconic),
      key: const PickpocketingLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'skinning_loot_template',
      create: (laconic) => _SkinningTestRepository(laconic),
      key: const SkinningLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'item_loot_template',
      create: (laconic) => _ItemTestRepository(laconic),
      key: const ItemLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'disenchant_loot_template',
      create: (laconic) => _DisenchantTestRepository(laconic),
      key: const DisenchantLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'prospecting_loot_template',
      create: (laconic) => _ProspectingTestRepository(laconic),
      key: const ProspectingLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'milling_loot_template',
      create: (laconic) => _MillingTestRepository(laconic),
      key: const MillingLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'reference_loot_template',
      create: (laconic) => _ReferenceTestRepository(laconic),
      key: const ReferenceLootTemplateKey(entry: 10, item: 20),
    ),
    (
      table: 'gameobject_loot_template',
      create: (laconic) => _GameObjectTestRepository(laconic),
      key: const GameObjectLootTemplateKey(entry: 10, item: 20),
    ),
  ];
}

List<
  ({
    String table,
    dynamic Function(Laconic) create,
    dynamic repository,
    dynamic key,
  })
>
_allRepositorySpecs({int affectedRows = 1}) {
  final standard = _standardRepositorySpecs();
  final specs = [
    (
      table: 'creature_loot_template',
      create: (Laconic laconic) => _CreatureTestRepository(laconic),
      key: const CreatureLootTemplateKey(
        entry: 10,
        item: 20,
        reference: 30,
        groupId: 40,
      ),
    ),
    ...standard,
  ];
  return specs
      .map(
        (spec) => (
          table: spec.table,
          create: spec.create,
          repository: spec.create(
            Laconic(_RecordingDriver(affectedRows: affectedRows)),
          ),
          key: spec.key,
        ),
      )
      .toList();
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

class _CreatureTestRepository extends CreatureLootTemplateRepository {
  @override
  final Laconic laconic;
  _CreatureTestRepository(this.laconic);
}

class _PickpocketingTestRepository extends PickpocketingLootTemplateRepository {
  @override
  final Laconic laconic;
  _PickpocketingTestRepository(this.laconic);
}

class _SkinningTestRepository extends SkinningLootTemplateRepository {
  @override
  final Laconic laconic;
  _SkinningTestRepository(this.laconic);
}

class _ItemTestRepository extends ItemLootTemplateRepository {
  @override
  final Laconic laconic;
  _ItemTestRepository(this.laconic);
}

class _DisenchantTestRepository extends DisenchantLootTemplateRepository {
  @override
  final Laconic laconic;
  _DisenchantTestRepository(this.laconic);
}

class _ProspectingTestRepository extends ProspectingLootTemplateRepository {
  @override
  final Laconic laconic;
  _ProspectingTestRepository(this.laconic);
}

class _MillingTestRepository extends MillingLootTemplateRepository {
  @override
  final Laconic laconic;
  _MillingTestRepository(this.laconic);
}

class _ReferenceTestRepository extends ReferenceLootTemplateRepository {
  @override
  final Laconic laconic;
  _ReferenceTestRepository(this.laconic);
}

class _GameObjectTestRepository extends GameObjectLootTemplateRepository {
  @override
  final Laconic laconic;
  _GameObjectTestRepository(this.laconic);
}
