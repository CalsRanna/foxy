import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_loot_template_entity.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/loot_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectLootTemplateViewModel
    with
        ViewModelValidationMixin,
        LootTemplateValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectId = signal<int>(0);
  final editingKey = signal<LootTemplateKey?>(null);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);
  final editing = signal(false);

  late final gameObjectIdController = registerController(IntFieldController());
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

  final repository = LootTemplateRepository(LootTableType.gameobject);

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: gameObjectIdController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null) return;
    try {
      final item = items.value[index];
      await repository.copyLootTemplate(item.key);
      DialogUtil.instance.success('复制成功');
      await load();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: $e');
    }
  }

  Future<void> create() async {
    try {
      resetForm();
      final nextItemId = await repository.getNextItemId(gameObjectId.value);
      itemController.init(nextItemId);
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
        description: '是否删除掉落物品 ${item.displayName}？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await repository.destroyLootTemplate(item.key);
      DialogUtil.instance.success('删除成功');
      await load();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: $e');
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<bool> edit() async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return false;
    final key = items.value[index].key;
    editingKey.value = key;
    final loot = await repository.getLootTemplate(key);
    if (loot == null) {
      editingKey.value = null;
      DialogUtil.instance.error('原记录不存在，可能已被其他操作修改或删除');
      return false;
    }
    fillForm(loot);
    editing.value = true;
    return true;
  }

  void fillForm(LootTemplateEntity loot) {
    gameObjectIdController.init(loot.entry);
    itemController.init(loot.item);
    referenceController.init(loot.reference);
    chanceController.init(loot.chance);
    questRequiredController.init(loot.questRequired ? 1 : 0);
    lootModeController.init(loot.lootMode);
    groupIdController.init(loot.groupId);
    minCountController.init(loot.minCount);
    maxCountController.init(loot.maxCount);
    commentController.init(loot.comment);
  }

  Future<void> initSignals({required int gameObjectId}) async {
    try {
      this.gameObjectId.value = gameObjectId;
      gameObjectIdController.init(gameObjectId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> load() async {
    final count = await repository.countLootTemplatesForEntry(
      gameObjectId.value,
    );
    final lastPage = max(1, (count / repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    items.value = await repository.getBriefLootTemplates(
      gameObjectId.value,
      page: page.value,
    );
    total.value = count;
    selectedIndex.value = null;
    editing.value = false;
    editingKey.value = null;
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await load();
  }

  void resetForm() {
    gameObjectIdController.init(gameObjectId.value);
    itemController.init(0);
    referenceController.init(0);
    chanceController.init(100.0);
    questRequiredController.init(0);
    lootModeController.init(1);
    groupIdController.init(0);
    minCountController.init(1);
    maxCountController.init(1);
    commentController.init('');
    editingKey.value = null;
    editing.value = false;
  }

  Future<bool> save(BuildContext context) async {
    try {
      final loot = collectFromForm();
      validateLootTemplateFields(loot);
      await repository.storeLootTemplate(loot);
      await load();
      if (!context.mounted) return true;
      var toast = ShadToast(description: Text('保存成功'));
      ShadSonner.of(context).show(toast);
      return true;
    } catch (e) {
      if (!context.mounted) return false;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
      return false;
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<bool> update(BuildContext context) async {
    try {
      final loot = collectFromForm();
      validateLootTemplateFields(loot);
      final originalKey = editingKey.value;
      if (originalKey == null) throw StateError('未选择要更新的掉落记录');
      await repository.updateLootTemplate(originalKey, loot);
      await load();
      if (!context.mounted) return true;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
      return true;
    } catch (e) {
      if (!context.mounted) return false;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
      return false;
    }
  }
}
