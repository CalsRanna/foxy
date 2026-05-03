import 'package:flutter/widgets.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/repository/game_object_quest_starter_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameObjectQuestStarterViewModel {
  final questId = signal(0);
  final items = signal<List<BriefGameObjectQuestStarterEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final id = signal<int>(0);
  final quest = signal<int>(0);

  int _originalId = 0;
  int _originalQuest = 0;

  final repository = GameObjectQuestStarterRepository();

  /// 加载数据
  Future<void> load() async {
    final data = await repository.getGameObjectQuestStarters(questId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    id.value = 0;
    quest.value = 0;
  }

  /// 填充表单
  void fillForm(GameObjectQuestStarterEntity model) {
    id.value = model.id;
    quest.value = model.quest;
  }

  /// 从表单收集数据
  GameObjectQuestStarterEntity collectFromForm() {
    return GameObjectQuestStarterEntity(
      id: id.value,
      quest: quest.value,
    );
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final blank = await repository.createGameObjectQuestStarter(questId.value);
      resetForm();
      fillForm(blank);
      _originalId = blank.id;
      _originalQuest = blank.quest;
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建失败: $e');
      DialogUtil.instance.error('创建失败: $e');
    }
  }

  /// 编辑选中记录
  Future<void> edit() async {
    try {
      final index = selectedIndex.value;
      if (index == null || index < 0 || index >= items.value.length) return;

      final item = items.value[index];
      final existing = await repository.getGameObjectQuestStarter({
        'id': item.id,
        'quest': item.quest,
      });
      if (existing == null) return;
      fillForm(existing);
      _originalId = item.id;
      _originalQuest = item.quest;
    } catch (e) {
      LoggerUtil.instance.e('编辑失败: $e');
      DialogUtil.instance.error('编辑失败: $e');
    }
  }

  /// 保存新记录
  Future<void> save(BuildContext context) async {
    try {
      final model = collectFromForm();
      await repository.storeGameObjectQuestStarter(model);
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
      final model = collectFromForm();
      await repository.updateGameObjectQuestStarter({
        'id': _originalId,
        'quest': _originalQuest,
      }, model);
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

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final item = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认复制'),
        description: Text('此操作不会复制关联表数据，确认继续？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ShadButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('复制'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await repository.copyGameObjectQuestStarter({
          'id': item.id,
          'quest': item.quest,
        });
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
  }

  /// 删除记录
  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final item = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('将永久删除该记录，确认继续？'),
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
        await repository.destroyGameObjectQuestStarter({
          'id': item.id,
          'quest': item.quest,
        });
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 初始化
  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  /// 清理资源
  void dispose() {}
}
