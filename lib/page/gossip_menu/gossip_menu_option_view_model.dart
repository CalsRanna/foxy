import 'package:flutter/widgets.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

/// Tab 3 (gossip_menu_option) ViewModel
class GossipMenuOptionViewModel {
  final _repository = GetIt.instance.get<GossipMenuOptionRepository>();

  final currentMenuId = signal(0);
  final options = signal<List<GossipMenuOptionEntity>>([]);
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

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> search(int menuId) async {
    currentMenuId.value = menuId;
    options.value = await _repository.getBriefGossipMenuOptions(menuId);
  }

  Future<void> create() async {
    try {
      final blank = await _repository.createGossipMenuOption(
        currentMenuId.value,
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

  Future<void> edit(int menuId, int optionId) async {
    try {
      final existing = await _repository.getGossipMenuOption(menuId, optionId);
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

  Future<void> save() async {
    try {
      final model = _collectFromControllers();
      if (creating.value) {
        await _repository.storeGossipMenuOption(model);
      } else {
        await _repository.updateGossipMenuOption(
          _originalMenuId,
          _originalOptionId,
          model,
        );
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

  void cancel() {
    creating.value = false;
    editing.value = false;
  }

  Future<void> copy(int menuId, int optionId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '此操作不会复制关联表数据，确认继续？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyGossipMenuOption(menuId, optionId);
      DialogUtil.instance.success('复制成功');
      await search(currentMenuId.value);
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> delete(int menuId, int optionId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '将永久删除该选项，确认继续？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyGossipMenuOption(menuId, optionId);
      DialogUtil.instance.success('删除成功');
      await search(currentMenuId.value);
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    actionMenuIdController.dispose();
    actionPoiIdController.dispose();
    boxBroadcastTextIdController.dispose();
    boxCodedController.dispose();
    boxMoneyController.dispose();
    boxTextController.dispose();
    menuIdController.dispose();
    optionBroadcastTextIdController.dispose();
    optionIconController.dispose();
    optionIdController.dispose();
    optionTextController.dispose();
    optionTypeController.dispose();
    optionNpcFlagController.dispose();
    verifiedBuildController.dispose();
  }

  void _applyToControllers(GossipMenuOptionEntity o) {
    menuIdController.text = o.menuId.toString();
    optionIdController.text = o.optionId.toString();
    optionIconController.value = {o.optionIcon};
    optionTextController.text = o.optionText;
    optionBroadcastTextIdController.text = _fmt(o.optionBroadcastTextId);
    optionTypeController.value = {o.optionType};
    optionNpcFlagController.text = FlagFieldController.formatFlagValue(
      o.optionNpcFlag,
    );
    boxCodedController.text = o.boxCoded.toString();
    boxMoneyController.text = o.boxMoney.toString();
    boxTextController.text = o.boxText;
    boxBroadcastTextIdController.text = _fmt(o.boxBroadcastTextId);
    actionMenuIdController.text = _fmt(o.actionMenuId);
    actionPoiIdController.text = o.actionPoiId.toString();
    verifiedBuildController.text = o.verifiedBuild.toString();
  }

  GossipMenuOptionEntity _collectFromControllers() {
    return GossipMenuOptionEntity(
      menuId: _pi(menuIdController.text, 'MenuID'),
      optionId: _pi(optionIdController.text, 'OptionID'),
      optionIcon: optionIconController.value.isNotEmpty
          ? optionIconController.value.first
          : 0,
      optionText: optionTextController.text,
      optionBroadcastTextId: _pi(
        optionBroadcastTextIdController.text,
        'OptionBroadcastTextID',
      ),
      optionType: optionTypeController.value.isNotEmpty
          ? optionTypeController.value.first
          : 0,
      optionNpcFlag: FlagFieldController.parseFlagValue(
        optionNpcFlagController.text,
      ),
      boxCoded: _pi(boxCodedController.text, 'BoxCoded'),
      boxMoney: _pi(boxMoneyController.text, 'BoxMoney'),
      boxText: boxTextController.text,
      boxBroadcastTextId: _pi(
        boxBroadcastTextIdController.text,
        'BoxBroadcastTextID',
      ),
      actionMenuId: _pi(actionMenuIdController.text, 'ActionMenuID'),
      actionPoiId: _pi(actionPoiIdController.text, 'ActionPoiID'),
      verifiedBuild: _pi(verifiedBuildController.text, 'VerifiedBuild'),
    );
  }
}
