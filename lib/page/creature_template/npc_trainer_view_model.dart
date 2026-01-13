import 'package:flutter/material.dart';
import 'package:foxy/model/npc_trainer.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcTrainerViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final id = signal(0);
  final items = signal<List<NpcTrainer>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(false);
  final editing = signal(false);

  // 表单控制器
  final spellIDController = TextEditingController();
  final moneyCostController = TextEditingController();
  final reqSkillLineController = TextEditingController();
  final reqSkillRankController = TextEditingController();
  final reqLevelController = TextEditingController();

  final repository = NpcTrainerRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getByEntry(id.value);
      items.value = data;
      selectedIndex.value = null;
      creating.value = false;
      editing.value = false;
    } catch (e) {
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  /// 重置表单
  void resetForm() {
    spellIDController.clear();
    moneyCostController.text = '0';
    reqSkillLineController.text = '0';
    reqSkillRankController.text = '0';
    reqLevelController.text = '0';
  }

  /// 填充表单
  void fillForm(NpcTrainer trainer) {
    spellIDController.text = trainer.spellID.toString();
    moneyCostController.text = trainer.moneyCost.toString();
    reqSkillLineController.text = trainer.reqSkillLine.toString();
    reqSkillRankController.text = trainer.reqSkillRank.toString();
    reqLevelController.text = trainer.reqLevel.toString();
  }

  /// 从表单收集数据
  NpcTrainer collectFromForm() {
    final trainer = NpcTrainer();
    trainer.id = id.value;
    trainer.spellID = _parseInt(spellIDController.text);
    trainer.moneyCost = _parseInt(moneyCostController.text);
    trainer.reqSkillLine = _parseInt(reqSkillLineController.text);
    trainer.reqSkillRank = _parseInt(reqSkillRankController.text);
    trainer.reqLevel = _parseInt(reqLevelController.text);
    return trainer;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

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
      await repository.copy(trainer.id, trainer.spellID);
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

    final confirmed = await showShadDialog<bool>(
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
        await repository.delete(trainer.id, trainer.spellID);
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
    saving.value = true;
    try {
      final trainer = collectFromForm();
      await repository.store(trainer);
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
      final trainer = collectFromForm();
      await repository.update(trainer);
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

  /// 选择行
  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  /// 初始化
  Future<void> initSignals({required int creatureId}) async {
    id.value = creatureId;
    await load();
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    spellIDController.dispose();
    moneyCostController.dispose();
    reqSkillLineController.dispose();
    reqSkillRankController.dispose();
    reqLevelController.dispose();
  }
}
