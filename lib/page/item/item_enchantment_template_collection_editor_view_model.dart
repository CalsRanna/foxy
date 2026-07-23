import 'dart:math';
import 'package:foxy/entity/brief_item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_key.dart';
import 'package:foxy/entity/item_enchantment_template_parent_key.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/item_enchantment_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemEnchantmentTemplateCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        ItemEnchantmentTemplateValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ItemEnchantmentTemplateRepository>();

  final parentKey = signal<ItemEnchantmentTemplateParentKey?>(null);
  final items = signal<List<BriefItemEnchantmentTemplateEntity>>([]);
  final editingKey = signal<ItemEnchantmentTemplateKey?>(null);
  final selectedKey = signal<ItemEnchantmentTemplateKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final enchController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> initSignals({required ItemEnchantmentTemplateParentKey parentKey}) =>
      setParentKey(parentKey);

  Future<void> setParentKey(ItemEnchantmentTemplateParentKey parentKey) async {
    _interactionToken++;
    if (this.parentKey.value != parentKey) page.value = 1;
    this.parentKey.value = parentKey;
    final parent = parentKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(ItemEnchantmentTemplateEntity(entry: parent.entry));
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createItemEnchantmentTemplate(parent.entry);
      if (token != _interactionToken || parentKey.value != parent) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    }
  }

  Future<void> edit(ItemEnchantmentTemplateKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getItemEnchantmentTemplate(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final candidate = _collectCandidate();
    validateItemEnchantmentTemplateFields(candidate);
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
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(ItemEnchantmentTemplateKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyItemEnchantmentTemplate(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  ItemEnchantmentTemplateEntity _collectCandidate() =>
      ItemEnchantmentTemplateEntity(
        entry: entryController.collect(),
        ench: enchController.collect(),
        chance: chanceController.collect(),
      );

  void _applyCandidate(ItemEnchantmentTemplateEntity model) {
    entryController.init(model.entry);
    enchController.init(model.ench);
    chanceController.init(model.chance);
  }

  Future<void> _refresh() async {
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countItemEnchantmentTemplatesByEntry(parent.entry, kind: parent.kind);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefItemEnchantmentTemplatesByEntry(parent.entry, kind: parent.kind, page: nextPage);
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() => disposeControllers();

  void clearParent() {
    ++_refreshToken;
    parentKey.value = null;
    items.value = const [];
    editingKey.value = null;
    selectedKey.value = null;
    page.value = 1;
    total.value = 0;
    loading.value = false;
    errorMessage.value = null;
    _applyCandidate(const ItemEnchantmentTemplateEntity());
  }
}
