import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/spell_loot_template_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'SpellLootTemplateKey and its brief entity include both primary key fields',
    () {
      const entity = SpellLootTemplateEntity(entry: 10, item: 20);
      final key = SpellLootTemplateKey.fromEntity(entity);
      const brief = BriefSpellLootTemplateEntity(entry: 10, item: 20);

      expectRowKeyEquality(
        key,
        SpellLootTemplateKey.fromEntity,
        sameKeyRow: entity.copyWith(reference: 30, groupId: 40),
        differentKeyRows: [
          entity.copyWith(entry: 11),
          entity.copyWith(item: 21),
        ],
      );
      expect(brief.key, key);
    },
  );

  group('SpellLootTemplateRepository write contract', () {
    const oldKey = SpellLootTemplateKey(entry: 10, item: 20);
    const candidate = SpellLootTemplateEntity(
      entry: 11,
      item: 21,
      reference: 22,
      chance: 23,
      questRequired: 1,
      lootMode: 2,
      groupId: 24,
      minCount: 25,
      maxCount: 26,
      comment: 'candidate',
    );

    testRepositoryWrites(
      createRepository: _TestRepository.new,
      originalKey: oldKey,
      candidate: candidate,
      missingCandidate: const SpellLootTemplateEntity(),
      update: (repository, key, row) =>
          repository.updateSpellLootTemplate(key, row),
      destroy: (repository, key) => repository.destroySpellLootTemplate(key),
      expectedBindings: [
        ...candidate.toJson().values,
        oldKey.entry,
        oldKey.item,
      ],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestRepository(laconic).getBriefSpellLootTemplates(10, page: 2),
      tableAlias: 'slt',
    );
  });

  group('inline editing identity', () {
    late _FakeRepository repository;

    late SpellLootTemplateLinkedListViewModel viewModel;

    setUp(() async {
      repository = _FakeRepository([
        const SpellLootTemplateEntity(entry: 10, item: 20),
      ]);
      GetIt.instance.registerSingleton<SpellLootTemplateRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());

      viewModel = SpellLootTemplateLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async => GetIt.instance.reset());

    test('Changing both key fields updates by the old key and a failed save preserves it for retry', () async {
      const oldKey = SpellLootTemplateKey(entry: 10, item: 20);
      expect(viewModel.editingKey.value, oldKey);
      viewModel.entryController.init(11);
      viewModel.itemController.init(21);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );
      expect(repository.rows.single.entry, 11);
      expect(repository.rows.single.item, 21);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test(
      'Changing the parent scope and creating clear the previous row identity',
      () async {
        await expectParentChangeAndCreateClearIdentity(
          editingKey: viewModel.editingKey,
          selectedKey: viewModel.selectedKey,
          changeParent: () => viewModel.setLinkKey(12),
          create: viewModel.create,
        );
        expect(viewModel.entryController.collect(), 12);
      },
    );
  });
}

class _FakeRepository extends SpellLootTemplateRepository
    with InMemoryRowEditing<SpellLootTemplateEntity, SpellLootTemplateKey> {
  @override
  final List<SpellLootTemplateEntity> rows;

  _FakeRepository(this.rows);

  @override
  SpellLootTemplateKey keyOf(SpellLootTemplateEntity row) =>
      SpellLootTemplateKey.fromEntity(row);

  @override
  Future<int> countSpellLootTemplates(int entry) async {
    return rows.where((row) => row.entry == entry).length;
  }

  @override
  Future<SpellLootTemplateEntity> createSpellLootTemplate(int entry) async {
    return SpellLootTemplateEntity(entry: entry);
  }

  @override
  Future<List<BriefSpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.entry == entry)
        .map(
          (row) => BriefSpellLootTemplateEntity(
            entry: row.entry,
            item: row.item,
            reference: row.reference,
            chance: row.chance,
            questRequired: row.questRequired,
            lootMode: row.lootMode,
            groupId: row.groupId,
            minCount: row.minCount,
            maxCount: row.maxCount,
            comment: row.comment,
          ),
        )
        .toList();
  }

  @override
  Future<SpellLootTemplateEntity?> getSpellLootTemplate(
    SpellLootTemplateKey key,
  ) async => findRow(key);

  @override
  Future<void> updateSpellLootTemplate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity data,
  ) async => updateRow(originalKey, data);
}

class _TestRepository extends SpellLootTemplateRepository {
  @override
  final Laconic laconic;

  _TestRepository(this.laconic);
}
