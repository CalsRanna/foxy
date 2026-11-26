import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/npc_vendor_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NpcVendorKey and brief entity', () {
    test('Entry, item, and ExtendedCost all participate in value equality', () {
      const vendor = NpcVendorEntity(entry: 10, item: 20, extendedCost: 30);
      final key = NpcVendorKey.fromEntity(vendor);

      expectRowKeyEquality(
        key,
        NpcVendorKey.fromEntity,
        sameKeyRow: vendor.copyWith(slot: 2),
        differentKeyRows: [
          vendor.copyWith(entry: 11),
          vendor.copyWith(item: 21),
          vendor.copyWith(extendedCost: 31),
        ],
      );
    });

    test('The brief entity exposes display columns and the complete key', () {
      const brief = BriefNpcVendorEntity(
        entry: 10,
        slot: 1,
        item: 20,
        maxcount: 3,
        incrtime: 4,
        extendedCost: 30,
      );

      expect(
        brief.key,
        const NpcVendorKey(entry: 10, item: 20, extendedCost: 30),
      );
    });
  });

  group('NpcVendorRepository write contract', () {
    const originalKey = NpcVendorKey(entry: 10, item: 20, extendedCost: 30);
    const candidate = NpcVendorEntity(
      entry: 11,
      slot: 2,
      item: 21,
      maxcount: 5,
      incrtime: 60,
      extendedCost: 31,
      verifiedBuild: 12340,
    );

    testRepositoryWrites(
      createRepository: _TestNpcVendorRepository.new,
      originalKey: originalKey,
      candidate: candidate,
      missingCandidate: const NpcVendorEntity(),
      update: (repository, key, row) => repository.updateNpcVendor(key, row),
      destroy: (repository, key) => repository.destroyNpcVendor(key),
      expectedBindings: [
        ...candidate.toJson().values,
        originalKey.entry,
        originalKey.item,
        originalKey.extendedCost,
      ],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestNpcVendorRepository(laconic).getBriefNpcVendors(10, page: 2),
      tableAlias: 'nv',
      verifyQuery: (query) {
        expect(query.sql, isNot(contains('VerifiedBuild')));
        expect(query.bindings.sublist(2), [50, 50]);
      },
    );
  });

  group('NpcVendor inline editing identity', () {
    late _FakeNpcVendorRepository repository;

    late NpcVendorLinkedListViewModel viewModel;

    setUp(() async {
      repository = _FakeNpcVendorRepository([
        const NpcVendorEntity(entry: 10, slot: 0, item: 20, extendedCost: 30),
      ]);
      GetIt.instance.registerSingleton<NpcVendorRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());

      viewModel = NpcVendorLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('Editing a selected brief row uses the old key and a multi-column key change clears scoped state', () async {
      const originalKey = NpcVendorKey(entry: 10, item: 20, extendedCost: 30);
      expect(viewModel.editingKey.value, originalKey);

      viewModel.entryController.init(11);
      viewModel.itemController.init(21);
      viewModel.extendedCostController.init(31);
      viewModel.maxcountController.init(5);
      viewModel.incrtimeController.init(60);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.entry, 11);
      expect(repository.rows.single.item, 21);
      expect(repository.rows.single.extendedCost, 31);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.selectedKey.value, isNull);
      expect(viewModel.editingKey.value, isNull);
    });

    test('A failed save retains editingKey so a corrected retry can use the old key', () async {
      final originalKey = repository.keyOf(repository.rows.single);
      viewModel.itemController.init(21);

      await expectSaveRetry(
        repository: repository,
        originalKey: originalKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );
    });

    test(
      'Creating and changing the parent clear the child row identity',
      () async {
        expect(viewModel.editingKey.value, isNotNull);

        await expectParentChangeAndCreateClearIdentity(
          editingKey: viewModel.editingKey,
          selectedKey: viewModel.selectedKey,
          changeParent: () async {
            await viewModel.setLinkKey(12);
            expect(viewModel.linkKey.value, 12);
            expect(viewModel.entryController.collect(), 12);
          },
          create: viewModel.create,
        );
        viewModel.itemController.init(50);
        await viewModel.persist();
        expect(repository.storeCount, 1);
      },
    );
  });
}

class _FakeNpcVendorRepository extends NpcVendorRepository
    with InMemoryRowEditing<NpcVendorEntity, NpcVendorKey> {
  @override
  final List<NpcVendorEntity> rows;
  int storeCount = 0;

  _FakeNpcVendorRepository(this.rows);

  @override
  NpcVendorKey keyOf(NpcVendorEntity row) => NpcVendorKey.fromEntity(row);

  @override
  Future<int> countNpcVendors(int entry) async {
    return rows.where((row) => row.entry == entry).length;
  }

  @override
  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    final slots = rows
        .where((row) => row.entry == entry)
        .map((row) => row.slot);
    final nextSlot = slots.isEmpty
        ? 0
        : slots.reduce((a, b) => a > b ? a : b) + 1;
    return NpcVendorEntity(entry: entry, slot: nextSlot);
  }

  @override
  Future<List<BriefNpcVendorEntity>> getBriefNpcVendors(
    int entry, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.entry == entry)
        .map(
          (row) => BriefNpcVendorEntity(
            entry: row.entry,
            slot: row.slot,
            item: row.item,
            maxcount: row.maxcount,
            incrtime: row.incrtime,
            extendedCost: row.extendedCost,
          ),
        )
        .toList();
  }

  @override
  Future<NpcVendorEntity?> getNpcVendor(NpcVendorKey key) async => findRow(key);

  @override
  Future<void> storeNpcVendor(NpcVendorEntity vendor) async {
    storeCount++;
    rows.add(vendor);
  }

  @override
  Future<void> updateNpcVendor(
    NpcVendorKey originalKey,
    NpcVendorEntity vendor,
  ) async => updateRow(originalKey, vendor);
}

class _TestNpcVendorRepository extends NpcVendorRepository {
  @override
  final Laconic laconic;

  _TestNpcVendorRepository(this.laconic);
}
