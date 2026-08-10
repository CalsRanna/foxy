import 'dart:math';

import 'package:foxy/entity/brief_item_enchantment_template_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_link_key.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_enchantment_template_linked_list_view_model.g.dart';

@FoxyDetailViewModel(skeleton: false)
class ItemEnchantmentTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _ItemEnchantmentTemplateLinkedListViewModelMixin {
  final _repository = GetIt.instance.get<ItemEnchantmentTemplateRepository>();

  final linkKey = signal<ItemEnchantmentTemplateLinkKey?>(null);
  final items = signal<List<BriefItemEnchantmentTemplateEntity>>([]);
  final editingKey = signal<ItemEnchantmentTemplateKey?>(null);
  final selectedKey = signal<ItemEnchantmentTemplateKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  int _refreshToken = 0;
  int _interactionToken = 0;

  void clearLink() {
    ++_refreshToken;
    linkKey.value = null;
    items.value = const [];
    editingKey.value = null;
    selectedKey.value = null;
    page.value = 1;
    total.value = 0;
    loading.value = false;
    errorMessage.value = null;
    _applyCandidate(const ItemEnchantmentTemplateEntity());
  }

  Future<void> create() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createItemEnchantmentTemplate(
        link.entry,
      );
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    }
  }

  Future<void> destroy(ItemEnchantmentTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyItemEnchantmentTemplate(key);
      if (token != _interactionToken || linkKey.value != link) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(ItemEnchantmentTemplateKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getItemEnchantmentTemplate(key);
      if (token != _interactionToken || linkKey.value != link) return;
      if (candidate == null) {
        throw RecordNotFoundException('record not found');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> initSignals({required ItemEnchantmentTemplateLinkKey linkKey}) =>
      setLinkKey(linkKey);

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeItemEnchantmentTemplate(candidate);
      } else {
        await _repository.updateItemEnchantmentTemplate(originalKey, candidate);
      }
      if (token != _interactionToken || linkKey.value != link) return;
      _logActivity(
        originalKey == null
            ? ActivityActionType.create
            : ActivityActionType.update,
        candidate,
      );
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(ItemEnchantmentTemplateLinkKey linkKey) async {
    _interactionToken++;
    if (this.linkKey.value != linkKey) page.value = 1;
    this.linkKey.value = linkKey;
    final link = linkKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(ItemEnchantmentTemplateEntity(entry: link.entry));
    await _refresh();
  }

  Future<void> _refresh() async {
    final link = linkKey.value;
    if (link == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countItemEnchantmentTemplatesByEntry(
        link.entry,
        kind: link.kind,
      );
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefItemEnchantmentTemplatesByEntry(
        link.entry,
        kind: link.kind,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
