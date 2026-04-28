import 'package:flutter/widgets.dart';
import 'package:foxy/model/game_object_questitem.dart';
import 'package:foxy/page/creature_template/item_template_selector.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectQuestItemViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectEntry = signal(0);
  final items = signal<List<GameObjectQuestItem>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  final idxController = TextEditingController();
  final itemIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();
  final repository = GameObjectQuestItemRepository();

  Future<void> load() async {
    loading.value = true;
    try {
      items.value = await repository.getGameObjectQuestItems(gameObjectEntry.value);
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void resetForm() {
    idxController.clear();
    itemIdController.clear();
    verifiedBuildController.clear();
  }

  void fillForm(GameObjectQuestItem questItem) {
    idxController.text = questItem.idx.toString();
    itemIdController.text = questItem.itemId.toString();
    verifiedBuildController.text = questItem.verifiedBuild.toString();
  }

  GameObjectQuestItem collectFromForm() {
    final questItem = GameObjectQuestItem();
    questItem.gameObjectEntry = gameObjectEntry.value;
    questItem.idx = _parseInt(idxController.text);
    questItem.itemId = _parseInt(itemIdController.text);
    questItem.verifiedBuild = _parseInt(verifiedBuildController.text);
    return questItem;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  Future<void> create(BuildContext dialogContext) async {
    resetForm();
    final nextIdx = await repository.getNextIdx(gameObjectEntry.value);
    if (!dialogContext.mounted) return;
    idxController.text = nextIdx.toString();
    await showShadDialog(
      context: dialogContext,
      builder: (context) => _buildDialogForm(context, isNew: true),
    );
  }

  void edit(BuildContext dialogContext) {
    final index = selectedIndex.value;
    if (index == null) return;
    fillForm(items.value[index]);
    showShadDialog(
      context: dialogContext,
      builder: (context) => _buildDialogForm(context, isNew: false),
    );
  }

  Future<void> copy(BuildContext dialogContext) async {
    final index = selectedIndex.value;
    if (index == null) return;
    try {
      final item = items.value[index];
      DialogUtil.instance.loading();
      await repository.copyGameObjectQuestItem(item.gameObjectEntry, item.idx);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await load();
    } catch (e) {
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
        description: '是否删除物品 ${item.itemName}？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyGameObjectQuestItem(item.gameObjectEntry, item.idx);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await load();
    } catch (e) {
      DialogUtil.instance.error('删除失败: $e');
    }
  }

  Future<void> save(BuildContext dialogContext) async {
    saving.value = true;
    try {
      final questItem = collectFromForm();
      await repository.storeGameObjectQuestItem(questItem);
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
      final questItem = collectFromForm();
      await repository.updateGameObjectQuestItem(questItem);
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
    gameObjectEntry.value = gameObjectId;
    await load();
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    idxController.dispose();
    itemIdController.dispose();
    verifiedBuildController.dispose();
  }

  Widget _buildDialogForm(BuildContext dialogContext, {required bool isNew}) {
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
                text: gameObjectEntry.value.toString(),
              ),
              readOnly: true,
              placeholder: Text('游戏对象编号'),
            ),
          ),
          ShadInput(controller: idxController, placeholder: Text('索引')),
          SizedBox(
            height: 100,
            child: ItemTemplateSelector(
              controller: itemIdController,
              placeholder: '物品ID',
            ),
          ),
          ShadInput(
            controller: verifiedBuildController,
            placeholder: Text('VerifiedBuild'),
          ),
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
