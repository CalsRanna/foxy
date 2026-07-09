import 'package:flutter/widgets.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/foxy_form_item.dart';
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
    items.value = await repository.getBriefLootTemplates(gameObjectId.value);
  }

  void resetForm() {
    itemController.clear();
    referenceController.text = _fmt(0);
    chanceController.text = _fmt(0.0);
    questRequiredController.value = {0};
    lootModeController.text = _fmt(1);
    groupIdController.text = _fmt(0);
    minCountController.text = _fmt(1);
    maxCountController.text = _fmt(1);
    commentController.clear();
    editingItem = null;
  }

  void fillForm(BriefLootTemplateEntity loot) {
    itemController.text = loot.item.toString();
    referenceController.text = _fmt(loot.reference);
    chanceController.text = _fmt(loot.chance);
    questRequiredController.value = {loot.questRequired ? 1 : 0};
    lootModeController.text = _fmt(loot.lootMode);
    groupIdController.text = _fmt(loot.groupId);
    minCountController.text = _fmt(loot.minCount);
    maxCountController.text = _fmt(loot.maxCount);
    commentController.text = loot.comment;
    editingItem = loot.item;
  }

  LootTemplateEntity collectFromForm() {
    return LootTemplateEntity(
      entry: gameObjectId.value,
      item: _parseInt(itemController.text),
      reference: _pi(referenceController.text),
      chance: _pd(chanceController.text),
      questRequired: _getSelectValue(questRequiredController) == 1,
      lootMode: _pi(lootModeController.text),
      groupId: _pi(groupIdController.text),
      minCount: _pi(minCountController.text),
      maxCount: _pi(maxCountController.text),
      comment: commentController.text,
    );
  }

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  double _pd(String t) => double.tryParse(t) ?? 0.0;

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  Future<void> create(BuildContext context) async {
    try {
      resetForm();
      final nextItemId = await repository.getNextItemId(gameObjectId.value);
      if (!context.mounted) return;
      itemController.text = nextItemId.toString();
      await showShadDialog(
        context: context,
        builder: (context) => _buildDialogForm(context),
      );
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  void edit(BuildContext context) {
    final index = selectedIndex.value;
    if (index == null) return;
    fillForm(items.value[index]);
    showShadDialog(
      context: context,
      builder: (context) => _buildDialogForm(context),
    );
  }

  Future<void> copy(BuildContext context) async {
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

  Future<void> save(BuildContext context) async {
    try {
      final loot = collectFromForm();
      await repository.storeLootTemplate(loot);
      await load();
      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      DialogUtil.instance.error('保存失败: $e');
    }
  }

  Future<void> update(BuildContext context) async {
    try {
      final loot = collectFromForm();
      await repository.updateLootTemplate(loot.entry, editingItem ?? loot.item, loot);
      await load();
      if (context.mounted) Navigator.of(context).pop();
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
    chanceController.dispose();
    commentController.dispose();
    groupIdController.dispose();
    itemController.dispose();
    lootModeController.dispose();
    maxCountController.dispose();
    minCountController.dispose();
    questRequiredController.dispose();
    referenceController.dispose();
  }

  Widget _buildDialogForm(BuildContext context) {
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
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: itemController,
              placeholder: '物品ID',
            ),
          ),
          FoxyNumberInput<int>(controller: referenceController),
          FoxyNumberInput<double>(
            controller: chanceController,
            placeholder: '掉落几率',
          ),
          FoxyFormItem(
            label: '需要任务',
            child: FoxyShadSelect<int>(
              controller: questRequiredController,
              options: const {0: '否', 1: '是'},
              placeholder: const Text('QuestRequired'),
            ),
          ),
          FoxyNumberInput<int>(
            controller: lootModeController,
            placeholder: '掉落模式',
          ),
          FoxyNumberInput<int>(
            controller: groupIdController,
            placeholder: '组ID',
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: FoxyNumberInput<int>(
                  controller: minCountController,
                  placeholder: '最小数量',
                ),
              ),
              Expanded(
                child: FoxyNumberInput<int>(
                  controller: maxCountController,
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              ShadButton(
                onPressed: () => isNew ? save(context) : update(context),
                child: Text('保存'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
