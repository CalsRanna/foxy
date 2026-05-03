import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateResistanceViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final items = signal<List<CreatureTemplateResistanceEntity>>([]);
  final selectedIndex = signal<int?>(null);
  // 表单控制器
  final schoolController = ShadSelectController<int>();
  final resistance = signal<int>(0);
  final verifiedBuild = signal<int>(0);

  final repository = CreatureTemplateResistanceRepository();

  /// 加载数据
  Future<void> load() async {
    final data = await repository.getCreatureTemplateResistances(
      creatureId.value,
    );
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    schoolController.value = {0};
    resistance.value = 0;
    verifiedBuild.value = 0;
  }

  /// 填充表单
  void fillForm(CreatureTemplateResistanceEntity resistance) {
    schoolController.value = {resistance.school};
    this.resistance.value = resistance.resistance;
    verifiedBuild.value = resistance.verifiedBuild;
  }

  /// 从表单收集数据
  CreatureTemplateResistanceEntity collectFromForm() {
    final r = CreatureTemplateResistanceEntity();
    r.creatureID = creatureId.value;
    r.school = schoolController.value.firstOrNull ?? 0;
    r.resistance = resistance.value;
    r.verifiedBuild = verifiedBuild.value;
    return r;
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final nextSchool = await repository.getNextSchool(creatureId.value);
      resetForm();
      schoolController.value = {nextSchool};
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建生物抗性记录失败: $e');
      DialogUtil.instance.error('创建生物抗性记录失败: $e');
    }
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final r = items.value[index];
    fillForm(r);
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final r = items.value[index];
    try {
      await repository.copyCreatureTemplateResistance(
        r.creatureID,
        r.school,
      );
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

    final r = items.value[index];

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
        await repository.destroyCreatureTemplateResistance(
          r.creatureID,
          r.school,
        );
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
      final r = collectFromForm();
      await repository.storeCreatureTemplateResistance(r);
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
      final r = collectFromForm();
      await repository.updateCreatureTemplateResistance(r);
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
      this.creatureId.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物抗性失败: $e');
      DialogUtil.instance.error('初始化生物抗性失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    schoolController.dispose();
  }
}
