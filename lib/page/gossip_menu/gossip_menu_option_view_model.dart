import 'package:flutter/widgets.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

/// Tab 3 (gossip_menu_option) ViewModel
class GossipMenuOptionViewModel {
  final _repository = GossipMenuOptionRepository();

  final currentMenuId = signal(0);
  final options = signal<List<GossipMenuOptionEntity>>([]);
  final loading = signal(false);
  final saving = signal(false);

  /// UI 状态
  final editing = signal(false);
  final creating = signal(false);

  /// 表单 controllers
  final menuIdController = TextEditingController();
  final optionIdController = TextEditingController();
  final optionIconController = ShadSelectController<int>();
  final optionTextController = TextEditingController();
  final optionBroadcastTextIdController = TextEditingController();
  final optionTypeController = ShadSelectController<int>();
  final optionNpcFlagController = TextEditingController();
  final boxCodedController = TextEditingController();
  final boxMoneyController = TextEditingController();
  final boxTextController = TextEditingController();
  final boxBroadcastTextIdController = TextEditingController();
  final actionMenuIdController = TextEditingController();
  final actionPoiIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  int _originalMenuId = 0;
  int _originalOptionId = 0;

  Future<void> search(int menuId) async {
    loading.value = true;
    try {
      currentMenuId.value = menuId;
      options.value = await _repository.getGossipMenuOptions(menuId: menuId);
    } finally {
      loading.value = false;
    }
  }

  Future<void> onCreate() async {
    final blank = await _repository.createGossipMenuOption(
      menuId: currentMenuId.value,
    );
    _applyToControllers(blank);
    _originalMenuId = blank.menuId;
    _originalOptionId = blank.optionId;
    creating.value = true;
    editing.value = false;
  }

  Future<void> onEdit(int menuId, int optionId) async {
    final existing = await _repository.getGossipMenuOption({
      'MenuID': menuId,
      'OptionID': optionId,
    });
    if (existing == null) return;
    _applyToControllers(existing);
    _originalMenuId = menuId;
    _originalOptionId = optionId;
    creating.value = false;
    editing.value = true;
  }

  Future<void> onSave() async {
    saving.value = true;
    try {
      final model = _collectFromControllers();
      if (creating.value) {
        await _repository.storeGossipMenuOption(model);
      } else {
        await _repository.updateGossipMenuOption({
          'MenuID': _originalMenuId,
          'OptionID': _originalOptionId,
        }, model);
      }
      DialogUtil.instance.success('保存成功');
      creating.value = false;
      editing.value = false;
      await search(currentMenuId.value);
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
  }

  void onCancel() {
    creating.value = false;
    editing.value = false;
  }

  Future<void> onCopy(int menuId, int optionId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作不会复制关联表数据，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await _repository.copyGossipMenuOption({
        'MenuID': menuId,
        'OptionID': optionId,
      });
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await search(currentMenuId.value);
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> onDestroy(int menuId, int optionId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '将永久删除该选项，确认继续？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await _repository.destroyGossipMenuOption({
        'MenuID': menuId,
        'OptionID': optionId,
      });
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await search(currentMenuId.value);
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    menuIdController.dispose();
    optionIdController.dispose();
    optionIconController.dispose();
    optionTextController.dispose();
    optionBroadcastTextIdController.dispose();
    optionTypeController.dispose();
    optionNpcFlagController.dispose();
    boxCodedController.dispose();
    boxMoneyController.dispose();
    boxTextController.dispose();
    boxBroadcastTextIdController.dispose();
    actionMenuIdController.dispose();
    actionPoiIdController.dispose();
    verifiedBuildController.dispose();
  }

  void _applyToControllers(GossipMenuOptionEntity o) {
    menuIdController.text = o.menuId.toString();
    optionIdController.text = o.optionId.toString();
    optionIconController.value = {o.optionIcon};
    optionTextController.text = o.optionText;
    optionBroadcastTextIdController.text = o.optionBroadcastTextId.toString();
    optionTypeController.value = {o.optionType};
    optionNpcFlagController.text = o.optionNpcFlag.toString();
    boxCodedController.text = o.boxCoded.toString();
    boxMoneyController.text = o.boxMoney.toString();
    boxTextController.text = o.boxText;
    boxBroadcastTextIdController.text = o.boxBroadcastTextId.toString();
    actionMenuIdController.text = o.actionMenuId.toString();
    actionPoiIdController.text = o.actionPoiId.toString();
    verifiedBuildController.text = o.verifiedBuild.toString();
  }

  GossipMenuOptionEntity _collectFromControllers() {
    return GossipMenuOptionEntity(
      menuId: int.tryParse(menuIdController.text) ?? 0,
      optionId: int.tryParse(optionIdController.text) ?? 0,
      optionIcon: optionIconController.value.isNotEmpty
          ? optionIconController.value.first
          : 0,
      optionText: optionTextController.text,
      optionBroadcastTextId:
          int.tryParse(optionBroadcastTextIdController.text) ?? 0,
      optionType: optionTypeController.value.isNotEmpty
          ? optionTypeController.value.first
          : 0,
      optionNpcFlag: int.tryParse(optionNpcFlagController.text) ?? 0,
      boxCoded: int.tryParse(boxCodedController.text) ?? 0,
      boxMoney: int.tryParse(boxMoneyController.text) ?? 0,
      boxText: boxTextController.text,
      boxBroadcastTextId: int.tryParse(boxBroadcastTextIdController.text) ?? 0,
      actionMenuId: int.tryParse(actionMenuIdController.text) ?? 0,
      actionPoiId: int.tryParse(actionPoiIdController.text) ?? 0,
      verifiedBuild: int.tryParse(verifiedBuildController.text) ?? 0,
    );
  }
}
