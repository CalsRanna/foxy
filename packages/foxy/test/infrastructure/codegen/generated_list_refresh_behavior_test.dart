import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/view_model/creature_quest_item_linked_list_view_model.dart';
import 'package:foxy/view_model/emote_text_list_view_model.dart';
import 'package:get_it/get_it.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  tearDown(() => GetIt.instance.reset());

  group('生成的 ListViewModel 刷新', () {
    late _ListRepository repository;
    late EmoteTextListViewModel vm;
    const latestItems = [BriefEmoteTextEntity(id: 2, name: 'new')];

    setUp(() {
      repository = _ListRepository();
      GetIt.instance.registerSingleton<EmoteTextRepository>(repository);
      vm = EmoteTextListViewModel();
      addTearDown(vm.dispose);
    });

    Future<void> search(String name) {
      vm.nameController.init(name);
      return vm.search();
    }

    for (final fails in [false, true]) {
      test('新查询完成后忽略旧查询的${fails ? '错误' : '结果'}', () async {
        final oldRequest = search('old');
        final newRequest = search('new');
        repository.latest.complete(2, latestItems);
        await newRequest;

        repository.old.count.complete(1);
        if (fails) {
          repository.old.items.completeError(StateError('old query failed'));
        } else {
          repository.old.items.complete([const BriefEmoteTextEntity(id: 1)]);
        }
        await oldRequest;

        expect(vm.items.value, latestItems);
        expect(vm.total.value, 2);
        expect(vm.errorMessage.value, isNull);
        expect(vm.loading.value, isFalse);
      });
    }

    test('旧查询先完成不能结束新查询的 loading', () async {
      final oldRequest = search('old');
      final newRequest = search('new');
      repository.old.complete(1, [const BriefEmoteTextEntity(id: 1)]);
      await oldRequest;

      expect(vm.items.value, isEmpty);
      expect(vm.total.value, 0);
      expect(vm.loading.value, isTrue);

      repository.latest.complete(2, latestItems);
      await newRequest;
      expect(vm.items.value, latestItems);
      expect(vm.total.value, 2);
      expect(vm.loading.value, isFalse);
    });
  });

  group('生成的 LinkedListViewModel 刷新', () {
    late _LinkedListRepository repository;
    late CreatureQuestItemLinkedListViewModel vm;
    const oldItems = [BriefCreatureQuestItemEntity(creatureEntry: 10, idx: 1)];
    const latestItems = [
      BriefCreatureQuestItemEntity(creatureEntry: 20, idx: 2),
    ];

    setUp(() {
      repository = _LinkedListRepository();
      GetIt.instance.registerSingleton<CreatureQuestItemRepository>(repository);
      vm = CreatureQuestItemLinkedListViewModel();
      addTearDown(vm.dispose);
    });

    for (final stage in ['count', 'items']) {
      for (final fails in [false, true]) {
        test('切换父键后忽略旧 $stage 的${fails ? '错误' : '结果'}', () async {
          final oldRequest = vm.setLinkKey(10);
          if (stage == 'items') {
            repository.old.count.complete(1);
            await repository.old.listStarted.future;
          }
          final newRequest = vm.setLinkKey(20);
          repository.latest.complete(2, latestItems);
          await newRequest;

          if (stage == 'count') {
            if (fails) {
              repository.old.count.completeError(
                StateError('old count failed'),
              );
            } else {
              repository.old.complete(1, oldItems);
            }
          } else if (fails) {
            repository.old.items.completeError(StateError('old list failed'));
          } else {
            repository.old.items.complete(oldItems);
          }
          await oldRequest;

          expect(vm.linkKey.value, 20);
          expect(vm.page.value, 1);
          expect(vm.items.value, latestItems);
          expect(vm.total.value, 2);
          expect(vm.errorMessage.value, isNull);
          expect(vm.loading.value, isFalse);
          if (stage == 'count') {
            expect(repository.old.listStarted.isCompleted, isFalse);
          }
        });
      }
    }

    test('旧父键的列表先返回不能结束新父键的 loading', () async {
      final oldRequest = vm.setLinkKey(10);
      repository.old.count.complete(1);
      await repository.old.listStarted.future;
      final newRequest = vm.setLinkKey(20);
      repository.old.items.complete(oldItems);
      await oldRequest;

      expect(vm.items.value, isEmpty);
      expect(vm.total.value, 0);
      expect(vm.loading.value, isTrue);

      repository.latest.complete(2, latestItems);
      await newRequest;
      expect(vm.items.value, latestItems);
      expect(vm.total.value, 2);
      expect(vm.loading.value, isFalse);
    });
  });
}

class _PendingQuery<T> {
  final count = Completer<int>();
  final items = Completer<List<T>>();
  final listStarted = Completer<void>();

  void complete(int total, List<T> data) {
    count.complete(total);
    items.complete(data);
  }

  Future<List<T>> fetchItems() {
    listStarted.complete();
    return items.future;
  }
}

class _ListRepository extends EmoteTextRepository {
  final old = _PendingQuery<BriefEmoteTextEntity>();
  final latest = _PendingQuery<BriefEmoteTextEntity>();

  @override
  Future<int> countEmoteTexts({EmoteTextFilter? filter}) =>
      (filter!.name == 'old' ? old : latest).count.future;

  @override
  Future<List<BriefEmoteTextEntity>> getBriefEmoteTexts({
    int page = 1,
    EmoteTextFilter? filter,
  }) => (filter!.name == 'old' ? old : latest).fetchItems();
}

class _LinkedListRepository extends CreatureQuestItemRepository {
  final old = _PendingQuery<BriefCreatureQuestItemEntity>();
  final latest = _PendingQuery<BriefCreatureQuestItemEntity>();

  @override
  Future<int> countCreatureQuestItems(int creatureEntry) =>
      (creatureEntry == 10 ? old : latest).count.future;

  @override
  Future<List<BriefCreatureQuestItemEntity>> getBriefCreatureQuestItems(
    int creatureEntry, {
    int page = 1,
  }) => (creatureEntry == 10 ? old : latest).fetchItems();
}
