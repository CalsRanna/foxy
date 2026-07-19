import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_creature_template_spell_entity.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/entity/creature_template_spell_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/creature_template_spell_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateSpellViewModel
    with
        ViewModelValidationMixin,
        CreatureTemplateSpellValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<CreatureTemplateSpellRepository>();

  final creatureId = signal(0);
  final editingKey = signal<CreatureTemplateSpellKey?>(null);
  final items = signal<List<BriefCreatureTemplateSpellEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

  late final creatureIdController = registerController(IntFieldController());
  late final indexController = registerController(IntFieldController());
  late final spellController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  int _refreshToken = 0;

  CreatureTemplateSpellEntity collectFromForm() {
    return CreatureTemplateSpellEntity(
      creatureID: creatureIdController.collect(),
      index: indexController.collect(),
      spell: spellController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<void> copy(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    try {
      await _repository.copyCreatureTemplateSpell(selected.key);
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
      final blank = await _repository.createCreatureTemplateSpell(
        creatureId.value,
      );
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建生物法术记录失败: $error');
      DialogUtil.instance.error('创建生物法术记录失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: const Text('确认删除'),
        description: const Text('确定要删除这条技能记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _repository.destroyCreatureTemplateSpell(selected.key);
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
      final spell = await _repository.getCreatureTemplateSpell(key);
      if (spell == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(spell);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载生物法术记录失败: $error');
      DialogUtil.instance.error('加载生物法术记录失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int creatureId}) async {
    try {
      await setParentCreatureId(creatureId);
    } catch (error) {
      LoggerUtil.instance.e('初始化生物法术失败: $error');
      DialogUtil.instance.error('初始化生物法术失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateCreatureTemplateSpellFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeCreatureTemplateSpell(candidate);
    } else {
      await _repository.updateCreatureTemplateSpell(originalKey, candidate);
    }
    editingKey.value = CreatureTemplateSpellKey.fromEntity(candidate);
    await _refresh();
  }

  void pop() => routerFacade.goBack();

  void resetForm() {
    _initControllers(CreatureTemplateSpellEntity(creatureID: creatureId.value));
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

  Future<void> setParentCreatureId(int creatureId) async {
    if (this.creatureId.value != creatureId) page.value = 1;
    this.creatureId.value = creatureId;
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) this.resetForm();
  }

  void _initControllers(CreatureTemplateSpellEntity spell) {
    creatureIdController.init(spell.creatureID);
    indexController.init(spell.index);
    spellController.init(spell.spell);
    verifiedBuildController.init(spell.verifiedBuild);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentCreatureId = creatureId.value;
    final count = await _repository.countCreatureTemplateSpells(
      parentCreatureId,
    );
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefCreatureTemplateSpells(
      parentCreatureId,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefCreatureTemplateSpellEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
