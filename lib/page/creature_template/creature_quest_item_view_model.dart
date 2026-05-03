import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureQuestItemViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureEntry = signal(0);
  final items = signal<List<CreatureQuestItemEntity>>([]);
  final selectedIndex = signal<int?>(null);
  // 表单控制器
  final idx = signal<int>(0);
  final itemIdController = TextEditingController();
  final verifiedBuild = signal<int>(0);

  final repository = CreatureQuestItemRepository();

  /// 加载数据
  Future<void> load() async {
    final data = await repository.getCreatureQuestItems(creatureEntry.value);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    idx.value = 0;
    itemIdController.clear();
    verifiedBuild.value = 0;
  }

  /// 填充表单
  void fillForm(CreatureQuestItemEntity questItem) {
    idx.value = questItem.idx;
    itemIdController.text = questItem.itemId.toString();
    verifiedBuild.value = questItem.verifiedBuild;
  }

  /// 从表单收集数据
  CreatureQuestItemEntity collectFromForm() {
    final questItem = CreatureQuestItemEntity(
      creatureEntry: creatureEntry.value,
      idx: idx.value,
      itemId: _parseInt(itemIdController.text),
      verifiedBuild: verifiedBuild.value,
    );
    return questItem;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final nextIdx = await repository.getNextIdx(creatureEntry.value);
      resetForm();
      idx.value = nextIdx;
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建生物任务物品记录失败: $e');
      DialogUtil.instance.error('创建生物任务物品记录失败: $e');
    }
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
      await repository.copyCreatureQuestItem(
        questItem.creatureEntry,
        questItem.idx,
      );
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
        await repository.destroyCreatureQuestItem(
          questItem.creatureEntry,
          questItem.idx,
        );
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
    try {
      final questItem = collectFromForm();
      await repository.storeCreatureQuestItem(questItem);
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

  /// 更新记录
  Future<void> update(BuildContext context) async {
    try {
      final questItem = collectFromForm();
      await repository.updateCreatureQuestItem(questItem);
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 初始化
  Future<void> initSignals({required int creatureId}) async {
    try {
      creatureEntry.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物任务物品失败: $e');
      DialogUtil.instance.error('初始化生物任务物品失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    itemIdController.dispose();
  }
}
