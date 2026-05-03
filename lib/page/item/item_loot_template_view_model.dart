import 'package:flutter/widgets.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ItemLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final creating = signal(false);
  final editing = signal(false);
  int? editingItem;

  final itemController = TextEditingController();
  final reference = signal<int>(0);
  final chance = signal<double>(0.0);
  final questRequiredController = ShadSelectController<int>();
  final lootMode = signal<int>(0);
  final groupId = signal<int>(0);
  final minCount = signal<int>(0);
  final maxCount = signal<int>(0);
  final commentController = TextEditingController();

  final repository = LootTemplateRepository(LootTableType.item);

  Future<void> load() async {
    final data = await repository.getLootTemplates(entry.value);
    items.value = data;
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
    editingItem = null;
  }

  void resetForm() {
    itemController.clear();
    reference.value = 0;
    chance.value = 0;
    questRequiredController.value = {0};
    lootMode.value = 1;
    groupId.value = 0;
    minCount.value = 1;
    maxCount.value = 1;
    commentController.clear();
  }

  void fillForm(BriefLootTemplateEntity loot) {
    itemController.text = loot.item.toString();
    reference.value = loot.reference;
    chance.value = loot.chance;
    questRequiredController.value = {loot.questRequired ? 1 : 0};
    lootMode.value = loot.lootMode;
    groupId.value = loot.groupId;
    minCount.value = loot.minCount;
    maxCount.value = loot.maxCount;
    commentController.text = loot.comment;
  }

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: entry.value,
      item: _parseInt(itemController.text),
      reference: reference.value,
      chance: chance.value,
      questRequired: questRequiredController.value.first == 1,
      lootMode: lootMode.value,
      groupId: groupId.value,
      minCount: minCount.value,
      maxCount: maxCount.value,
      comment: commentController.text,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  Future<void> create() async {
    try {
      final nextItem = await repository.getNextItemId(entry.value);
      resetForm();
      itemController.text = nextItem.toString();
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

    final confirmed = await showShadDialog<bool>(
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
      await repository.updateLootTemplate(loot, oldItem: editingItem);
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
    itemController.dispose();
    questRequiredController.dispose();
    commentController.dispose();
  }
}
