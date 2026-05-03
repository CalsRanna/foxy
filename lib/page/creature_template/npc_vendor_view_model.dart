import 'package:flutter/widgets.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcVendorViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final items = signal<List<BriefNpcVendorEntity>>([]);
  final selectedIndex = signal<int?>(null);
  // 表单控制器
  final slot = signal<int>(0);
  final itemController = TextEditingController();
  final maxcount = signal<int>(0);
  final incrtime = signal<int>(0);
  final extendedCostController = TextEditingController();
  final verifiedBuild = signal<int>(0);

  // 内部状态
  int? _editingSlot;

  final repository = NpcVendorRepository();

  /// 加载数据
  Future<void> load() async {
    final data = await repository.getNpcVendors(entry.value);
    items.value = data;
    selectedIndex.value = null;
  }

  /// 重置表单
  void resetForm() {
    slot.value = 0;
    itemController.clear();
    maxcount.value = 0;
    incrtime.value = 0;
    extendedCostController.text = '0';
    verifiedBuild.value = 0;
  }

  /// 填充表单
  void fillForm(BriefNpcVendorEntity vendor) {
    slot.value = vendor.slot;
    itemController.text = vendor.item.toString();
    maxcount.value = vendor.maxcount;
    incrtime.value = vendor.incrtime;
    extendedCostController.text = vendor.extendedCost.toString();
    verifiedBuild.value = vendor.verifiedBuild;
  }

  /// 从表单收集数据
  NpcVendorEntity collectFromForm() {
    return NpcVendorEntity(
      entry: entry.value,
      slot: slot.value,
      item: _parseInt(itemController.text),
      maxcount: maxcount.value,
      incrtime: incrtime.value,
      extendedCost: _parseInt(extendedCostController.text),
      verifiedBuild: verifiedBuild.value,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  /// 创建新记录
  Future<void> create() async {
    try {
      final nextSlot = await repository.getNextSlot(entry.value);
      resetForm();
      slot.value = nextSlot;
      selectedIndex.value = null;
      _editingSlot = null;
    } catch (e) {
      LoggerUtil.instance.e('创建NPC商人记录失败: $e');
      DialogUtil.instance.error('创建NPC商人记录失败: $e');
    }
  }

  /// 编辑选中记录
  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final vendor = items.value[index];
    fillForm(vendor);
    _editingSlot = vendor.slot;
  }

  /// 复制记录
  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;

    final vendor = items.value[index];
    try {
      await repository.copyNpcVendor(vendor.entry, vendor.slot);
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

    final vendor = items.value[index];

    final confirmed = await showShadDialog<bool>(
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
        await repository.destroyNpcVendor(vendor.entry, vendor.slot);
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

  /// 保存记录（新增）
  Future<void> save(BuildContext context) async {
    try {
      final vendor = collectFromForm();
      await repository.storeNpcVendor(vendor);
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
      final vendor = collectFromForm();
      await repository.updateNpcVendor(vendor, oldSlot: _editingSlot);
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
      entry.value = creatureId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('初始化NPC商人失败: $e');
      DialogUtil.instance.error('初始化NPC商人失败: $e');
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 清理资源
  void dispose() {
    itemController.dispose();
    extendedCostController.dispose();
  }
}
