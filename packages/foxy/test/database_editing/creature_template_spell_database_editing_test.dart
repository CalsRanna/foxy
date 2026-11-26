import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_template_spell_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CreatureTemplateSpellKey and its brief entity include both primary key fields', () {
    const entity = CreatureTemplateSpellEntity(creatureID: 10, index: 2);
    final key = CreatureTemplateSpellKey.fromEntity(entity);
    const brief = BriefCreatureTemplateSpellEntity(creatureID: 10, index: 2);

    expectRowKeyEquality(
      key,
      CreatureTemplateSpellKey.fromEntity,
      sameKeyRow: entity.copyWith(spell: 123),
      differentKeyRows: [entity.copyWith(index: 3)],
    );
    expect(brief.key, key);
  });

  group('CreatureTemplateSpellRepository write contract', () {
    const originalKey = CreatureTemplateSpellKey(creatureID: 10, index: 2);
    const candidate = CreatureTemplateSpellEntity(
      creatureID: 11,
      index: 3,
      spell: 123,
      verifiedBuild: 12340,
    );

    testUpdateQuery(
      execute: (laconic) =>
          _TestCreatureTemplateSpellRepository(laconic)
              .updateCreatureTemplateSpell(originalKey, candidate),
      verify: (query) {
        final sql = query.sql;
        final setColumns = sql
            .substring(sql.indexOf(' set ') + 5, sql.indexOf(' where '))
            .split(', ')
            .map((assignment) => assignment.split(' = ').first)
            .toList();
        final bindings = query.bindings;

        // Assert the column→value mapping rather than bind indices; the SET
        // clause column order follows the Entity field declaration order and
        // is not part of the write contract. Backticks are the escaping
        // requirement of the reserved-word column `Index`.
        expect(
          Map.fromIterables(setColumns, bindings.take(setColumns.length)),
          {
            '`CreatureID`': candidate.creatureID,
            '`Index`': candidate.index,
            '`Spell`': candidate.spell,
            '`VerifiedBuild`': candidate.verifiedBuild,
          },
        );
        expect(bindings.skip(setColumns.length).toList(), [
          originalKey.creatureID,
          originalKey.index,
        ]);
      },
    );

    testMissingWrites(
      createRepository: _TestCreatureTemplateSpellRepository.new,
      update: (repository) => repository.updateCreatureTemplateSpell(
        originalKey,
        const CreatureTemplateSpellEntity(),
      ),
      destroy: (repository) =>
          repository.destroyCreatureTemplateSpell(originalKey),
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestCreatureTemplateSpellRepository(laconic)
              .getBriefCreatureTemplateSpells(10, page: 2),
      tableAlias: 'cts',
      verifyQuery: (query) {
        expect(query.bindings, [10, 50, 50]);
      },
    );
  });

  group('CreatureTemplateSpell inline identity', () {
    late _FakeCreatureTemplateSpellRepository repository;

    late CreatureTemplateSpellLinkedListViewModel viewModel;

    setUp(() async {
      repository = _FakeCreatureTemplateSpellRepository([
        const CreatureTemplateSpellEntity(creatureID: 10, index: 2, spell: 123),
      ]);
      GetIt.instance.registerSingleton<CreatureTemplateSpellRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());

      viewModel = CreatureTemplateSpellLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('Changing both key fields updates by the full old key and clears scoped state', () async {
      const originalKey = CreatureTemplateSpellKey(creatureID: 10, index: 2);

      viewModel.creatureIDController.init(11);
      viewModel.indexController.init(3);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.creatureID, 11);
      expect(repository.rows.single.index, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test(
      'A failed save preserves editingKey so the user can correct and retry',
      () async {
        final originalKey = repository.keyOf(repository.rows.single);
        viewModel.indexController.init(3);

        await expectSaveRetry(
          repository: repository,
          originalKey: originalKey,
          editingKey: viewModel.editingKey,
          persist: viewModel.persist,
        );
      },
    );

    test('Changing the parent scope and creating clear editingKey', () async {
      await expectParentChangeAndCreateClearIdentity(
        editingKey: viewModel.editingKey,
        selectedKey: viewModel.selectedKey,
        changeParent: () async {
          await viewModel.setLinkKey(12);
          expect(viewModel.creatureIDController.collect(), 12);
        },
        create: viewModel.create,
      );
      viewModel.spellController.init(456);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });
}

class _FakeCreatureTemplateSpellRepository
    extends CreatureTemplateSpellRepository
    with
        InMemoryRowEditing<
          CreatureTemplateSpellEntity,
          CreatureTemplateSpellKey
        > {
  @override
  final List<CreatureTemplateSpellEntity> rows;
  int storeCount = 0;

  _FakeCreatureTemplateSpellRepository(this.rows);

  @override
  Future<int> countCreatureTemplateSpells(int creatureID) async {
    return rows.where((row) => row.creatureID == creatureID).length;
  }

  @override
  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    final indexes = rows
        .where((row) => row.creatureID == creatureID)
        .map((row) => row.index);
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: CreatureTemplateSpellRepository.nextAvailableIndex(indexes),
    );
  }

  @override
  Future<List<BriefCreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.creatureID == creatureID)
        .map(
          (row) => BriefCreatureTemplateSpellEntity(
            creatureID: row.creatureID,
            index: row.index,
            spell: row.spell,
            verifiedBuild: row.verifiedBuild,
          ),
        )
        .toList();
  }

  @override
  Future<CreatureTemplateSpellEntity?> getCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async => findRow(key);

  @override
  CreatureTemplateSpellKey keyOf(CreatureTemplateSpellEntity row) =>
      CreatureTemplateSpellKey.fromEntity(row);

  @override
  Future<void> storeCreatureTemplateSpell(
    CreatureTemplateSpellEntity spell,
  ) async {
    storeCount++;
    rows.add(spell);
  }

  @override
  Future<void> updateCreatureTemplateSpell(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity spell,
  ) async => updateRow(originalKey, spell);
}

class _TestCreatureTemplateSpellRepository
    extends CreatureTemplateSpellRepository {
  @override
  final Laconic laconic;

  _TestCreatureTemplateSpellRepository(this.laconic);
}
