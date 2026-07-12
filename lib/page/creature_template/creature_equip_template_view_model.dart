import 'package:flutter/widgets.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureEquipTemplateViewModel with FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final items = signal<List<BriefCreatureEquipTemplateEntity>>([]);
  final selectedIndex = signal<int?>(null);
  // 表单控制器
  late final creatureIdController = registerController(IntFieldController());
  late final idController = registerController(IntFieldController());
  late final itemID1Controller = registerController(IntFieldController());
  late final itemID2Controller = registerController(IntFieldController());
  late final itemID3Controller = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  final _repository = GetIt.instance.get<CreatureEquipTemplateRepository>();

  /// 加载数据

  Future<void> load() async {
    final data = await _repository.getBriefCreatureEquipTemplates(
      creatureId.value,
    );
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    idController.init(0);
    itemID1Controller.init(0);
    itemID2Controller.init(0);
    itemID3Controller.init(0);
    verifiedBuildController.init(0);
  }

  /// 填充表单
  void fillForm(BriefCreatureEquipTemplateEntity equip) {
    idController.init(equip.id);
    itemID1Controller.init(equip.itemID1);
    itemID2Controller.init(equip.itemID2);
    itemID3Controller.init(equip.itemID3);
    verifiedBuildController.init(equip.verifiedBuild);
  }

  /// 从表单收集数据
  CreatureEquipTemplateEntity collectFromForm() {
    final equip = CreatureEquipTemplateEntity(
      creatureID: creatureId.value,
      id: idController.collect(),
      itemID1: itemID1Controller.collect(),
      itemID2: itemID2Controller.collect(),
      itemID3: itemID3Controller.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
    return equip;
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final blank = await _repository.createCreatureEquipTemplate(
        creatureId.value,
      );
      resetForm();
      idController.init(blank.id);
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('创建生物装备记录失败: $e');
      DialogUtil.instance.error('创建生物装备记录失败: $e');
    }
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final equip = items.value[index];
    fillForm(equip);
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final equip = items.value[index];
    try {
      await _repository.copyCreatureEquipTemplate(equip.creatureID, equip.id);
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

    final equip = items.value[index];

    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条装备模板记录吗？'),
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
        await _repository.destroyCreatureEquipTemplate(
          equip.creatureID,
          equip.id,
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
      final equip = collectFromForm();
      await _repository.storeCreatureEquipTemplate(equip);
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
      final equip = collectFromForm();
      await _repository.updateCreatureEquipTemplate(equip);
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
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化生物装备失败: $e');
      DialogUtil.instance.error('初始化生物装备失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    disposeControllers();
  }
}
