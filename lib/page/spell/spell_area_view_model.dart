import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_spell_area_entity.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/entity/spell_area_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_area_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellAreaViewModel
    with
        ViewModelValidationMixin,
        SpellAreaValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<SpellAreaRepository>();

  final editingKey = signal<SpellAreaKey?>(null);
  final items = signal<List<BriefSpellAreaEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final spellId = signal(0);
  final total = signal(0);

  late final spellIdController = registerController(IntFieldController());
  late final areaController = registerController(IntFieldController());
  late final questStartController = registerController(IntFieldController());
  late final questEndController = registerController(IntFieldController());
  late final auraSpellController = registerController(IntFieldController());
  late final racemaskController = registerController(FlagFieldController());
  late final genderController = registerController(
    SelectFieldController<int>(fallback: 2),
  );
  late final autocastController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final questStartStatusController = registerController(
    FlagFieldController(),
  );
  late final questEndStatusController = registerController(
    FlagFieldController(),
  );

  int _refreshToken = 0;

  SpellAreaEntity collectFromForm() => SpellAreaEntity(
    spell: spellIdController.collect(),
    area: areaController.collect(),
    questStart: questStartController.collect(),
    questEnd: questEndController.collect(),
    auraSpell: auraSpellController.collect(),
    racemask: racemaskController.collect(),
    gender: genderController.collect(),
    autocast: autocastController.collect(),
    questStartStatus: questStartStatusController.collect(),
    questEndStatus: questEndStatusController.collect(),
  );

  Future<bool> create() async {
    try {
      final candidate = await _repository.createSpellArea(spellId.value);
      _clearEditingState();
      _initControllers(candidate);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('法术区域-创建失败: $error');
      DialogUtil.instance.error('法术区域-创建失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '确定要删除这条区域技能记录吗？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await _repository.destroySpellArea(selected.key);
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
      final entity = await _repository.getSpellArea(key);
      if (entity == null) {
        throw StateError('原法术区域记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(entity);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('法术区域-加载失败: $error');
      DialogUtil.instance.error('法术区域-加载失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      await setParentSpellId(spellId);
    } catch (error) {
      LoggerUtil.instance.e('法术区域-初始化失败: $error');
      DialogUtil.instance.error('法术区域-初始化失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateSpellAreaFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeSpellArea(candidate);
    } else {
      await _repository.updateSpellArea(originalKey, candidate);
    }
    editingKey.value = SpellAreaKey.fromEntity(candidate);
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
    if (resetForm) _initControllers(SpellAreaEntity(spell: spellId.value));
  }

  void _initControllers(SpellAreaEntity data) {
    spellIdController.init(data.spell);
    areaController.init(data.area);
    questStartController.init(data.questStart);
    questEndController.init(data.questEnd);
    auraSpellController.init(data.auraSpell);
    racemaskController.init(data.racemask);
    genderController.init(data.gender);
    autocastController.init(data.autocast);
    questStartStatusController.init(data.questStartStatus);
    questEndStatusController.init(data.questEndStatus);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentId = spellId.value;
    final count = await _repository.countSpellAreas(parentId);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefSpellAreas(
      parentId,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefSpellAreaEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
