import 'package:flutter/widgets.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectId = signal<int>(0);
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final itemController = TextEditingController();
  final reference = signal<int>(0);
  final chance = signal<double>(0.0);
  final questRequiredController = ShadSelectController<int>();
  final lootMode = signal<int>(0);
  final groupId = signal<int>(0);
  final minCount = signal<int>(0);
  final maxCount = signal<int>(0);
  final commentController = TextEditingController();

  int? editingItem;

  final repository = LootTemplateRepository(LootTableType.gameobject);

  Future<void> load() async {
    items.value = await repository.getLootTemplates(gameObjectId.value);
  }

  void resetForm() {
    itemController.clear();
    reference.value = 0;
    chance.value = 0.0;
    questRequiredController.value = {0};
    lootMode.value = 1;
    groupId.value = 0;
    minCount.value = 1;
    maxCount.value = 1;
    commentController.clear();
    editingItem = null;
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
    editingItem = loot.item;
  }

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: gameObjectId.value,
      item: _parseInt(itemController.text),
      reference: reference.value,
      chance: chance.value,
      questRequired: _getSelectValue(questRequiredController) == 1,
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

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  Future<void> create(BuildContext dialogContext) async {
    try {
      resetForm();
      final nextItemId = await repository.getNextItemId(gameObjectId.value);
      if (!dialogContext.mounted) return;
      itemController.text = nextItemId.toString();
      await showShadDialog(
        context: dialogContext,
        builder: (context) => _buildDialogForm(context),
      );
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  void edit(BuildContext dialogContext) {
    final index = selectedIndex.value;
    if (index == null) return;
    fillForm(items.value[index]);
    showShadDialog(
      context: dialogContext,
      builder: (context) => _buildDialogForm(context),
    );
  }

  Future<void> copy(BuildContext dialogContext) async {
    final index = selectedIndex.value;
    if (index == null) return;
    try {
      final item = items.value[index];
      await repository.copyLootTemplate(item.entry, item.item);
      DialogUtil.instance.success('复制成功');
      await load();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: $e');
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
      await repository.destroyLootTemplate(item.entry, item.item);
      DialogUtil.instance.success('删除成功');
      await load();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: $e');
    }
  }

  Future<void> save(BuildContext dialogContext) async {
    try {
      final loot = collectFromForm();
      await repository.storeLootTemplate(loot);
      await load();
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
    } catch (e) {
      DialogUtil.instance.error('保存失败: $e');
    }
  }

  Future<void> update(BuildContext dialogContext) async {
    try {
      final loot = collectFromForm();
      await repository.updateLootTemplate(loot, oldItem: editingItem);
      await load();
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
    } catch (e) {
      DialogUtil.instance.error('更新失败: $e');
    }
  }

  void selectRow(int index) {
    selectedIndex.value = index;
  }

  Future<void> initSignals({required int gameObjectId}) async {
    try {
      this.gameObjectId.value = gameObjectId;
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

  Widget _buildDialogForm(BuildContext dialogContext) {
    final isNew = editingItem == null;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          SizedBox(
            height: 100,
            child: ShadInput(
              controller: TextEditingController(
                text: gameObjectId.value.toString(),
              ),
              readOnly: true,
              placeholder: Text('游戏对象编号'),
            ),
          ),
          SizedBox(
            height: 100,
            child: ItemTemplateSelector(
              controller: itemController,
              placeholder: '物品ID',
            ),
          ),
          FoxyNumberInput<int>(
            value: reference.value,
            onChanged: (v) => reference.value = v,
          ),
          FoxyNumberInput<double>(
            value: chance.value,
            onChanged: (v) => chance.value = v,
            placeholder: '掉落几率',
          ),
          FormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: questRequiredController,
              options: const {0: '否', 1: '是'},
              placeholder: const Text('QuestRequired'),
            ),
          ),
          FoxyNumberInput<int>(
            value: lootMode.value,
            onChanged: (v) => lootMode.value = v,
            placeholder: '掉落模式',
          ),
          FoxyNumberInput<int>(
            value: groupId.value,
            onChanged: (v) => groupId.value = v,
            placeholder: '组ID',
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: FoxyNumberInput<int>(
                  value: minCount.value,
                  onChanged: (v) => minCount.value = v,
                  placeholder: '最小数量',
                ),
              ),
              Expanded(
                child: FoxyNumberInput<int>(
                  value: maxCount.value,
                  onChanged: (v) => maxCount.value = v,
                  placeholder: '最大数量',
                ),
              ),
            ],
          ),
          ShadInput(controller: commentController, placeholder: Text('备注')),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 12,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text('取消'),
              ),
              ShadButton(
                onPressed: () => isNew ? save(dialogContext) : update(dialogContext),
                child: Text('保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
