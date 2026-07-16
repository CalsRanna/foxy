import 'package:flutter/widgets.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
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
  final gameObjectEntry = signal<int>(0);
  final items = signal<List<BriefGameObjectQuestItemEntity>>([]);
  final selectedIndex = signal<int?>(null);

  late final gameObjectIdController = registerController(IntFieldController());
  late final idxController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  final _repository = GetIt.instance.get<GameObjectQuestItemRepository>();

  GameObjectQuestItemEntity collectFromForm() {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry.value,
      idx: idxController.collect(),
      itemId: itemIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null) return;
    try {
      final item = items.value[index];
      await _repository.copyGameObjectQuestItem(item.gameObjectEntry, item.idx);
      DialogUtil.instance.success('复制成功');
      await load();
    } catch (e) {
      DialogUtil.instance.error('复制失败: $e');
    }
  }

  Future<void> create() async {
    try {
      resetForm();
      final nextIdx = await _repository.getNextIdx(gameObjectEntry.value);
      idxController.init(nextIdx);
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null) return;
    try {
      final item = items.value[index];
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除物品 ${item.itemName}？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyGameObjectQuestItem(
        item.gameObjectEntry,
        item.idx,
      );
      DialogUtil.instance.success('删除成功');
      await load();
    } catch (e) {
      DialogUtil.instance.error('删除失败: $e');
    }
  }

  void dispose() {
    disposeControllers();
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    fillForm(items.value[index]);
  }

  void fillForm(BriefGameObjectQuestItemEntity questItem) {
    idxController.init(questItem.idx);
    itemIdController.init(questItem.itemId);
    verifiedBuildController.init(questItem.verifiedBuild);
  }

  Future<void> initSignals({required int gameObjectId}) async {
    try {
      gameObjectEntry.value = gameObjectId;
      gameObjectIdController.init(gameObjectId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> load() async {
    items.value = await _repository.getBriefGameObjectQuestItems(
      gameObjectEntry.value,
    );
    selectedIndex.value = null;
  }

  void pop() {
    routerFacade.goBack();
  }

  void resetForm() {
    idxController.init(0);
    itemIdController.init(0);
    verifiedBuildController.init(0);
  }

  Future<void> save(BuildContext context) async {
    try {
      final questItem = collectFromForm();
      validateGameObjectQuestItemFields(questItem);
      await _repository.storeGameObjectQuestItem(questItem);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('保存成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> update(BuildContext context) async {
    try {
      final questItem = collectFromForm();
      validateGameObjectQuestItemFields(questItem);
      await _repository.updateGameObjectQuestItem(questItem);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }
}
