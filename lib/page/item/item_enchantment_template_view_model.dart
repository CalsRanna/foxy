import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/item_enchantment_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemEnchantmentTemplateViewModel
    with
        ViewModelValidationMixin,
        ItemEnchantmentTemplateValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<ItemEnchantmentTemplateRepository>();
  final _itemRepository = GetIt.instance.get<ItemTemplateRepository>();

  final editingKey = signal<ItemEnchantmentTemplateKey?>(null);
  final entry = signal(0);
  final items = signal<List<BriefItemEnchantmentTemplateEntity>>([]);
  final kind = signal(ItemEnchantmentKind.randomProperty);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

  late final entryController = registerController(IntFieldController());
  late final enchController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());

  int _refreshToken = 0;

  ItemEnchantmentTemplateEntity collectFromForm() =>
      ItemEnchantmentTemplateEntity(
        entry: entryController.collect(),
        ench: enchController.collect(),
        chance: chanceController.collect(),
      );

  Future<bool> create() async {
    try {
      if (entry.value == 0) {
        throw StateError('请先在物品模板中选择随机属性组或随机后缀组并保存');
      }
      final candidate = await _repository.createItemEnchantmentTemplate(
        entry.value,
      );
      _clearEditingState();
      _initControllers(candidate);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建失败: $error');
      DialogUtil.instance.error('创建失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条附魔记录吗？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await _repository.destroyItemEnchantmentTemplate(selected.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  void dispose() => disposeControllers();

  Future<bool> edit() async {
    final selected = _selectedItem;
    if (selected == null) return false;
    final key = selected.key;
    editingKey.value = key;
    try {
      final entity = await _repository.getItemEnchantmentTemplate(key);
      if (entity == null) {
        throw StateError('原附魔模板记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(entity);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载附魔模板失败: $error');
      DialogUtil.instance.error('加载附魔模板失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int entry}) async {
    try {
      await setParentItemEntry(entry);
    } catch (error) {
      LoggerUtil.instance.e('初始化失败: $error');
      DialogUtil.instance.error('初始化失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateItemEnchantmentTemplateFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeItemEnchantmentTemplate(candidate);
    } else {
      await _repository.updateItemEnchantmentTemplate(originalKey, candidate);
    }
    editingKey.value = ItemEnchantmentTemplateKey.fromEntity(candidate);
    await _refresh();
  }

  void pop() => routerFacade.goBack();

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
      return false;
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) selectedIndex.value = index;
  }

  Future<void> setParentItemEntry(int itemEntry) async {
    page.value = 1;
    final template = await _itemRepository.getItemTemplate(itemEntry);
    if (template != null && template.randomProperty != 0) {
      entry.value = template.randomProperty;
      kind.value = ItemEnchantmentKind.randomProperty;
    } else if (template != null && template.randomSuffix != 0) {
      entry.value = template.randomSuffix;
      kind.value = ItemEnchantmentKind.randomSuffix;
    } else {
      entry.value = 0;
      kind.value = ItemEnchantmentKind.randomProperty;
    }
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) {
      _initControllers(ItemEnchantmentTemplateEntity(entry: entry.value));
    }
  }

  void _initControllers(ItemEnchantmentTemplateEntity model) {
    entryController.init(model.entry);
    enchController.init(model.ench);
    chanceController.init(model.chance);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final groupEntry = entry.value;
    final currentKind = kind.value;
    final count = groupEntry == 0
        ? 0
        : await _repository.countItemEnchantmentTemplatesByEntry(
            groupEntry,
            kind: currentKind,
          );
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = groupEntry == 0
        ? <BriefItemEnchantmentTemplateEntity>[]
        : await _repository.getBriefItemEnchantmentTemplatesByEntry(
            groupEntry,
            kind: currentKind,
            page: page.value,
          );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefItemEnchantmentTemplateEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
