import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_ender_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_quest_ender_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/creature_quest_relation_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureQuestEnderViewModel
    with
        ViewModelValidationMixin,
        CreatureQuestRelationValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureQuestEnderRepository>();

  final editingKey = signal<CreatureQuestEnderKey?>(null);
  final items = signal<List<BriefCreatureQuestEnderEntity>>([]);
  final page = signal(1);
  final questId = signal(0);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());
  int _refreshToken = 0;

  CreatureQuestEnderEntity collectFromForm() => CreatureQuestEnderEntity(
    id: idController.collect(),
    quest: questController.collect(),
  );

  Future<bool> create() async {
    try {
      final blank = await _repository.createCreatureQuestEnder(questId.value);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建生物任务结束关系失败: $error');
      DialogUtil.instance.error('创建生物任务结束关系失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    final confirmed = await DialogUtil.instance.confirm(
      title: '确认删除',
      description: '将永久删除该记录，确认继续？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await _repository.destroyCreatureQuestEnder(selected.key);
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
      final existing = await _repository.getCreatureQuestEnder(key);
      if (existing == null) throw StateError('原记录不存在，可能已被修改或删除');
      _initControllers(existing);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载生物任务结束关系失败: $error');
      DialogUtil.instance.error('加载生物任务结束关系失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int questId}) async {
    try {
      await setParentQuestId(questId);
    } catch (error) {
      LoggerUtil.instance.e('初始化生物任务结束关系失败: $error');
      DialogUtil.instance.error('初始化生物任务结束关系失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateCreatureQuestEnderFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeCreatureQuestEnder(candidate);
    } else {
      await _repository.updateCreatureQuestEnder(originalKey, candidate);
    }
    editingKey.value = CreatureQuestEnderKey.fromEntity(candidate);
    await _refresh();
  }

  void resetForm() =>
      _initControllers(CreatureQuestEnderEntity(quest: questId.value));

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

  Future<void> setParentQuestId(int questId) async {
    if (this.questId.value != questId) page.value = 1;
    this.questId.value = questId;
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) this.resetForm();
  }

  void _initControllers(CreatureQuestEnderEntity model) {
    idController.init(model.id);
    questController.init(model.quest);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentQuest = questId.value;
    final count = await _repository.countCreatureQuestEnders(parentQuest);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefCreatureQuestEnders(
      parentQuest,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefCreatureQuestEnderEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
