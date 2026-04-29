import 'package:flutter/widgets.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureEquipTemplateViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final creatureId = signal(0);
  final items = signal<List<BriefCreatureEquipTemplate>>([]);
  final selectedIndex = signal<int?>(null);
  final loading = signal(false);
  final saving = signal(false);

  // 表单控制器
  final idController = TextEditingController();
  final itemID1Controller = TextEditingController();
  final itemID2Controller = TextEditingController();
  final itemID3Controller = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final repository = CreatureEquipTemplateRepository();

  /// 加载数据
  Future<void> load() async {
    loading.value = true;
    try {
      final data = await repository.getCreatureEquipTemplates(creatureId.value);
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
    itemID1Controller.clear();
    itemID2Controller.clear();
    itemID3Controller.clear();
    verifiedBuildController.text = '0';
  }

  /// 填充表单
  void fillForm(BriefCreatureEquipTemplate equip) {
    idController.text = equip.id.toString();
    itemID1Controller.text = equip.itemID1.toString();
    itemID2Controller.text = equip.itemID2.toString();
    itemID3Controller.text = equip.itemID3.toString();
    verifiedBuildController.text = equip.verifiedBuild.toString();
  }

  /// 从表单收集数据
  CreatureEquipTemplateEntity collectFromForm() {
    final equip = CreatureEquipTemplateEntity(
      creatureID: creatureId.value,
      id: _parseInt(idController.text),
      itemID1: _parseInt(itemID1Controller.text),
      itemID2: _parseInt(itemID2Controller.text),
      itemID3: _parseInt(itemID3Controller.text),
      verifiedBuild: _parseInt(verifiedBuildController.text),
    );
    return equip;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  /// 创建新记录
  Future<void> create() async {
    final nextId = await repository.getNextId(creatureId.value);
    resetForm();
    idController.text = nextId.toString();
    selectedIndex.value = null;
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
      await repository.copyCreatureEquipTemplate(equip.creatureID, equip.id);
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

    final confirmed = await showShadDialog<bool>(
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
        await repository.destroyCreatureEquipTemplate(
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
    saving.value = true;
    try {
      final equip = collectFromForm();
      await repository.storeCreatureEquipTemplate(equip);
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
      final equip = collectFromForm();
      await repository.updateCreatureEquipTemplate(equip);
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
    idController.dispose();
    itemID1Controller.dispose();
    itemID2Controller.dispose();
    itemID3Controller.dispose();
    verifiedBuildController.dispose();
  }
}
