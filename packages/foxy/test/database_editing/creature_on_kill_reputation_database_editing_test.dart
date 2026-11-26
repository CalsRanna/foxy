import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_on_kill_reputation_linked_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('The key and brief entity identify rows by creature_id', () {
    const entity = CreatureOnKillReputationEntity(creatureID: 10);
    final key = entity.creatureID;
    final same = (entity.copyWith(maxStanding1: 4)).creatureID;
    const brief = BriefCreatureOnKillReputationEntity(creatureID: 10);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(key, isNot((entity.copyWith(creatureID: 11)).creatureID));
    expect(brief.key, key);
  });

  group('Repository write contract', () {
    const oldKey = 10;
    const candidate = CreatureOnKillReputationEntity(
      creatureID: 11,
      rewOnKillRepFaction1: 1,
      rewOnKillRepFaction2: 2,
      maxStanding1: 3,
      maxStanding2: 4,
      isTeamAward1: true,
      isTeamAward2: false,
      rewOnKillRepValue1: 5.5,
      rewOnKillRepValue2: -2.0,
      teamDependent: 1,
    );

    testRepositoryWrites(
      createRepository: _TestRepository.new,
      originalKey: oldKey,
      candidate: candidate,
      missingCandidate: const CreatureOnKillReputationEntity(),
      update: (repository, key, row) =>
          repository.updateCreatureOnKillReputation(key, row),
      destroy: (repository, key) =>
          repository.destroyCreatureOnKillReputation(key),
      expectedBindings: [...candidate.toJson().values, oldKey],
    );
  });

  group('one-row child persisted identity', () {
    late _FakeRepository repository;

    setUp(() {
      repository = _FakeRepository([
        const CreatureOnKillReputationEntity(creatureID: 10),
      ]);
      GetIt.instance.registerSingleton<CreatureOnKillReputationRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async => GetIt.instance.reset());

    test('A failed key change preserves the old key and success resolves identity in the current parent scope', () async {
      final viewModel = CreatureOnKillReputationLinkedDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      const oldKey = 10;
      expect(viewModel.editingKey.value, oldKey);
      viewModel.creatureIDController.init(11);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.creatureIDController.collect(), 10);

      await viewModel.setLinkKey(11);
      expect(viewModel.editingKey.value, 11);
    });

    test('A missing child is created and its persisted key becomes the editing key', () async {
      final viewModel = CreatureOnKillReputationLinkedDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 12);
      expect(viewModel.editingKey.value, isNull);

      await viewModel.persist();

      expect(repository.storeCount, 1);
      expect(viewModel.editingKey.value, 12);
    });
  });
}

class _FakeRepository extends CreatureOnKillReputationRepository
    with InMemoryRowEditing<CreatureOnKillReputationEntity, int> {
  @override
  final List<CreatureOnKillReputationEntity> rows;
  int storeCount = 0;

  _FakeRepository(this.rows);

  @override
  Future<CreatureOnKillReputationEntity?> getCreatureOnKillReputation(
    int key,
  ) async => findRow(key);

  @override
  int keyOf(CreatureOnKillReputationEntity row) => row.creatureID;

  @override
  Future<int> storeCreatureOnKillReputation(
    CreatureOnKillReputationEntity rep,
  ) async {
    storeCount++;
    rows.add(rep);
    return rep.creatureID;
  }

  @override
  Future<void> updateCreatureOnKillReputation(
    int originalKey,
    CreatureOnKillReputationEntity rep,
  ) async => updateRow(originalKey, rep);
}

class _TestRepository extends CreatureOnKillReputationRepository {
  @override
  final Laconic laconic;
  _TestRepository(this.laconic);
}
