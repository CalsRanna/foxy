import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/entity/disenchant_loot_template_entity.dart';
import 'package:foxy/entity/game_object_loot_template_entity.dart';
import 'package:foxy/entity/item_loot_template_entity.dart';
import 'package:foxy/entity/milling_loot_template_entity.dart';
import 'package:foxy/entity/pickpocketing_loot_template_entity.dart';
import 'package:foxy/entity/prospecting_loot_template_entity.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/entity/skinning_loot_template_entity.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
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

import 'recording_driver.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  _testLootTemplate(
    table: 'creature_loot_template',
    createRepository: _CreatureTestRepository.new,
    entityFromJson: CreatureLootTemplateEntity.fromJson,
    keyFromEntity: CreatureLootTemplateKey.fromEntity,
    briefKeyFromJson: (json) =>
        BriefCreatureLootTemplateEntity.fromJson(json).key,
    toJson: (row) => row.toJson(),
    update: (repository, key, row) =>
        repository.updateCreatureLootTemplate(key, row),
    destroy: (repository, key) => repository.destroyCreatureLootTemplate(key),
    copy: (repository, key) => repository.copyCreatureLootTemplate(key),
    queryBrief: (repository) =>
        repository.getBriefCreatureLootTemplates(10, page: 2),
    keyColumns: ['Entry', 'Item', 'Reference', 'GroupId'],
    sameKeyChanges: {'Chance': 50},
    candidateChanges: {
      'Entry': 11,
      'Item': 21,
      'Reference': 31,
      'GroupId': 41,
      'Chance': 50,
      'LootMode': 1,
    },
  );

  final standardKeys = [
    _testLootTemplate(
      table: 'pickpocketing_loot_template',
      createRepository: _PickpocketingTestRepository.new,
      entityFromJson: PickpocketingLootTemplateEntity.fromJson,
      keyFromEntity: PickpocketingLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefPickpocketingLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updatePickpocketingLootTemplate(key, row),
      destroy: (repository, key) =>
          repository.destroyPickpocketingLootTemplate(key),
      copy: (repository, key) => repository.copyPickpocketingLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefPickpocketingLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'skinning_loot_template',
      createRepository: _SkinningTestRepository.new,
      entityFromJson: SkinningLootTemplateEntity.fromJson,
      keyFromEntity: SkinningLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefSkinningLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateSkinningLootTemplate(key, row),
      destroy: (repository, key) => repository.destroySkinningLootTemplate(key),
      copy: (repository, key) => repository.copySkinningLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefSkinningLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'item_loot_template',
      createRepository: _ItemTestRepository.new,
      entityFromJson: ItemLootTemplateEntity.fromJson,
      keyFromEntity: ItemLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefItemLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateItemLootTemplate(key, row),
      destroy: (repository, key) => repository.destroyItemLootTemplate(key),
      copy: (repository, key) => repository.copyItemLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefItemLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'disenchant_loot_template',
      createRepository: _DisenchantTestRepository.new,
      entityFromJson: DisenchantLootTemplateEntity.fromJson,
      keyFromEntity: DisenchantLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefDisenchantLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateDisenchantLootTemplate(key, row),
      destroy: (repository, key) =>
          repository.destroyDisenchantLootTemplate(key),
      copy: (repository, key) => repository.copyDisenchantLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefDisenchantLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'prospecting_loot_template',
      createRepository: _ProspectingTestRepository.new,
      entityFromJson: ProspectingLootTemplateEntity.fromJson,
      keyFromEntity: ProspectingLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefProspectingLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateProspectingLootTemplate(key, row),
      destroy: (repository, key) =>
          repository.destroyProspectingLootTemplate(key),
      copy: (repository, key) => repository.copyProspectingLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefProspectingLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'milling_loot_template',
      createRepository: _MillingTestRepository.new,
      entityFromJson: MillingLootTemplateEntity.fromJson,
      keyFromEntity: MillingLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefMillingLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateMillingLootTemplate(key, row),
      destroy: (repository, key) => repository.destroyMillingLootTemplate(key),
      copy: (repository, key) => repository.copyMillingLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefMillingLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'reference_loot_template',
      createRepository: _ReferenceTestRepository.new,
      entityFromJson: ReferenceLootTemplateEntity.fromJson,
      keyFromEntity: ReferenceLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefReferenceLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateReferenceLootTemplate(key, row),
      destroy: (repository, key) =>
          repository.destroyReferenceLootTemplate(key),
      copy: (repository, key) => repository.copyReferenceLootTemplate(key),
      queryBrief: (repository) => repository.getBriefLootTemplates(10, page: 2),
    ),
    _testLootTemplate(
      table: 'gameobject_loot_template',
      createRepository: _GameObjectTestRepository.new,
      entityFromJson: GameObjectLootTemplateEntity.fromJson,
      keyFromEntity: GameObjectLootTemplateKey.fromEntity,
      briefKeyFromJson: (json) =>
          BriefGameObjectLootTemplateEntity.fromJson(json).key,
      toJson: (row) => row.toJson(),
      update: (repository, key, row) =>
          repository.updateGameObjectLootTemplate(key, row),
      destroy: (repository, key) =>
          repository.destroyGameObjectLootTemplate(key),
      copy: (repository, key) => repository.copyGameObjectLootTemplate(key),
      queryBrief: (repository) =>
          repository.getBriefGameObjectLootTemplates(10, page: 2),
    ),
  ];

  test('The eight two-column tables use distinct concrete key types', () {
    expect(standardKeys.toSet(), hasLength(8));
  });
}

