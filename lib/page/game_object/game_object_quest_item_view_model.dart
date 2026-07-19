import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_game_object_quest_item_entity.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/entity/game_object_quest_item_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/game_object_quest_item_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectQuestItemViewModel
    with
        ViewModelValidationMixin,
        GameObjectQuestItemValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<GameObjectQuestItemRepository>();

  final editingKey = signal<GameObjectQuestItemKey?>(null);
  final gameObjectEntry = signal<int>(0);
  final items = signal<List<BriefGameObjectQuestItemEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

  late final gameObjectIdController = registerController(IntFieldController());
  late final idxController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  int _refreshToken = 0;

  GameObjectQuestItemEntity collectFromForm() {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectIdController.collect(),
      idx: idxController.collect(),
      itemId: itemIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<void> copy(BuildContext context) async {
    final selected = _selectedItem;
    if (selected == null) return;
    try {
      await _repository.copyGameObjectQuestItem(selected.key);
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
      final blank = await _repository.createGameObjectQuestItem(
        gameObjectEntry.value,
      );
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建游戏对象任务物品记录失败: $error');
      DialogUtil.instance.error('创建游戏对象任务物品记录失败: $error');
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
      await _repository.destroyGameObjectQuestItem(selected.key);
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
      final questItem = await _repository.getGameObjectQuestItem(key);
      if (questItem == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(questItem);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载游戏对象任务物品记录失败: $error');
      DialogUtil.instance.error('加载游戏对象任务物品记录失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int gameObjectId}) async {
    try {
      await setParentGameObjectEntry(gameObjectId);
    } catch (error) {
      LoggerUtil.instance.e('初始化游戏对象任务物品失败: $error');
      DialogUtil.instance.error('初始化游戏对象任务物品失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateGameObjectQuestItemFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeGameObjectQuestItem(candidate);
    } else {
      await _repository.updateGameObjectQuestItem(originalKey, candidate);
    }
    editingKey.value = GameObjectQuestItemKey.fromEntity(candidate);
    await _refresh();
  }

  void pop() => routerFacade.goBack();

  void resetForm() {
    _initControllers(
      GameObjectQuestItemEntity(gameObjectEntry: gameObjectEntry.value),
    );
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

  Future<void> setParentGameObjectEntry(int gameObjectEntry) async {
    if (this.gameObjectEntry.value != gameObjectEntry) page.value = 1;
    this.gameObjectEntry.value = gameObjectEntry;
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) this.resetForm();
  }

  void _initControllers(GameObjectQuestItemEntity questItem) {
    gameObjectIdController.init(questItem.gameObjectEntry);
    idxController.init(questItem.idx);
    itemIdController.init(questItem.itemId);
    verifiedBuildController.init(questItem.verifiedBuild);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentEntry = gameObjectEntry.value;
    final count = await _repository.countGameObjectQuestItems(parentEntry);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefGameObjectQuestItems(
      parentEntry,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }

  BriefGameObjectQuestItemEntity? get _selectedItem {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return null;
    return items.value[index];
  }
}
