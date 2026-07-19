import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_loot_template_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_key.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/loot_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureLootTemplateViewModel
    with
        ViewModelValidationMixin,
        LootTemplateValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final creatureTemplate = signal<CreatureTemplateEntity?>(null);
  final editingKey = signal<LootTemplateKey?>(null);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);
  final creating = signal(false);
  final editing = signal(false);

  // 表单控制器
  late final creatureIdController = registerController(IntFieldController());
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

  final repository = LootTemplateRepository(LootTableType.creature);
  final _creatureRepository = GetIt.instance.get<CreatureTemplateRepository>();

  /// 从表单收集数据
  LootTemplateEntity collectFromForm() {
    final template = creatureTemplate.value;
    if (template == null) return LootTemplateEntity();

    final loot = LootTemplateEntity(
      entry: creatureIdController.collect(),
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
    return loot;
  }

  /// 创建新记录
  void create() {
    if (creatureTemplate.value == null) return;
    resetForm();
    creating.value = true;
    editing.value = false;
    selectedIndex.value = null;
    editingKey.value = null;
  }

  /// 删除记录
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

  /// 清理资源
  void dispose() {
    disposeControllers();
  }

  /// 编辑选中记录
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

  /// 填充表单
  void fillForm(LootTemplateEntity loot) {
    creatureIdController.init(loot.entry);
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

  /// 初始化
  Future<void> initSignals({required int creatureId}) async {
    try {
      this.creatureId.value = creatureId;
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物掉落失败: $e');
      DialogUtil.instance.error('初始化生物掉落失败: $e');
    }
  }

  /// 加载数据

  Future<void> load() async {
    final template = await _creatureRepository.getCreatureTemplate(
      CreatureTemplateKey(entry: creatureId.value),
    );
    if (template == null) return;
    creatureTemplate.value = template;

    final count = await repository.countLootTemplatesForEntry(template.lootId);
    final lastPage = max(1, (count / repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await repository.getBriefLootTemplates(
      template.lootId,
      page: page.value,
    );
    items.value = data;
    total.value = count;
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
    editingKey.value = null;
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await load();
  }

  /// 重置表单
  void resetForm() {
    creatureIdController.init(creatureTemplate.value?.lootId ?? 0);
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

  /// 保存记录
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 更新记录
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
