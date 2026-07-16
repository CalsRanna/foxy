import 'package:flutter/widgets.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcVendorViewModel with FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final items = signal<List<BriefNpcVendorEntity>>([]);
  final selectedIndex = signal<int?>(null);
  // 表单控制器
  late final creatureIdController = registerController(IntFieldController());
  late final slotController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final maxcountController = registerController(IntFieldController());
  late final incrtimeController = registerController(IntFieldController());
  late final extendedCostController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  // 内部状态
  int? _editingItem;
  int? _editingExtendedCost;

  final _repository = GetIt.instance.get<NpcVendorRepository>();

  /// 从表单收集数据
  NpcVendorEntity collectFromForm() {
    return NpcVendorEntity(
      entry: entry.value,
      slot: slotController.collect(),
      item: itemController.collect(),
      maxcount: maxcountController.collect(),
      incrtime: incrtimeController.collect(),
      extendedCost: extendedCostController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final nextSlot = await _repository.getNextSlot(entry.value);
      resetForm();
      slotController.init(nextSlot);
      selectedIndex.value = null;
      _editingItem = null;
      _editingExtendedCost = null;
    } catch (e) {
      LoggerUtil.instance.e('创建NPC商人记录失败: $e');
      DialogUtil.instance.error('创建NPC商人记录失败: $e');
    }
  }

  /// 删除记录
  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final vendor = items.value[index];

    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条商品记录吗？'),
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
        await _repository.destroyNpcVendor(
          vendor.entry,
          vendor.item,
          vendor.extendedCost,
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

  /// 清理资源
  void dispose() {
    disposeControllers();
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final vendor = items.value[index];
    fillForm(vendor);
    _editingItem = vendor.item;
    _editingExtendedCost = vendor.extendedCost;
  }

  /// 填充表单
  void fillForm(BriefNpcVendorEntity vendor) {
    slotController.init(vendor.slot);
    itemController.init(vendor.item);
    maxcountController.init(vendor.maxcount);
    incrtimeController.init(vendor.incrtime);
    extendedCostController.init(vendor.extendedCost);
    verifiedBuildController.init(vendor.verifiedBuild);
  }

  /// 初始化
  Future<void> initSignals({required int creatureId}) async {
    try {
      entry.value = creatureId;
      creatureIdController.init(creatureId);
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化NPC商人失败: $e');
      DialogUtil.instance.error('初始化NPC商人失败: $e');
    }
  }

  /// 加载数据

  Future<void> load() async {
    final data = await _repository.getBriefNpcVendors(entry.value);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 重置表单
  void resetForm() {
    slotController.init(0);
    itemController.init(0);
    maxcountController.init(0);
    incrtimeController.init(0);
    extendedCostController.init(0);
    verifiedBuildController.init(0);
  }

  /// 保存记录（新增）
  Future<void> save(BuildContext context) async {
    try {
      final vendor = collectFromForm();
      await _repository.storeNpcVendor(vendor);
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
      final vendor = collectFromForm();
      await _repository.updateNpcVendor(
        entry.value,
        _editingItem ?? vendor.item,
        _editingExtendedCost ?? vendor.extendedCost,
        vendor,
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
