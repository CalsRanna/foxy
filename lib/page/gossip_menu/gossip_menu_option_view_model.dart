import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

/// Tab 3 (gossip_menu_option) ViewModel
class GossipMenuOptionViewModel {
  final _repository = GetIt.instance.get<GossipMenuOptionRepository>();

  final currentMenuId = signal(0);
  final options = signal<List<GossipMenuOptionEntity>>([]);
  final editing = signal(false);
  final creating = signal(false);

  final menuIdController = IntFieldController();
  final optionIdController = IntFieldController();
  final optionIconController = SelectFieldController<int>(fallback: 0);
  final optionTextController = StringFieldController();
  final optionBroadcastTextIdController = IntFieldController();
  final optionTypeController = SelectFieldController<int>(fallback: 0);
  final optionNpcFlagController = FlagFieldController();
  final boxCodedController = IntFieldController();
  final boxMoneyController = IntFieldController();
  final boxTextController = StringFieldController();
  final boxBroadcastTextIdController = IntFieldController();
  final actionMenuIdController = IntFieldController();
  final actionPoiIdController = IntFieldController();
  final verifiedBuildController = IntFieldController();

  late final _controllers = <FieldController>[
    menuIdController,
    optionIdController,
    optionIconController,
    optionTextController,
    optionBroadcastTextIdController,
    optionTypeController,
    optionNpcFlagController,
    boxCodedController,
    boxMoneyController,
    boxTextController,
    boxBroadcastTextIdController,
    actionMenuIdController,
    actionPoiIdController,
    verifiedBuildController,
  ];

  int _originalMenuId = 0;
  int _originalOptionId = 0;

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
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  void _applyToControllers(GossipMenuOptionEntity o) {
    menuIdController.init(o.menuId);
    optionIdController.init(o.optionId);
    optionIconController.init(o.optionIcon);
    optionTextController.init(o.optionText);
    optionBroadcastTextIdController.init(o.optionBroadcastTextId);
    optionTypeController.init(o.optionType);
    optionNpcFlagController.init(o.optionNpcFlag);
    boxCodedController.init(o.boxCoded);
    boxMoneyController.init(o.boxMoney);
    boxTextController.init(o.boxText);
    boxBroadcastTextIdController.init(o.boxBroadcastTextId);
    actionMenuIdController.init(o.actionMenuId);
    actionPoiIdController.init(o.actionPoiId);
    verifiedBuildController.init(o.verifiedBuild);
  }

  GossipMenuOptionEntity _collectFromControllers() {
    return GossipMenuOptionEntity(
      menuId: menuIdController.collect(),
      optionId: optionIdController.collect(),
      optionIcon: optionIconController.collect(),
      optionText: optionTextController.collect(),
      optionBroadcastTextId: optionBroadcastTextIdController.collect(),
      optionType: optionTypeController.collect(),
      optionNpcFlag: optionNpcFlagController.collect(),
      boxCoded: boxCodedController.collect(),
      boxMoney: boxMoneyController.collect(),
      boxText: boxTextController.collect(),
      boxBroadcastTextId: boxBroadcastTextIdController.collect(),
      actionMenuId: actionMenuIdController.collect(),
      actionPoiId: actionPoiIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }
}
