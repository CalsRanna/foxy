import 'package:flutter/widgets.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class MillingLootTemplateViewModel with FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final creating = signal(false);
  final editing = signal(false);
  int? editingItem;

  late final entryController = registerController(IntFieldController());
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

  final repository = LootTemplateRepository(LootTableType.milling);

  Future<void> load() async {
    final data = await repository.getBriefLootTemplates(entry.value);
    items.value = data;
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
    editingItem = null;
  }

  void resetForm() {
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

  void fillForm(BriefLootTemplateEntity loot) {
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

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: entry.value,
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

  Future<void> create() async {
    try {
      final nextItem = await repository.getNextItemId(entry.value);
      resetForm();
      itemController.init(nextItem);
      creating.value = true;
      editing.value = false;
      selectedIndex.value = null;
      editingItem = null;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    fillForm(loot);
    editing.value = true;
    creating.value = false;
    editingItem = loot.item;
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    try {
      await repository.copyLootTemplate(loot.entry, loot.item);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('复制成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
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
        await repository.destroyLootTemplate(loot.entry, loot.item);
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

  Future<void> save(BuildContext context) async {
    try {
      final loot = collectFromForm();
      await repository.storeLootTemplate(loot);
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

  Future<void> update(BuildContext context) async {
    try {
      final loot = collectFromForm();
      await repository.updateLootTemplate(
        loot.entry,
        editingItem ?? loot.item,
        loot,
      );
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

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> initSignals({required int itemId}) async {
    try {
      entry.value = itemId;
      entryController.init(itemId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    disposeControllers();
  }
}
