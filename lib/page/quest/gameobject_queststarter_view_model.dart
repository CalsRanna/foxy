import 'package:flutter/widgets.dart';
import 'package:foxy/model/gameobject_queststarter.dart';
import 'package:foxy/repository/gameobject_queststarter_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class GameobjectQueststarterViewModel {
  final questId = signal(0);
  final items = signal<List<BriefGameobjectQueststarter>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  // 表单控制器
  final idController = TextEditingController();
  final questController = TextEditingController();

  int _originalId = 0;
  int _originalQuest = 0;

  final repository = GameobjectQueststarterRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getGameobjectQueststarters(questId.value);
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
    idController.clear();
    questController.clear();
  }

  /// 填充表单
  void fillForm(GameobjectQueststarter model) {
    idController.text = model.id.toString();
    questController.text = model.quest.toString();
  }

  /// 从表单收集数据
  GameobjectQueststarter collectFromForm() {
    return GameobjectQueststarter(
      id: int.tryParse(idController.text) ?? 0,
      quest: int.tryParse(questController.text) ?? 0,
    );
  }

  /// 创建新记录
  Future<void> create() async {
    final blank = await repository.createGameobjectQueststarter(questId.value);
    resetForm();
    fillForm(blank);
    _originalId = blank.id;
    _originalQuest = blank.quest;
    selectedIndex.value = null;
  }

  /// 编辑选中记录
  Future<void> edit() async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final item = items.value[index];
    final existing = await repository.getGameobjectQueststarter({
      'id': item.id,
      'quest': item.quest,
    });
    if (existing == null) return;
    fillForm(existing);
    _originalId = item.id;
    _originalQuest = item.quest;
  }

  /// 保存新记录
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final model = collectFromForm();
      await repository.storeGameobjectQueststarter(model);
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
      final model = collectFromForm();
      await repository.updateGameobjectQueststarter({
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
    } finally {
      saving.value = false;
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
        await repository.copyGameobjectQueststarter({'id': item.id, 'quest': item.quest});
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
        await repository.destroyGameobjectQueststarter({'id': item.id, 'quest': item.quest});
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
    this.questId.value = questId;
    await load();
  }

  /// 清理资源
  void dispose() {
    idController.dispose();
    questController.dispose();
  }
}
