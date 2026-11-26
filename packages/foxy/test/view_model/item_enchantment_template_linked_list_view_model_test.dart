import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_link_key.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/view_model/item_enchantment_template_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ItemEnchantmentTemplateLinkedListViewModel', () {
    const property = ItemEnchantmentTemplateLinkKey(
      entry: 10,
      kind: ItemEnchantmentKind.randomProperty,
    );
    const suffix = ItemEnchantmentTemplateLinkKey(
      entry: 10,
      kind: ItemEnchantmentKind.randomSuffix,
    );
    const lastProperty = BriefItemEnchantmentTemplateEntity(
      entry: 10,
      ench: 51,
    );
    const firstProperty = BriefItemEnchantmentTemplateEntity(
      entry: 10,
      ench: 1,
    );
    const firstSuffix = BriefItemEnchantmentTemplateEntity(
      entry: 10,
      ench: 60,
      kind: ItemEnchantmentKind.randomSuffix,
    );
    late _EnchantmentRepository repository;
    late ItemEnchantmentTemplateLinkedListViewModel viewModel;

    setUp(() {
      repository = _EnchantmentRepository();
      repository.counts.addAll({property: 51, suffix: 1});
      repository.pages.addAll({
        (link: property, page: 1): [firstProperty],
        (link: property, page: 2): [lastProperty],
        (link: suffix, page: 1): [firstSuffix],
      });
      GetIt.instance.registerSingleton<ItemEnchantmentTemplateRepository>(
        repository,
      );
      viewModel = ItemEnchantmentTemplateLinkedListViewModel();
      addTearDown(viewModel.dispose);
    });

    tearDown(() => GetIt.instance.reset());

    test('Switching enchantment kind for the same group resets the page and edit state', () async {
      await viewModel.initSignals(linkKey: property);
      await viewModel.paginate(2);
      final key = viewModel.items.value.single.key;
      await viewModel.edit(key);

      expect(viewModel.page.value, 2);
      expect(viewModel.editingKey.value, lastProperty.key);
      expect(viewModel.selectedKey.value, lastProperty.key);

      await viewModel.setLinkKey(suffix);

      expect(repository.pageRequests, [
        (link: property, page: 1),
        (link: property, page: 2),
        (link: suffix, page: 1),
      ]);
      expect(viewModel.linkKey.value, suffix);
      expect(viewModel.page.value, 1);
      expect(viewModel.total.value, 1);
      expect(viewModel.items.value, [firstSuffix]);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedKey.value, isNull);
    });

    test('Deleting the final row on the last page returns to the previous valid page', () async {
      await viewModel.initSignals(linkKey: property);
      await viewModel.paginate(2);
      repository.onDestroy = (key) {
        expect(key, lastProperty.key);
        repository.counts[property] = 50;
        repository.pages.remove((link: property, page: 2));
      };

      await viewModel.destroy(viewModel.items.value.single.key);

      expect(repository.pageRequests.last, (link: property, page: 1));
      expect(viewModel.page.value, 1);
      expect(viewModel.total.value, 50);
      expect(viewModel.items.value, [firstProperty]);
      expect(viewModel.submitting.value, isFalse);
    });

    test('A late list response cannot restore data after clearing the parent scope', () async {
      await viewModel.initSignals(linkKey: property);
      final pageStarted = Completer<void>();
      final oldPage = Completer<List<BriefItemEnchantmentTemplateEntity>>();
      repository.fetchPage = (_) {
        pageStarted.complete();
        return oldPage.future;
      };

      final refreshing = viewModel.paginate(2);
      await pageStarted.future;
      expect(viewModel.loading.value, isTrue);
      viewModel.clearLink();
      oldPage.complete([lastProperty]);
      await refreshing;

      expect(viewModel.linkKey.value, isNull);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.page.value, 1);
      expect(viewModel.total.value, 0);
      expect(viewModel.loading.value, isFalse);
    });
  });
}

typedef _PageRequest = ({ItemEnchantmentTemplateLinkKey link, int page});

class _EnchantmentRepository extends ItemEnchantmentTemplateRepository {
  final counts = <ItemEnchantmentTemplateLinkKey, int>{};
  final pages = <_PageRequest, List<BriefItemEnchantmentTemplateEntity>>{};
  final pageRequests = <_PageRequest>[];
  Future<List<BriefItemEnchantmentTemplateEntity>> Function(_PageRequest)?
  fetchPage;
  void Function(ItemEnchantmentTemplateKey)? onDestroy;

  @override
  Future<int> countItemEnchantmentTemplatesByEntry(
    int entry, {
    required ItemEnchantmentKind kind,
  }) async => counts[ItemEnchantmentTemplateLinkKey(entry: entry, kind: kind)]!;

  @override
  Future<void> destroyItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey key,
  ) async => onDestroy!(key);

  @override
  Future<List<BriefItemEnchantmentTemplateEntity>>
  getBriefItemEnchantmentTemplatesByEntry(
    int entry, {
    required ItemEnchantmentKind kind,
    int page = 1,
  }) async {
    final request = (
      link: ItemEnchantmentTemplateLinkKey(entry: entry, kind: kind),
      page: page,
    );
    pageRequests.add(request);
    final fetch = fetchPage;
    if (fetch != null) return fetch(request);
    return pages[request]!;
  }

  @override
  Future<ItemEnchantmentTemplateEntity?> getItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey key,
  ) async => ItemEnchantmentTemplateEntity(entry: key.entry, ench: key.ench);
}
