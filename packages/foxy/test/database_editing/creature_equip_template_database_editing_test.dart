import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_equip_template_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CreatureEquipTemplateKey and its brief entity include both primary key fields', () {
    const entity = CreatureEquipTemplateEntity(creatureID: 10, id: 2);
    final key = CreatureEquipTemplateKey.fromEntity(entity);
    const brief = BriefCreatureEquipTemplateEntity(creatureID: 10, id: 2);

    expectRowKeyEquality(
      key,
      CreatureEquipTemplateKey.fromEntity,
      sameKeyRow: entity.copyWith(itemID1: 123),
      differentKeyRows: [entity.copyWith(id: 3)],
    );
    expect(brief.key, key);
  });

  group('CreatureEquipTemplateRepository write contract', () {
    const oldKey = CreatureEquipTemplateKey(creatureID: 10, id: 2);
    const candidate = CreatureEquipTemplateEntity(
      creatureID: 11,
      id: 3,
      itemID1: 101,
      itemID2: 102,
      itemID3: 103,
      verifiedBuild: 12340,
    );

    testRepositoryWrites(
      createRepository: _TestCreatureEquipTemplateRepository.new,
      originalKey: oldKey,
      candidate: candidate,
      missingCandidate: const CreatureEquipTemplateEntity(),
      update: (repository, key, row) =>
          repository.updateCreatureEquipTemplate(key, row),
      destroy: (repository, key) =>
          repository.destroyCreatureEquipTemplate(key),
      expectedBindings: [
        ...candidate.toJson().values,
        oldKey.creatureID,
        oldKey.id,
      ],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestCreatureEquipTemplateRepository(laconic)
              .getBriefCreatureEquipTemplates(10, page: 2),
      tableAlias: 'cet',
      verifyQuery: (query) {
        expect(query.sql, contains('cet.ItemID1'));
        expect(query.sql, contains('cet.ItemID2'));
        expect(query.sql, contains('cet.ItemID3'));
      },
    );
  });

  group('CreatureEquipTemplate inline identity', () {
    late _FakeCreatureEquipTemplateRepository repository;

    late CreatureEquipTemplateLinkedListViewModel viewModel;

    setUp(() async {
      repository = _FakeCreatureEquipTemplateRepository([
        const CreatureEquipTemplateEntity(creatureID: 10, id: 2, itemID1: 101),
      ]);
      GetIt.instance.registerSingleton<CreatureEquipTemplateRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());

      viewModel = CreatureEquipTemplateLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async => GetIt.instance.reset());

    test('Changing the key updates by the old key and a failed save preserves it for retry', () async {
      const oldKey = CreatureEquipTemplateKey(creatureID: 10, id: 2);
      viewModel.creatureIDController.init(11);
      viewModel.idController.init(3);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );
      expect(repository.rows.single.creatureID, 11);
      expect(repository.rows.single.id, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('Changing the parent and creating clear editingKey and creation uses the preallocated ID', () async {
      await expectParentChangeAndCreateClearIdentity(
        editingKey: viewModel.editingKey,
        selectedKey: viewModel.selectedKey,
        changeParent: () => viewModel.setLinkKey(12),
        create: viewModel.create,
      );
      expect(viewModel.idController.collect(), 1);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });
}

class _FakeCreatureEquipTemplateRepository
    extends CreatureEquipTemplateRepository
    with
        InMemoryRowEditing<
          CreatureEquipTemplateEntity,
          CreatureEquipTemplateKey
        > {
  @override
  final List<CreatureEquipTemplateEntity> rows;
  int storeCount = 0;

  _FakeCreatureEquipTemplateRepository(this.rows);

  @override
  Future<int> countCreatureEquipTemplates(int creatureID) async =>
      rows.where((row) => row.creatureID == creatureID).length;

  @override
  Future<CreatureEquipTemplateEntity> createCreatureEquipTemplate(
    int creatureID,
  ) async {
    final ids = rows
        .where((row) => row.creatureID == creatureID)
        .map((row) => row.id);
    final id = ids.isEmpty ? 1 : ids.reduce((a, b) => a > b ? a : b) + 1;
    return CreatureEquipTemplateEntity(creatureID: creatureID, id: id);
  }

  @override
  Future<List<BriefCreatureEquipTemplateEntity>> getBriefCreatureEquipTemplates(
    int creatureID, {
    int page = 1,
  }) async => rows
      .where((row) => row.creatureID == creatureID)
      .map(
        (row) => BriefCreatureEquipTemplateEntity(
          creatureID: row.creatureID,
          id: row.id,
          itemID1: row.itemID1,
          itemID2: row.itemID2,
          itemID3: row.itemID3,
          verifiedBuild: row.verifiedBuild,
        ),
      )
      .toList();

  @override
  Future<CreatureEquipTemplateEntity?> getCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async => findRow(key);

  @override
  CreatureEquipTemplateKey keyOf(CreatureEquipTemplateEntity row) =>
      CreatureEquipTemplateKey.fromEntity(row);

  @override
  Future<void> storeCreatureEquipTemplate(
    CreatureEquipTemplateEntity equip,
  ) async {
    storeCount++;
    rows.add(equip);
  }

  @override
  Future<void> updateCreatureEquipTemplate(
    CreatureEquipTemplateKey originalKey,
    CreatureEquipTemplateEntity equip,
  ) async => updateRow(originalKey, equip);
}

class _TestCreatureEquipTemplateRepository
    extends CreatureEquipTemplateRepository {
  @override
  final Laconic laconic;
  _TestCreatureEquipTemplateRepository(this.laconic);
}