K _testLootTemplate<R, K, E>({
  required String table,
  required R Function(Laconic) createRepository,
  required E Function(Map<String, Object?>) entityFromJson,
  required K Function(E) keyFromEntity,
  required K Function(Map<String, Object?>) briefKeyFromJson,
  required Map<String, Object?> Function(E) toJson,
  required Future<void> Function(R, K, E) update,
  required Future<void> Function(R, K) destroy,
  required Future<K> Function(R, K) copy,
  required Future<void> Function(R) queryBrief,
  List<String> keyColumns = const ['Entry', 'Item'],
  Map<String, Object?> sameKeyChanges = const {'Reference': 31, 'GroupId': 41},
  Map<String, Object?> candidateChanges = const {'Entry': 11, 'Item': 21},
}) {
  const original = {'Entry': 10, 'Item': 20, 'Reference': 30, 'GroupId': 40};
  final originalEntity = entityFromJson(original);
  final originalKey = keyFromEntity(originalEntity);
  final candidate = entityFromJson({...original, ...candidateChanges});

  group(table, () {
    test('Every primary key field participates in value equality and the brief entity returns the same concrete key', () {
      expectRowKeyEquality(
        originalKey,
        keyFromEntity,
        sameKeyRow: entityFromJson({...original, ...sameKeyChanges}),
        differentKeyRows: [
          for (final column in keyColumns)
            entityFromJson({...original, column: original[column]! + 1}),
        ],
      );
      final briefKey = briefKeyFromJson(original);
      expect(briefKey, isA<K>());
      expect(briefKey, originalKey);
    });

    testRepositoryWrites(
      createRepository: createRepository,
      originalKey: originalKey,
      candidate: candidate,
      missingCandidate: originalEntity,
      update: update,
      destroy: destroy,
      expectedBindings: [
        ...toJson(candidate).values,
        for (final column in keyColumns) original[column],
      ],
      verifyUpdate: (query) => expect(query.sql, contains(table)),
    );

    test('Copying a missing source record reports an error', () async {
      final repository = createRepository(
        Laconic(RecordingDriver(affectedRows: 0)),
      );
      await expectLater(
        copy(repository, originalKey),
        throwsA(isA<RecordNotFoundException>()),
      );
    });

    testBriefPagination(
      queryPageTwo: (laconic) => queryBrief(createRepository(laconic)),
      tableAlias: 'lt',
      verifyQuery: (query) {
        expect(query.sql, contains(table));
        expect(query.sql, isNot(contains('lt.LootMode')));
        expect(query.sql, isNot(contains('lt.Comment')));
      },
    );
  });

  return originalKey;
}

class _CreatureTestRepository extends CreatureLootTemplateRepository {
  @override
  final Laconic laconic;
  _CreatureTestRepository(this.laconic);
}

class _DisenchantTestRepository extends DisenchantLootTemplateRepository {
  @override
  final Laconic laconic;
  _DisenchantTestRepository(this.laconic);
}

class _GameObjectTestRepository extends GameObjectLootTemplateRepository {
  @override
  final Laconic laconic;
  _GameObjectTestRepository(this.laconic);
}

class _ItemTestRepository extends ItemLootTemplateRepository {
  @override
  final Laconic laconic;
  _ItemTestRepository(this.laconic);
}

class _MillingTestRepository extends MillingLootTemplateRepository {
  @override
  final Laconic laconic;
  _MillingTestRepository(this.laconic);
}

class _PickpocketingTestRepository extends PickpocketingLootTemplateRepository {
  @override
  final Laconic laconic;
  _PickpocketingTestRepository(this.laconic);
}

class _ProspectingTestRepository extends ProspectingLootTemplateRepository {
  @override
  final Laconic laconic;
  _ProspectingTestRepository(this.laconic);
}

class _ReferenceTestRepository extends ReferenceLootTemplateRepository {
  @override
  final Laconic laconic;
  _ReferenceTestRepository(this.laconic);
}

class _SkinningTestRepository extends SkinningLootTemplateRepository {
  @override
  final Laconic laconic;
  _SkinningTestRepository(this.laconic);
}
