import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/loot_template.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final creatureTemplate = signal<CreatureTemplate?>(null);
  final items = signal<List<LootTemplate>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(false);
  final editing = signal(false);
  int? editingItem; // 正在编辑的原始Item值

  // 表单控制器
  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = ShadSelectController<int>();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  final repository = LootTemplateRepository(LootTableType.creature);
  final creatureRepository = CreatureTemplateRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final template = await creatureRepository.getCreatureTemplate(
        creatureId.value,
      );
      creatureTemplate.value = template;

      final data = await repository.getByEntry(template.lootId);
      items.value = data;
      selectedIndex.value = null;
      creating.value = false;
      editing.value = false;
      editingItem = null;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 重置表单
  void resetForm() {
    itemController.clear();
    referenceController.text = '0';
    chanceController.text = '0';
    questRequiredController.value = {0};
    lootModeController.text = '1';
    groupIdController.text = '0';
    minCountController.text = '1';
    maxCountController.text = '1';
    commentController.clear();
  }

  /// 填充表单
  void fillForm(LootTemplate loot) {
    itemController.text = loot.item.toString();
    referenceController.text = loot.reference.toString();
    chanceController.text = loot.chance.toString();
    questRequiredController.value = {loot.questRequired ? 1 : 0};
    lootModeController.text = loot.lootMode.toString();
    groupIdController.text = loot.groupId.toString();
    minCountController.text = loot.minCount.toString();
    maxCountController.text = loot.maxCount.toString();
    commentController.text = loot.comment;
  }

  /// 从表单收集数据
  LootTemplate collectFromForm() {
    final template = creatureTemplate.value;
    if (template == null) return LootTemplate();

    final loot = LootTemplate();
    loot.entry = template.lootId;
    loot.item = _parseInt(itemController.text);
    loot.reference = _parseInt(referenceController.text);
    loot.chance = _parseDouble(chanceController.text);
    loot.questRequired = questRequiredController.value.first == 1;
    loot.lootMode = _parseInt(lootModeController.text);
    loot.groupId = _parseInt(groupIdController.text);
    loot.minCount = _parseInt(minCountController.text);
    loot.maxCount = _parseInt(maxCountController.text);
    loot.comment = commentController.text;
    return loot;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);
  double _parseDouble(String text) => text.isEmpty ? 0 : double.parse(text);

  /// 创建新记录
  Future<void> create() async {
    final template = creatureTemplate.value;
    if (template == null) return;

    final nextItem = await repository.getNextItemId(template.lootId);
    resetForm();
    itemController.text = nextItem.toString();
    creating.value = true;
    editing.value = false;
    selectedIndex.value = null;
    editingItem = null;
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    fillForm(loot);
    editing.value = true;
    creating.value = false;
    editingItem = loot.item;
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final loot = items.value[index];
    try {
      await repository.copy(loot.entry, loot.item);
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

  /// 删除记录
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
        await repository.delete(loot.entry, loot.item);
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

  /// 保存记录
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final loot = collectFromForm();
      await repository.store(loot);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('保存成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 更新记录
  Future<void> update(BuildContext context) async {
    saving.value = true;
    try {
      final loot = collectFromForm();
      await repository.update(loot, oldItem: editingItem);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 初始化
  Future<void> initSignals({required int creatureId}) async {
    this.creatureId.value = creatureId;
    await load();
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    itemController.dispose();
    referenceController.dispose();
    chanceController.dispose();
    questRequiredController.dispose();
    lootModeController.dispose();
    groupIdController.dispose();
    minCountController.dispose();
    maxCountController.dispose();
    commentController.dispose();
  }
}
