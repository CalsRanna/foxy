import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_quest_starter_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureQuestStarterViewModel with FieldControllerMixin {
  final questId = signal(0);
  final items = signal<List<BriefCreatureQuestStarterEntity>>([]);
  final selectedIndex = signal<int?>(null);
  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  int _originalId = 0;
  int _originalQuest = 0;

  final _repository = GetIt.instance.get<CreatureQuestStarterRepository>();

  /// 从表单收集数据
  CreatureQuestStarterEntity collectFromForm() {
    return CreatureQuestStarterEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final blank = await _repository.createCreatureQuestStarter(questId.value);
      resetForm();
      fillForm(blank);
      _originalId = blank.id;
      _originalQuest = blank.quest;
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建生物任务起始记录失败: $e');
      DialogUtil.instance.error('创建生物任务起始记录失败: $e');
    }
  }

  /// 删除记录
  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final item = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
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
        await _repository.destroyCreatureQuestStarter(item.id, item.quest);
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

  /// 清理资源
  void dispose() {
    disposeControllers();
  }

  /// 编辑选中记录
  Future<void> edit() async {
    try {
      final index = selectedIndex.value;
      if (index == null || index < 0 || index >= items.value.length) return;

      final item = items.value[index];
      final existing = await _repository.getCreatureQuestStarter(
        item.id,
        item.quest,
      );
      if (existing == null) return;
      fillForm(existing);
      _originalId = item.id;
      _originalQuest = item.quest;
    } catch (e) {
      LoggerUtil.instance.e('编辑生物任务起始记录失败: $e');
      DialogUtil.instance.error('编辑生物任务起始记录失败: $e');
    }
  }

  /// 填充表单
  void fillForm(CreatureQuestStarterEntity model) {
    idController.init(model.id);
    questController.init(model.quest);
  }

  /// 初始化
  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物任务起始失败: $e');
      DialogUtil.instance.error('初始化生物任务起始失败: $e');
    }
  }

  Future<void> load() async {
    final data = await _repository.getBriefCreatureQuestStarters(questId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    idController.init(0);
    questController.init(0);
  }

  /// 保存新记录
  Future<void> save(BuildContext context) async {
    try {
      final model = collectFromForm();
      await _repository.storeCreatureQuestStarter(model);
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 更新记录
  Future<void> update(BuildContext context) async {
    try {
      final model = collectFromForm();
      await _repository.updateCreatureQuestStarter(
        _originalId,
        _originalQuest,
        model,
      );
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
}
