import 'package:flutter/widgets.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectQuestItemViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final gameObjectEntry = signal<int>(0);
  final items = signal<List<GameObjectQuestItemEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final idxController = TextEditingController();
  final itemIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();
  final _repository = GetIt.instance.get<GameObjectQuestItemRepository>();

  Future<void> load() async {
    items.value = await _repository.getBriefGameObjectQuestItems(
      gameObjectEntry.value,
    );
  }

  void resetForm() {
    idxController.text = _fmt(0);
    itemIdController.clear();
    verifiedBuildController.text = _fmt(0);
  }

  void fillForm(GameObjectQuestItemEntity questItem) {
    idxController.text = _fmt(questItem.idx);
    itemIdController.text = questItem.itemId.toString();
    verifiedBuildController.text = _fmt(questItem.verifiedBuild);
  }

  GameObjectQuestItemEntity collectFromForm() {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry.value,
      idx: _pi(idxController.text),
      itemId: _parseInt(itemIdController.text),
      verifiedBuild: _pi(verifiedBuildController.text),
    );
  }

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  Future<void> create(BuildContext context) async {
    try {
      resetForm();
      final nextIdx = await _repository.getNextIdx(gameObjectEntry.value);
      if (!context.mounted) return;
      idxController.text = _fmt(nextIdx);
      await showFoxyDialog(
        context: context,
        builder: (context) => _buildDialogForm(context, isNew: true),
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
    showFoxyDialog(
      context: context,
      builder: (context) => _buildDialogForm(context, isNew: false),
    );
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null) return;
    try {
      final item = items.value[index];
      await _repository.copyGameObjectQuestItem(item.gameObjectEntry, item.idx);
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
      await _repository.destroyGameObjectQuestItem(
        item.gameObjectEntry,
        item.idx,
      );
      DialogUtil.instance.success('删除成功');
      await load();
    } catch (e) {
      DialogUtil.instance.error('删除失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final questItem = collectFromForm();
      await _repository.storeGameObjectQuestItem(questItem);
      await load();
      if (context.mounted) Navigator.of(context).pop();
    } catch (e) {
      DialogUtil.instance.error('保存失败: $e');
    }
  }

  Future<void> update(BuildContext context) async {
    try {
      final questItem = collectFromForm();
      await _repository.updateGameObjectQuestItem(questItem);
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
      gameObjectEntry.value = gameObjectId;
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
    idxController.dispose();
    itemIdController.dispose();
    verifiedBuildController.dispose();
  }

  Widget _buildDialogForm(BuildContext context, {required bool isNew}) {
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
          FoxyNumberInput<int>(controller: idxController),
          SizedBox(
            height: 100,
            child: FoxyEntityPicker(
              delegate: FoxyEntityPickerDelegates.itemTemplate,
              controller: itemIdController,
              placeholder: '物品ID',
            ),
          ),
          FoxyNumberInput<int>(controller: verifiedBuildController),
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
