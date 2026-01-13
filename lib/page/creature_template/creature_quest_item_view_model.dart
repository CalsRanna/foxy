import 'package:flutter/material.dart';
import 'package:foxy/model/creature_questitem.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureQuestItemViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureEntry = signal(0);
  final items = signal<List<CreatureQuestItem>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  // 表单控制器
  final idxController = TextEditingController();
  final itemIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final repository = CreatureQuestItemRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getByEntry(creatureEntry.value);
      items.value = data;
      selectedIndex.value = null;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 重置表单
  void resetForm() {
    idxController.clear();
    itemIdController.clear();
    verifiedBuildController.text = '0';
  }

  /// 填充表单
  void fillForm(CreatureQuestItem questItem) {
    idxController.text = questItem.idx.toString();
    itemIdController.text = questItem.itemId.toString();
    verifiedBuildController.text = questItem.verifiedBuild.toString();
  }

  /// 从表单收集数据
  CreatureQuestItem collectFromForm() {
    final questItem = CreatureQuestItem();
    questItem.creatureEntry = creatureEntry.value;
    questItem.idx = _parseInt(idxController.text);
    questItem.itemId = _parseInt(itemIdController.text);
    questItem.verifiedBuild = _parseInt(verifiedBuildController.text);
    return questItem;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  /// 创建新记录
  Future<void> create() async {
    final nextIdx = await repository.getNextIdx(creatureEntry.value);
    resetForm();
    idxController.text = nextIdx.toString();
    selectedIndex.value = null;
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final questItem = items.value[index];
    fillForm(questItem);
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final questItem = items.value[index];
    try {
      await repository.copy(questItem.creatureEntry, questItem.idx);
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

    final questItem = items.value[index];

    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条任务物品记录吗？'),
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
        await repository.delete(questItem.creatureEntry, questItem.idx);
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
      final questItem = collectFromForm();
      await repository.store(questItem);
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
      final questItem = collectFromForm();
      await repository.update(questItem);
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
    creatureEntry.value = creatureId;
    await load();
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    idxController.dispose();
    itemIdController.dispose();
    verifiedBuildController.dispose();
  }
}
