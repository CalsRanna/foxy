import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/use_case/activity_log/activity_log_service.dart';
import 'package:foxy/use_case/gossip_menu/destroy_npc_text_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_npc_text_use_case.dart';
import 'package:foxy/view_model/npc_text_linked_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import '../database_editing/recording_driver.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NpcTextLinkedDetailViewModel', () {
    late _MemoryNpcTextRepository repository;
    late NpcTextLinkedDetailViewModel viewModel;

    setUp(() {
      repository = _MemoryNpcTextRepository();
      final transaction = DatabaseTransaction(Laconic(RecordingDriver()));
      final localeRepository = NpcTextLocaleRepository();
      final eventBus = EventBus();
      addTearDown(eventBus.destroy);
      final activityLog = ActivityLogService(ActivityLogRepository(), eventBus);
      GetIt.instance
        ..registerSingleton<NpcTextRepository>(repository)
        ..registerSingleton(
          SaveNpcTextUseCase(
            transaction: transaction,
            npcTextRepository: repository,
            localeRepository: localeRepository,
            activityLogService: activityLog,
          ),
        )
        ..registerSingleton(
          DestroyNpcTextUseCase(
            transaction: transaction,
            npcTextRepository: repository,
            localeRepository: localeRepository,
            activityLogService: activityLog,
          ),
        );
      viewModel = NpcTextLinkedDetailViewModel();
      addTearDown(viewModel.dispose);
    });

    tearDown(() => GetIt.instance.reset());

    test('Editing text and emotes in different slots saves them to the original record', () async {
      const original = NpcTextEntity(
        id: 10,
        text00: 'Greeting',
        text01: 'Alternate greeting',
        probability0: 0.75,
        em05: 12,
        text70: 'Farewell',
        text71: 'Alternate farewell',
        broadcastTextId7: 42,
        probability7: 0.25,
        em75: 45,
        verifiedBuild: 12340,
      );
      repository.rows[10] = original;

      await viewModel.initSignals(linkKey: 10);

      expect(viewModel.text00Controller.collect(), original.text00);
      expect(viewModel.text01Controller.collect(), original.text01);
      expect(viewModel.text70Controller.collect(), original.text70);
      expect(viewModel.text71Controller.collect(), original.text71);
      expect(viewModel.em05Controller.collect(), original.em05);
      expect(viewModel.em75Controller.collect(), original.em75);

      viewModel.text01Controller.init('Updated greeting');
      viewModel.em75Controller.init(46);
      await viewModel.persist();

      final saved = original.copyWith(text01: 'Updated greeting', em75: 46);
      expect(repository.updatedKeys, [10]);
      expect(repository.rows.values.single, saved);
      expect(viewModel.entity.value, saved);
      expect(viewModel.editingKey.value, 10);
    });

    test('A missing linked record is created with the linked ID', () async {
      await viewModel.initSignals(linkKey: 17);

      expect(viewModel.idController.collect(), 17);
      expect(viewModel.editingKey.value, isNull);
      expect(repository.rows, isEmpty);

      viewModel.text00Controller.init('New greeting');
      await viewModel.persist();

      const saved = NpcTextEntity(id: 17, text00: 'New greeting');
      expect(repository.storedKeys, [17]);
      expect(repository.rows.values.single, saved);
      expect(viewModel.editingKey.value, 17);
    });

    test(
      'A stale read cannot overwrite the active form after switching NPC text',
      () async {
        final oldRead = Completer<NpcTextEntity?>();
        repository.pendingReads[10] = oldRead.future;
        const current = NpcTextEntity(id: 20, text00: 'Current greeting');
        repository.rows[20] = current;

        final firstLoad = viewModel.initSignals(linkKey: 10);
        await viewModel.setLinkKey(20);
        oldRead.complete(const NpcTextEntity(id: 10, text00: 'Old greeting'));
        await firstLoad;

        expect(viewModel.entity.value, current);
        expect(viewModel.editingKey.value, 20);
        expect(viewModel.idController.collect(), 20);
        expect(viewModel.text00Controller.collect(), current.text00);
        expect(viewModel.loading.value, isFalse);
      },
    );

    test('Switching NPC text during a save writes the original row and preserves the active form', () async {
      const original = NpcTextEntity(id: 10, text00: 'Old greeting');
      const current = NpcTextEntity(id: 20, text00: 'Current greeting');
      repository.rows.addAll({10: original, 20: current});
      final updateStarted = Completer<void>();
      final releaseUpdate = Completer<void>();
      repository.beforeUpdate = () {
        updateStarted.complete();
        return releaseUpdate.future;
      };

      await viewModel.initSignals(linkKey: 10);
      viewModel.text00Controller.init('Saved greeting');
      final saving = viewModel.persist();
      await updateStarted.future;
      await viewModel.setLinkKey(20);
      releaseUpdate.complete();
      await saving;

      expect(repository.updatedKeys, [10]);
      expect(repository.rows[10]?.text00, 'Saved greeting');
      expect(repository.rows[20], current);
      expect(viewModel.entity.value, current);
      expect(viewModel.editingKey.value, 20);
      expect(viewModel.text00Controller.collect(), current.text00);
      expect(viewModel.submitting.value, isFalse);
    });
  });
}

class _MemoryNpcTextRepository extends NpcTextRepository {
  final rows = <int, NpcTextEntity>{};
  final pendingReads = <int, Future<NpcTextEntity?>>{};
  final storedKeys = <int>[];
  final updatedKeys = <int>[];
  Future<void> Function()? beforeUpdate;

  @override
  Future<NpcTextEntity?> getNpcText(int key) async {
    final pendingRead = pendingReads.remove(key);
    if (pendingRead != null) return pendingRead;
    return rows[key];
  }

  @override
  Future<int> storeNpcText(NpcTextEntity npcText) async {
    storedKeys.add(npcText.id);
    rows[npcText.id] = npcText;
    return npcText.id;
  }

  @override
  Future<void> updateNpcText(int originalKey, NpcTextEntity npcText) async {
    updatedKeys.add(originalKey);
    await beforeUpdate?.call();
    rows[originalKey] = npcText;
  }
}
