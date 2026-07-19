import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_loot_template_entity.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/loot_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class DisenchantLootTemplateViewModel
    with
        ViewModelValidationMixin,
        LootTemplateValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final editingKey = signal<LootTemplateKey?>(null);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);
  final creating = signal(false);
  final editing = signal(false);

  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(FlagFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  final repository = LootTemplateRepository(LootTableType.disenchant);
  final itemRepository = GetIt.instance.get<ItemTemplateRepository>();

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: entryController.collect(),
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

  bool create() {
    try {
      if (entry.value == 0) throw StateError('父模板 ID 不能为 0');
      resetForm();
      creating.value = true;
      editing.value = false;
      selectedIndex.value = null;
      editingKey.value = null;
      return true;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];

    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条掉落记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await repository.destroyLootTemplate(loot.key);
        await load();
        if (!context.mounted) return;
        var toast = ShadToast(description: Text('删除成功'));
        ShadSonner.of(context).show(toast);
      } catch (e) {
        if (!context.mounted) return;
        var toast = ShadToast(description: Text(e.toString()));
        ShadSonner.of(context).show(toast);
      }
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
    creating.value = false;
    return true;
  }

  void fillForm(LootTemplateEntity loot) {
    entryController.init(loot.entry);
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

  Future<void> initSignals({required int itemId}) async {
    try {
      final template = await itemRepository.getItemTemplate(itemId);
      entry.value = template?.disenchantId ?? 0;
      entryController.init(entry.value);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> load() async {
    final count = await repository.countLootTemplatesForEntry(entry.value);
    final lastPage = max(1, (count / repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await repository.getBriefLootTemplates(
      entry.value,
      page: page.value,
    );
    items.value = data;
    total.value = count;
    selectedIndex.value = null;
    creating.value = false;
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
    entryController.init(entry.value);
    itemController.init(0);
    referenceController.init(0);
    chanceController.init(0.0);
    questRequiredController.init(0);
    lootModeController.init(1);
    groupIdController.init(0);
    minCountController.init(1);
    maxCountController.init(1);
    commentController.init('');
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
