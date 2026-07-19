import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_spell_linked_spell_entity.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/entity/spell_linked_spell_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_linked_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_linked_spell_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellLinkedSpellViewModel
    with
        ViewModelValidationMixin,
        SpellLinkedSpellValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<SpellLinkedSpellRepository>();

  final editingKey = signal<SpellLinkedSpellKey?>(null);
  final items = signal<List<BriefSpellLinkedSpellEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final spellId = signal(0);
  final total = signal(0);

  late final spellTriggerController = registerController(IntFieldController());
  late final spellEffectController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final commentController = registerController(StringFieldController());

  int _refreshToken = 0;

  SpellLinkedSpellEntity collectFromForm() {
    final trigger = spellTriggerController.collect();
    if (trigger.abs() != spellId.value) {
      throw ArgumentError('触发法术绝对值必须等于当前法术ID');
    }
    return SpellLinkedSpellEntity(
      spellTrigger: trigger,
      spellEffect: spellEffectController.collect(),
      type: typeController.collect(),
      comment: commentController.collect(),
    );
  }

  Future<void> copy(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    try {
      await _repository.copySpellLinkedSpell(selected.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('复制成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  Future<bool> create() async {
    try {
      final blank = await _repository.createSpellLinkedSpell(spellId.value);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('法术链接-创建失败: $error');
      DialogUtil.instance.error('法术链接-创建失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条链接技能记录吗？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await _repository.destroySpellLinkedSpell(selected.key);
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
      final data = await _repository.getSpellLinkedSpell(key);
      if (data == null) {
        throw StateError('原链接法术不存在，可能已被其他操作修改或删除');
      }
      _initControllers(data);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('法术链接-加载失败: $error');
      DialogUtil.instance.error('法术链接-加载失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      await setParentSpellId(spellId);
    } catch (error) {
      LoggerUtil.instance.e('法术链接-初始化失败: $error');
      DialogUtil.instance.error('法术链接-初始化失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateSpellLinkedSpellFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeSpellLinkedSpell(candidate);
    } else {
      await _repository.updateSpellLinkedSpell(originalKey, candidate);
    }
    editingKey.value = SpellLinkedSpellKey.fromEntity(candidate);
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
    if (resetForm) {
      _initControllers(SpellLinkedSpellEntity(spellTrigger: spellId.value));
    }
  }

  void _initControllers(SpellLinkedSpellEntity data) {
    spellTriggerController.init(data.spellTrigger);
    spellEffectController.init(data.spellEffect);
    typeController.init(data.type);
    commentController.init(data.comment);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentId = spellId.value;
    final count = await _repository.countSpellLinkedSpells(parentId);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefSpellLinkedSpells(
      parentId,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefSpellLinkedSpellEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
