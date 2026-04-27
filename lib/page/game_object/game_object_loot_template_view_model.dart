import 'package:flutter/widgets.dart';
import 'package:foxy/model/loot_template.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectLootTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectId = signal(0);
  final items = signal<List<LootTemplate>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  final itemController = TextEditingController();
  final referenceController = TextEditingController();
  final chanceController = TextEditingController();
  final questRequiredController = ShadSelectController<int>();
  final lootModeController = TextEditingController();
  final groupIdController = TextEditingController();
  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();
  final commentController = TextEditingController();

  int? editingItem;

  final repository = LootTemplateRepository(LootTableType.gameobject);

  Future<void> load() async {
    loading.value = true;
    try {
      items.value = await repository.getByEntry(gameObjectId.value);
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void resetForm() {
    itemController.clear();
    referenceController.clear();
    chanceController.clear();
    questRequiredController.value = {0};
    lootModeController.text = '1';
    groupIdController.clear();
    minCountController.text = '1';
    maxCountController.text = '1';
    commentController.clear();
    editingItem = null;
  }

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
    editingItem = loot.item;
  }

  LootTemplate collectFromForm() {
    final loot = LootTemplate();
    loot.entry = gameObjectId.value;
    loot.item = _parseInt(itemController.text);
    loot.reference = _parseInt(referenceController.text);
    loot.chance = _parseDouble(chanceController.text);
    loot.questRequired = _getSelectValue(questRequiredController) == 1;
    loot.lootMode = _parseInt(lootModeController.text);
    loot.groupId = _parseInt(groupIdController.text);
    loot.minCount = _parseInt(minCountController.text);
    loot.maxCount = _parseInt(maxCountController.text);
    loot.comment = commentController.text;
    return loot;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  Future<void> create(BuildContext dialogContext) async {
    resetForm();
    final nextItemId = await repository.getNextItemId(gameObjectId.value);
    if (!dialogContext.mounted) return;
    itemController.text = nextItemId.toString();
    await showShadDialog(
      context: dialogContext,
      builder: (context) => _buildDialogForm(context),
    );
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
      DialogUtil.instance.loading();
      await repository.copy(item.entry, item.item);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await load();
    } catch (e) {
      logger.e(e.toString());
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
      DialogUtil.instance.loading();
      await repository.delete(item.entry, item.item);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await load();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: $e');
    }
  }

  Future<void> save(BuildContext dialogContext) async {
    saving.value = true;
    try {
      final loot = collectFromForm();
      await repository.store(loot);
      await load();
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
    } catch (e) {
      DialogUtil.instance.error('保存失败: $e');
    } finally {
      saving.value = false;
    }
  }

  Future<void> update(BuildContext dialogContext) async {
    saving.value = true;
    try {
      final loot = collectFromForm();
      await repository.update(loot, oldItem: editingItem);
      await load();
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
    } catch (e) {
      DialogUtil.instance.error('更新失败: $e');
    } finally {
      saving.value = false;
    }
  }

  void selectRow(int index) {
    selectedIndex.value = index;
  }

  Future<void> initSignals({required int gameObjectId}) async {
    this.gameObjectId.value = gameObjectId;
    await load();
  }

  void pop() {
    routerFacade.goBack();
  }

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
          ShadInput(controller: referenceController, placeholder: Text('关联ID')),
          ShadInput(controller: chanceController, placeholder: Text('掉落几率')),
          FormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: questRequiredController,
              options: const {0: '否', 1: '是'},
              placeholder: const Text('QuestRequired'),
            ),
          ),
          ShadInput(controller: lootModeController, placeholder: Text('掉落模式')),
          ShadInput(controller: groupIdController, placeholder: Text('组ID')),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: ShadInput(
                  controller: minCountController,
                  placeholder: Text('最小数量'),
                ),
              ),
              Expanded(
                child: ShadInput(
                  controller: maxCountController,
                  placeholder: Text('最大数量'),
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
                onPressed: saving.value
                    ? null
                    : () => isNew ? save(dialogContext) : update(dialogContext),
                child: Text('保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
