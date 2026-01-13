import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template_resistance.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateResistanceViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final items = signal<List<CreatureTemplateResistance>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  // 表单控制器
  final schoolController = ShadSelectController<int>();
  final resistanceController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final repository = CreatureTemplateResistanceRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getByEntry(creatureId.value);
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
    schoolController.value = {0};
    resistanceController.clear();
    verifiedBuildController.text = '0';
  }

  /// 填充表单
  void fillForm(CreatureTemplateResistance resistance) {
    schoolController.value = {resistance.school};
    resistanceController.text = resistance.resistance.toString();
    verifiedBuildController.text = resistance.verifiedBuild.toString();
  }

  /// 从表单收集数据
  CreatureTemplateResistance collectFromForm() {
    final resistance = CreatureTemplateResistance();
    resistance.creatureID = creatureId.value;
    resistance.school = schoolController.value.firstOrNull ?? 0;
    resistance.resistance = _parseInt(resistanceController.text);
    resistance.verifiedBuild = _parseInt(verifiedBuildController.text);
    return resistance;
  }

  int _parseInt(String text) => text.isEmpty ? 0 : int.parse(text);

  /// 创建新记录
  Future<void> create() async {
    final nextSchool = await repository.getNextSchool(creatureId.value);
    resetForm();
    schoolController.value = {nextSchool};
    selectedIndex.value = null;
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final resistance = items.value[index];
    fillForm(resistance);
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final resistance = items.value[index];
    try {
      await repository.copy(resistance.creatureID, resistance.school);
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

    final resistance = items.value[index];

    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条抗性记录吗？'),
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
        await repository.delete(resistance.creatureID, resistance.school);
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
      final resistance = collectFromForm();
      await repository.store(resistance);
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
      final resistance = collectFromForm();
      await repository.update(resistance);
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
    this.creatureId.value = creatureId;
    await load();
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    schoolController.dispose();
    resistanceController.dispose();
    verifiedBuildController.dispose();
  }
}
