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
  final editing = signal(false);
  final creating = signal(false);

  /// 表单 controllers
  final menuIdController = TextEditingController();
  final optionIdController = TextEditingController();
  final optionIconController = ShadSelectController<int>();
  final optionTextController = TextEditingController();
  final optionBroadcastTextId = signal<int>(0);
  final optionTypeController = ShadSelectController<int>();
  final optionNpcFlag = signal<int>(0);
  final boxCodedController = TextEditingController();
  final boxMoneyController = TextEditingController();
  final boxTextController = TextEditingController();
  final boxBroadcastTextId = signal<int>(0);
  final actionMenuId = signal<int>(0);
  final actionPoiIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  int _originalMenuId = 0;
  int _originalOptionId = 0;

  Future<void> search(int menuId) async {
    currentMenuId.value = menuId;
    options.value = await _repository.getGossipMenuOptions(menuId: menuId);
  }

  Future<void> onCreate() async {
    try {
      final blank = await _repository.createGossipMenuOption(
        menuId: currentMenuId.value,
      );
      _applyToControllers(blank);
      _originalMenuId = blank.menuId;
      _originalOptionId = blank.optionId;
      creating.value = true;
      editing.value = false;
    } catch (e) {
      LoggerUtil.instance.e('创建对话菜单选项失败: $e');
      DialogUtil.instance.error('创建对话菜单选项失败: $e');
    }
  }

  Future<void> onEdit(int menuId, int optionId) async {
    try {
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
    } catch (e) {
      LoggerUtil.instance.e('加载对话菜单选项编辑失败: $e');
      DialogUtil.instance.error('加载对话菜单选项编辑失败: $e');
    }
  }

  Future<void> onSave() async {
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
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
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
      await _repository.copyGossipMenuOption({
        'MenuID': menuId,
        'OptionID': optionId,
      });
      DialogUtil.instance.success('复制成功');
      await search(currentMenuId.value);
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
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
      await _repository.destroyGossipMenuOption({
        'MenuID': menuId,
        'OptionID': optionId,
      });
      DialogUtil.instance.success('删除成功');
      await search(currentMenuId.value);
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    menuIdController.dispose();
    optionIdController.dispose();
    optionIconController.dispose();
    optionTextController.dispose();
    optionTypeController.dispose();
    boxCodedController.dispose();
    boxMoneyController.dispose();
    boxTextController.dispose();
    actionPoiIdController.dispose();
    verifiedBuildController.dispose();
  }

  void _applyToControllers(GossipMenuOptionEntity o) {
    menuIdController.text = o.menuId.toString();
    optionIdController.text = o.optionId.toString();
    optionIconController.value = {o.optionIcon};
    optionTextController.text = o.optionText;
    optionBroadcastTextId.value = o.optionBroadcastTextId;
    optionTypeController.value = {o.optionType};
    optionNpcFlag.value = o.optionNpcFlag;
    boxCodedController.text = o.boxCoded.toString();
    boxMoneyController.text = o.boxMoney.toString();
    boxTextController.text = o.boxText;
    boxBroadcastTextId.value = o.boxBroadcastTextId;
    actionMenuId.value = o.actionMenuId;
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
      optionBroadcastTextId: optionBroadcastTextId.value,
      optionType: optionTypeController.value.isNotEmpty
          ? optionTypeController.value.first
          : 0,
      optionNpcFlag: optionNpcFlag.value,
      boxCoded: int.tryParse(boxCodedController.text) ?? 0,
      boxMoney: int.tryParse(boxMoneyController.text) ?? 0,
      boxText: boxTextController.text,
      boxBroadcastTextId: boxBroadcastTextId.value,
      actionMenuId: actionMenuId.value,
      actionPoiId: int.tryParse(actionPoiIdController.text) ?? 0,
      verifiedBuild: int.tryParse(verifiedBuildController.text) ?? 0,
    );
  }
}
