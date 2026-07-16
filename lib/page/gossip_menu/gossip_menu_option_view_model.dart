import 'package:foxy/constant/gossip_menu_option_constants.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuOptionViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuOptionRepository>();
  final _localeRepository = GetIt.instance
      .get<GossipMenuOptionLocaleRepository>();

  final currentMenuId = signal(0);
  final options = signal<List<BriefGossipMenuOptionEntity>>([]);
  final editing = signal(false);
  final creating = signal(false);

  late final menuIdController = registerController(IntFieldController());
  late final optionIdController = registerController(IntFieldController());
  late final optionIconController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final optionTextController = registerController(StringFieldController());
  late final optionBroadcastTextIdController = registerController(
    IntFieldController(),
  );
  late final optionTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final optionNpcFlagController = registerController(
    FlagFieldController(),
  );
  late final actionMenuIdController = registerController(IntFieldController());
  late final actionPoiIdController = registerController(IntFieldController());
  late final boxCodedController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final boxMoneyController = registerController(IntFieldController());
  late final boxTextController = registerController(StringFieldController());
  late final boxBroadcastTextIdController = registerController(
    IntFieldController(),
  );
  late final verifiedBuildController = registerController(IntFieldController());
  late final localeOptionTextController = registerController(
    StringFieldController(),
  );
  late final localeBoxTextController = registerController(
    StringFieldController(),
  );

  var _originalMenuId = 0;
  var _originalOptionId = 0;
  var _localeExists = false;

  void cancel() {
    creating.value = false;
    editing.value = false;
  }

  Future<void> copy(int menuId, int optionId) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '确认复制该选项？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      final targetOptionId = await _repository.copyGossipMenuOption(
        menuId,
        optionId,
      );
      if (targetOptionId == null) return;
      await _localeRepository.copyGossipMenuOptionLocales(
        menuId,
        optionId,
        targetOptionId,
      );
      DialogUtil.instance.success('复制成功');
      await search(currentMenuId.value);
    } catch (error) {
      LoggerUtil.instance.e(error.toString());
      DialogUtil.instance.error('复制失败: $error');
    }
  }

  Future<void> create() async {
    try {
      final entity = await _repository.createGossipMenuOption(
        currentMenuId.value,
      );
      _applyToControllers(entity);
      localeOptionTextController.init('');
      localeBoxTextController.init('');
      _localeExists = false;
      _originalMenuId = entity.menuId;
      _originalOptionId = entity.optionId;
      creating.value = true;
      editing.value = false;
    } catch (error) {
      LoggerUtil.instance.e('创建对话菜单选项失败: $error');
      DialogUtil.instance.error('创建对话菜单选项失败: $error');
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
      await _localeRepository.destroyGossipMenuOptionLocales(menuId, optionId);
      await _repository.destroyGossipMenuOption(menuId, optionId);
      DialogUtil.instance.success('删除成功');
      await search(currentMenuId.value);
    } catch (error) {
      LoggerUtil.instance.e(error.toString());
      DialogUtil.instance.error('删除失败: $error');
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(int menuId, int optionId) async {
    try {
      final entity = await _repository.getGossipMenuOption(menuId, optionId);
      if (entity == null) return;
      _applyToControllers(entity);
      final locale = await _localeRepository.getGossipMenuOptionLocale(
        menuId,
        optionId,
        'zhCN',
      );
      _localeExists = locale != null;
      localeOptionTextController.init(locale?.optionText ?? '');
      localeBoxTextController.init(locale?.boxText ?? '');
      _originalMenuId = menuId;
      _originalOptionId = optionId;
      creating.value = false;
      editing.value = true;
    } catch (error) {
      LoggerUtil.instance.e('加载对话菜单选项失败: $error');
      DialogUtil.instance.error('加载对话菜单选项失败: $error');
    }
  }

  Future<void> save() async {
    try {
      final entity = _collectFromControllers();
      _validate(entity);
      if (creating.value) {
        await _repository.storeGossipMenuOption(entity);
      } else {
        await _repository.updateGossipMenuOption(
          _originalMenuId,
          _originalOptionId,
          entity,
        );
      }
      await _saveLocale(entity.menuId, entity.optionId);
      DialogUtil.instance.success('保存成功');
      creating.value = false;
      editing.value = false;
      await search(currentMenuId.value);
    } catch (error) {
      LoggerUtil.instance.e(error.toString());
      DialogUtil.instance.error('保存失败: $error');
    }
  }

  Future<void> search(int menuId) async {
    currentMenuId.value = menuId;
    options.value = await _repository.getBriefGossipMenuOptions(menuId);
  }

  void _applyToControllers(GossipMenuOptionEntity entity) {
    menuIdController.init(entity.menuId);
    optionIdController.init(entity.optionId);
    optionIconController.init(entity.optionIcon);
    optionTextController.init(entity.optionText);
    optionBroadcastTextIdController.init(entity.optionBroadcastTextId);
    optionTypeController.init(entity.optionType);
    optionNpcFlagController.init(entity.optionNpcFlag);
    actionMenuIdController.init(entity.actionMenuId);
    actionPoiIdController.init(entity.actionPoiId);
    boxCodedController.init(entity.boxCoded);
    boxMoneyController.init(entity.boxMoney);
    boxTextController.init(entity.boxText);
    boxBroadcastTextIdController.init(entity.boxBroadcastTextId);
    verifiedBuildController.init(entity.verifiedBuild);
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
      actionMenuId: actionMenuIdController.collect(),
      actionPoiId: actionPoiIdController.collect(),
      boxCoded: boxCodedController.collect(),
      boxMoney: boxMoneyController.collect(),
      boxText: boxTextController.collect(),
      boxBroadcastTextId: boxBroadcastTextIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  Future<void> _saveLocale(int menuId, int optionId) async {
    final optionText = localeOptionTextController.collect();
    final boxText = localeBoxTextController.collect();
    if (optionText.isNotEmpty || boxText.isNotEmpty) {
      await _localeRepository.saveGossipMenuOptionLocale(
        GossipMenuOptionLocaleEntity(
          menuId: menuId,
          optionId: optionId,
          optionText: optionText,
          boxText: boxText,
        ),
      );
      _localeExists = true;
    } else if (_localeExists) {
      await _localeRepository.destroyGossipMenuOptionLocale(
        menuId,
        optionId,
        'zhCN',
      );
      _localeExists = false;
    }
  }

  void _validate(GossipMenuOptionEntity entity) {
    if (entity.menuId <= 0) throw StateError('MenuID 必须大于 0');
    if (entity.optionId < 0 || entity.optionId >= 32) {
      throw StateError('OptionID 必须在 0 到 31 之间');
    }
    if (!kGossipOptionIcons.containsKey(entity.optionIcon)) {
      throw StateError('OptionIcon 不是 AzerothCore 支持的值');
    }
    if (!kGossipOptionTypes.containsKey(entity.optionType)) {
      throw StateError('OptionType 不是 AzerothCore 支持的值');
    }
    if (!kGossipBooleanOptions.containsKey(entity.boxCoded)) {
      throw StateError('BoxCoded 只能为 0 或 1');
    }
    if (entity.optionNpcFlag < 0 ||
        entity.actionMenuId < 0 ||
        entity.actionPoiId < 0 ||
        entity.boxMoney < 0) {
      throw StateError('无符号字段不能为负数');
    }
  }
}
