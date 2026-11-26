import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_template_resistance_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CreatureTemplateResistance key and brief entity', () {
    test('Both primary key fields participate in value equality', () {
      const entity = CreatureTemplateResistanceEntity(
        creatureID: 10,
        school: 2,
      );
      final key = CreatureTemplateResistanceKey.fromEntity(entity);

      expectRowKeyEquality(
        key,
        CreatureTemplateResistanceKey.fromEntity,
        sameKeyRow: entity.copyWith(resistance: 20),
        differentKeyRows: [
          entity.copyWith(creatureID: 11),
          entity.copyWith(school: 3),
        ],
      );
    });

    test('The brief entity provides the full typed key', () {
      const brief = BriefCreatureTemplateResistanceEntity(
        creatureID: 10,
        school: 2,
      );
      expect(
        brief.key,
        const CreatureTemplateResistanceKey(creatureID: 10, school: 2),
      );
    });
  });

  group('CreatureTemplateResistanceRepository write contract', () {
    const originalKey = CreatureTemplateResistanceKey(
      creatureID: 10,
      school: 2,
    );
    const candidate = CreatureTemplateResistanceEntity(
      creatureID: 11,
      school: 3,
      resistance: 50,
      verifiedBuild: 12340,
    );

    testRepositoryWrites(
      createRepository: _TestCreatureTemplateResistanceRepository.new,
      originalKey: originalKey,
      candidate: candidate,
      missingCandidate: const CreatureTemplateResistanceEntity(),
      update: (repository, key, row) =>
          repository.updateCreatureTemplateResistance(key, row),
      destroy: (repository, key) =>
          repository.destroyCreatureTemplateResistance(key),
      expectedBindings: [
        ...candidate.toJson().values,
        originalKey.creatureID,
        originalKey.school,
      ],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestCreatureTemplateResistanceRepository(laconic)
              .getBriefCreatureTemplateResistances(10, page: 2),
      verifyQuery: (query) {
        expect(query.bindings, [10, 50, 50]);
      },
    );
  });

  group('CreatureTemplateResistance inline identity', () {
    late _FakeCreatureTemplateResistanceRepository repository;

    late CreatureTemplateResistanceLinkedListViewModel viewModel;

    setUp(() async {
      repository = _FakeCreatureTemplateResistanceRepository([
        const CreatureTemplateResistanceEntity(
          creatureID: 10,
          school: 2,
          resistance: 20,
        ),
      ]);
      GetIt.instance.registerSingleton<CreatureTemplateResistanceRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());

      viewModel = CreatureTemplateResistanceLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('Editing a brief row updates by the old key and can move the row out of its parent scope', () async {
      const originalKey = CreatureTemplateResistanceKey(
        creatureID: 10,
        school: 2,
      );
      expect(viewModel.editingKey.value, originalKey);

      viewModel.creatureIDController.init(11);
      viewModel.schoolController.init(3);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.creatureID, 11);
      expect(repository.rows.single.school, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedKey.value, isNull);
    });

    test(
      'A failed save retains editingKey and retry uses the same old key',
      () async {
        final originalKey = repository.keyOf(repository.rows.single);
        viewModel.schoolController.init(3);

        await expectSaveRetry(
          repository: repository,
          originalKey: originalKey,
          editingKey: viewModel.editingKey,
          persist: viewModel.persist,
        );
      },
    );

    test('Changing the parent and creating clear editingKey', () async {
      await expectParentChangeAndCreateClearIdentity(
        editingKey: viewModel.editingKey,
        selectedKey: viewModel.selectedKey,
        changeParent: () async {
          await viewModel.setLinkKey(12);
          expect(viewModel.creatureIDController.collect(), 12);
        },
        create: viewModel.create,
      );
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });
}

class _FakeCreatureTemplateResistanceRepository
    extends CreatureTemplateResistanceRepository
    with
        InMemoryRowEditing<
          CreatureTemplateResistanceEntity,
          CreatureTemplateResistanceKey
        > {
  @override
  final List<CreatureTemplateResistanceEntity> rows;
  int storeCount = 0;

  _FakeCreatureTemplateResistanceRepository(this.rows);

  @override
  Future<int> countCreatureTemplateResistances(int creatureID) async {
    return rows.where((row) => row.creatureID == creatureID).length;
  }

  @override
  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    final schools = rows
        .where((row) => row.creatureID == creatureID)
        .map((row) => row.school);
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: CreatureTemplateResistanceRepository.nextAvailableSchool(schools),
    );
  }

  @override
  Future<List<BriefCreatureTemplateResistanceEntity>>
  getBriefCreatureTemplateResistances(int creatureID, {int page = 1}) async {
    return rows
        .where((row) => row.creatureID == creatureID)
        .map(
          (row) => BriefCreatureTemplateResistanceEntity(
            creatureID: row.creatureID,
            school: row.school,
            resistance: row.resistance,
            verifiedBuild: row.verifiedBuild,
          ),
        )
        .toList();
  }

  @override
  Future<CreatureTemplateResistanceEntity?> getCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async => findRow(key);

  @override
  CreatureTemplateResistanceKey keyOf(CreatureTemplateResistanceEntity row) =>
      CreatureTemplateResistanceKey.fromEntity(row);

  @override
  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    storeCount++;
    rows.add(resistance);
  }

  @override
  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceKey originalKey,
    CreatureTemplateResistanceEntity resistance,
  ) async => updateRow(originalKey, resistance);
}

class _TestCreatureTemplateResistanceRepository
    extends CreatureTemplateResistanceRepository {
  @override
  final Laconic laconic;

  _TestCreatureTemplateResistanceRepository(this.laconic);
}
