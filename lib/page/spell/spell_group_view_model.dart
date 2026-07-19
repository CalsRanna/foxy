import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_spell_group_entity.dart';
import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/entity/spell_group_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_group_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_group_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellGroupViewModel
    with
        ViewModelValidationMixin,
        SpellGroupValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<SpellGroupRepository>();

  final editingKey = signal<SpellGroupKey?>(null);
  final items = signal<List<BriefSpellGroupEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final spellId = signal(0);
  final total = signal(0);

  late final spellIdController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());

  int _refreshToken = 0;

  SpellGroupEntity collectFromForm() {
    return SpellGroupEntity(
      id: groupIdController.collect(),
      spellId: spellIdController.collect(),
    );
  }

  Future<void> copy(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    try {
      await _repository.copySpellGroup(selected.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('复制成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  Future<bool> create() async {
    try {
      final blank = await _repository.createSpellGroup(spellId.value);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('法术组-创建失败: $error');
      DialogUtil.instance.error('法术组-创建失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条技能组记录吗？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await _repository.destroySpellGroup(selected.key);
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
      final data = await _repository.getSpellGroup(key);
      if (data == null) {
        throw StateError('原法术组记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(data);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('法术组-加载失败: $error');
      DialogUtil.instance.error('法术组-加载失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      await setParentSpellId(spellId);
    } catch (error) {
      LoggerUtil.instance.e('法术组-初始化失败: $error');
      DialogUtil.instance.error('法术组-初始化失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateSpellGroupFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeSpellGroup(candidate);
    } else {
      await _repository.updateSpellGroup(originalKey, candidate);
    }
    editingKey.value = SpellGroupKey.fromEntity(candidate);
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
      _initControllers(SpellGroupEntity(spellId: spellId.value));
    }
  }

  void _initControllers(SpellGroupEntity data) {
    groupIdController.init(data.id);
    spellIdController.init(data.spellId);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentId = spellId.value;
    final count = await _repository.countSpellGroups(parentId);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefSpellGroups(
      parentId,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefSpellGroupEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
