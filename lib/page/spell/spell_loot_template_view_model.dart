import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_spell_loot_template_entity.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/entity/spell_loot_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_loot_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellLootTemplateViewModel
    with
        ViewModelValidationMixin,
        SpellLootTemplateValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<SpellLootTemplateRepository>();

  final editingKey = signal<SpellLootTemplateKey?>(null);
  final items = signal<List<BriefSpellLootTemplateEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final spellId = signal(0);
  final total = signal(0);

  late final spellIdController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  int _refreshToken = 0;

  SpellLootTemplateEntity collectFromForm() {
    return SpellLootTemplateEntity(
      entry: spellIdController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect(),
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  Future<bool> create() async {
    try {
      final blank = await _repository.createSpellLootTemplate(spellId.value);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建法术掉落模板失败: $error');
      DialogUtil.instance.error('创建法术掉落模板失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '是否删除物品 ${selected.displayName}？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await _repository.destroySpellLootTemplate(selected.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void dispose() => disposeControllers();

  Future<bool> edit() async {
    final selected = _selectedItem;
    if (selected == null) return false;
    final key = selected.key;
    editingKey.value = key;
    try {
      final loot = await _repository.getSpellLootTemplate(key);
      if (loot == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(loot);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载法术掉落模板失败: $error');
      DialogUtil.instance.error('加载法术掉落模板失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      await setParentSpellId(spellId);
    } catch (error) {
      LoggerUtil.instance.e('初始化法术掉落模板失败: $error');
      DialogUtil.instance.error('初始化法术掉落模板失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateSpellLootTemplateFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeSpellLootTemplate(candidate);
    } else {
      await _repository.updateSpellLootTemplate(originalKey, candidate);
    }
    editingKey.value = SpellLootTemplateKey.fromEntity(candidate);
    await _refresh();
  }

  void pop() => routerFacade.goBack();

  void resetForm() {
    _initControllers(SpellLootTemplateEntity(entry: spellId.value));
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
      return false;
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> setParentSpellId(int spellId) async {
    if (this.spellId.value != spellId) page.value = 1;
    this.spellId.value = spellId;
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) this.resetForm();
  }

  void _initControllers(SpellLootTemplateEntity data) {
    spellIdController.init(data.entry);
    itemController.init(data.item);
    referenceController.init(data.reference);
    chanceController.init(data.chance);
    questRequiredController.init(data.questRequired);
    lootModeController.init(data.lootMode);
    groupIdController.init(data.groupId);
    minCountController.init(data.minCount);
    maxCountController.init(data.maxCount);
    commentController.init(data.comment);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentEntry = spellId.value;
    final count = await _repository.countSpellLootTemplates(parentEntry);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefSpellLootTemplates(
      parentEntry,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefSpellLootTemplateEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
