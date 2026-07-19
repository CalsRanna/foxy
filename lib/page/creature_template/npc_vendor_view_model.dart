import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_npc_vendor_entity.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/entity/npc_vendor_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/npc_vendor_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class NpcVendorViewModel
    with
        ViewModelValidationMixin,
        NpcVendorValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<NpcVendorRepository>();

  final entry = signal(0);
  final editingKey = signal<NpcVendorKey?>(null);
  final items = signal<List<BriefNpcVendorEntity>>([]);
  final page = signal(1);
  final selectedIndex = signal<int?>(null);
  final total = signal(0);

  late final creatureIdController = registerController(IntFieldController());
  late final slotController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final maxcountController = registerController(IntFieldController());
  late final incrtimeController = registerController(IntFieldController());
  late final extendedCostController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  int _refreshToken = 0;

  NpcVendorEntity collectFromForm() {
    return NpcVendorEntity(
      entry: creatureIdController.collect(),
      slot: slotController.collect(),
      item: itemController.collect(),
      maxcount: maxcountController.collect(),
      incrtime: incrtimeController.collect(),
      extendedCost: extendedCostController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<bool> create() async {
    try {
      final blank = await _repository.createNpcVendor(entry.value);
      _clearEditingState();
      _initControllers(blank);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建 NPC 商人记录失败: $error');
      DialogUtil.instance.error('创建 NPC 商人记录失败: $error');
      return false;
    }
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final vendor = items.value[index];
    final confirmed = await showFoxyDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: const Text('确认删除'),
        description: const Text('确定要删除这条商品记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    try {
      await _repository.destroyNpcVendor(vendor.key);
      await load();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<bool> edit() async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return false;
    final key = items.value[index].key;
    editingKey.value = key;
    try {
      final vendor = await _repository.getNpcVendor(key);
      if (vendor == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(vendor);
      return true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载 NPC 商人记录失败: $error');
      DialogUtil.instance.error('加载 NPC 商人记录失败: $error');
      return false;
    }
  }

  Future<void> initSignals({required int creatureId}) async {
    try {
      await setParentEntry(creatureId);
    } catch (error) {
      LoggerUtil.instance.e('初始化 NPC 商人失败: $error');
      DialogUtil.instance.error('初始化 NPC 商人失败: $error');
    }
  }

  Future<void> load() => _refresh();

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateNpcVendorFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeNpcVendor(candidate);
    } else {
      await _repository.updateNpcVendor(originalKey, candidate);
    }
    editingKey.value = NpcVendorKey.fromEntity(candidate);
    await _refresh();
  }

  void pop() {
    routerFacade.goBack();
  }

  void resetForm() {
    _initControllers(NpcVendorEntity(entry: entry.value));
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
      return false;
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> setParentEntry(int creatureId) async {
    if (entry.value != creatureId) page.value = 1;
    entry.value = creatureId;
    _clearEditingState(resetForm: true);
    await _refresh();
  }

  void _clearEditingState({bool resetForm = false}) {
    editingKey.value = null;
    selectedIndex.value = null;
    if (resetForm) this.resetForm();
  }

  void _initControllers(NpcVendorEntity vendor) {
    creatureIdController.init(vendor.entry);
    slotController.init(vendor.slot);
    itemController.init(vendor.item);
    maxcountController.init(vendor.maxcount);
    incrtimeController.init(vendor.incrtime);
    extendedCostController.init(vendor.extendedCost);
    verifiedBuildController.init(vendor.verifiedBuild);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentEntry = entry.value;
    final count = await _repository.countNpcVendors(parentEntry);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefNpcVendors(
      parentEntry,
      page: page.value,
    );
    if (token != _refreshToken) return;
    items.value = data;
    total.value = count;
    _clearEditingState(resetForm: true);
  }
}
