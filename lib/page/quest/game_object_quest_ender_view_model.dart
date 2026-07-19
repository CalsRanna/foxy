import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_quest_ender_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/game_object_quest_relation_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectQuestEnderViewModel
    with
        ViewModelValidationMixin,
        GameObjectQuestRelationValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectQuestEnderRepository>();

  final editingKey = signal<GameObjectQuestEnderKey?>(null);
  final items = signal<List<BriefGameObjectQuestEnderEntity>>([]);
  final page = signal(1);
  final questId = signal(0);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  int _refreshToken = 0;

  GameObjectQuestEnderEntity collectFromForm() {
    return GameObjectQuestEnderEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }

  Future<bool> create() async {
    try {
      final blank = await _repository.createGameObjectQuestEnder(questId.value);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建游戏对象任务结束关系失败: $error');
      DialogUtil.instance.error('创建游戏对象任务结束关系失败: $error');
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
      await _repository.destroyGameObjectQuestEnder(selected.key);
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
      final existing = await _repository.getGameObjectQuestEnder(key);
      if (existing == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(existing);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载游戏对象任务结束关系失败: $error');
      DialogUtil.instance.error('加载游戏对象任务结束关系失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int questId}) async {
    try {
      await setParentQuestId(questId);
    } catch (error) {
      LoggerUtil.instance.e('初始化游戏对象任务结束关系失败: $error');
      DialogUtil.instance.error('初始化游戏对象任务结束关系失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateGameObjectQuestEnderFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeGameObjectQuestEnder(candidate);
    } else {
      await _repository.updateGameObjectQuestEnder(originalKey, candidate);
    }
    editingKey.value = GameObjectQuestEnderKey.fromEntity(candidate);
    await _refresh();
  }

  void resetForm() {
    _initControllers(GameObjectQuestEnderEntity(quest: questId.value));
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

  void _initControllers(GameObjectQuestEnderEntity model) {
    idController.init(model.id);
    questController.init(model.quest);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentQuest = questId.value;
    final count = await _repository.countGameObjectQuestEnders(parentQuest);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefGameObjectQuestEnders(
      parentQuest,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefGameObjectQuestEnderEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
