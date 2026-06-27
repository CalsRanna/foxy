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
  final resistanceController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final _repository = GetIt.instance.get<CreatureTemplateResistanceRepository>();

  /// 加载数据
  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> load() async {
    final data = await _repository.getCreatureTemplateResistances(
      creatureId.value,
    );
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    schoolController.value = {0};
    resistanceController.text = _fmt(0);
    verifiedBuildController.text = _fmt(0);
  }

  /// 填充表单
  void fillForm(CreatureTemplateResistanceEntity resistance) {
    schoolController.value = {resistance.school};
    resistanceController.text = _fmt(resistance.resistance);
    verifiedBuildController.text = _fmt(resistance.verifiedBuild);
  }

  /// 从表单收集数据
  CreatureTemplateResistanceEntity collectFromForm() {
    return CreatureTemplateResistanceEntity(
      creatureID: creatureId.value,
      school: schoolController.value.firstOrNull ?? 0,
      resistance: _pi(resistanceController.text),
      verifiedBuild: _pi(verifiedBuildController.text),
    );
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final nextSchool = await _repository.getNextSchool(creatureId.value);
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
      await _repository.copyCreatureTemplateResistance(
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
        await _repository.destroyCreatureTemplateResistance(
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
      await _repository.storeCreatureTemplateResistance(r);
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
      await _repository.updateCreatureTemplateResistance(r);
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
    resistanceController.dispose();
    schoolController.dispose();
    verifiedBuildController.dispose();
  }
}
