import 'package:flutter/widgets.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcTrainerViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final id = signal(0);
  final items = signal<List<BriefNpcTrainerEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final creating = signal(false);
  final editing = signal(false);

  // 表单控制器
  final creatureIdController = IntFieldController();
  final spellIDController = IntFieldController();
  final moneyCostController = IntFieldController();
  final reqSkillLineController = IntFieldController();
  final reqSkillRankController = IntFieldController();
  final reqLevelController = IntFieldController();

  late final _controllers = <FieldController>[
    creatureIdController,
    spellIDController,
    moneyCostController,
    reqSkillLineController,
    reqSkillRankController,
    reqLevelController,
  ];

  final _repository = GetIt.instance.get<NpcTrainerRepository>();

  /// 加载数据

  Future<void> load() async {
    final data = await _repository.getBriefNpcTrainers(id.value);
    items.value = data;
    selectedIndex.value = null;
    creating.value = false;
    editing.value = false;
  }

  /// 重置表单
  void resetForm() {
    spellIDController.init(0);
    moneyCostController.init(0);
    reqSkillLineController.init(0);
    reqSkillRankController.init(0);
    reqLevelController.init(0);
  }

  /// 填充表单
  void fillForm(BriefNpcTrainerEntity trainer) {
    spellIDController.init(trainer.spellID);
    moneyCostController.init(trainer.moneyCost);
    reqSkillLineController.init(trainer.reqSkillLine);
    reqSkillRankController.init(trainer.reqSkillRank);
    reqLevelController.init(trainer.reqLevel);
  }

  /// 从表单收集数据
  NpcTrainerEntity collectFromForm() {
    return NpcTrainerEntity(
      id: id.value,
      spellID: spellIDController.collect(),
      moneyCost: moneyCostController.collect(),
      reqSkillLine: reqSkillLineController.collect(),
      reqSkillRank: reqSkillRankController.collect(),
      reqLevel: reqLevelController.collect(),
    );
  }

  /// 创建新记录
  void create() {
    resetForm();
    creating.value = true;
    editing.value = false;
    selectedIndex.value = null;
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final trainer = items.value[index];
    fillForm(trainer);
    editing.value = true;
    creating.value = false;
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final trainer = items.value[index];
    try {
      await _repository.copyNpcTrainer(trainer.id, trainer.spellID);
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

    final trainer = items.value[index];

    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条训练师技能记录吗？'),
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
        await _repository.destroyNpcTrainer(trainer.id, trainer.spellID);
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
      final trainer = collectFromForm();
      await _repository.storeNpcTrainer(trainer);
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
      final trainer = collectFromForm();
      await _repository.updateNpcTrainer(trainer.id, trainer.spellID, trainer);
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
      id.value = creatureId;
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化NPC训练师失败: $e');
      DialogUtil.instance.error('初始化NPC训练师失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
