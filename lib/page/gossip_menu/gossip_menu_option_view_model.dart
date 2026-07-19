import 'dart:math';

import 'package:foxy/entity/brief_gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_key.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/gossip_menu_option_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuOptionViewModel
    with
        ViewModelValidationMixin,
        GossipMenuOptionValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuOptionRepository>();
  final _localeRepository = GetIt.instance
      .get<GossipMenuOptionLocaleRepository>();

  final currentMenuId = signal(0);
  final editingKey = signal<GossipMenuOptionKey?>(null);
  final formVisible = signal(false);
  final localeEditingKey = signal<GossipMenuOptionLocaleKey?>(null);
  final options = signal<List<BriefGossipMenuOptionEntity>>([]);
  final page = signal(1);
  final total = signal(0);

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

  int _refreshToken = 0;

  void cancel() => _clearEditingState();

  GossipMenuOptionEntity collectFromForm() {
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

  Future<void> copy(BriefGossipMenuOptionEntity option) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '确认复制该选项？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      final targetKey = await _repository.copyGossipMenuOption(option.key);
      await _localeRepository.copyGossipMenuOptionLocales(
        option.key,
        targetKey,
      );
      DialogUtil.instance.success('复制成功');
      await _refresh();
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
      _clearEditingState();
      _applyToControllers(entity);
      localeOptionTextController.init('');
      localeBoxTextController.init('');
      formVisible.value = true;
    } catch (error) {
      LoggerUtil.instance.e('创建对话菜单选项失败: $error');
      DialogUtil.instance.error('创建对话菜单选项失败: $error');
    }
  }

  Future<void> delete(BriefGossipMenuOptionEntity option) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '将永久删除该选项，确认继续？',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyGossipMenuOption(option.key);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (error) {
      LoggerUtil.instance.e(error.toString());
      DialogUtil.instance.error('删除失败: $error');
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(BriefGossipMenuOptionEntity option) async {
    final key = option.key;
    editingKey.value = key;
    try {
      final entity = await _repository.getGossipMenuOption(key);
      if (entity == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _applyToControllers(entity);
      final localeKey = GossipMenuOptionLocaleKey(
        menuId: key.menuId,
        optionId: key.optionId,
        locale: 'zhCN',
      );
      final locale = await _localeRepository.getGossipMenuOptionLocale(
        localeKey,
      );
      localeEditingKey.value = locale == null ? null : localeKey;
      localeOptionTextController.init(locale?.optionText ?? '');
      localeBoxTextController.init(locale?.boxText ?? '');
      formVisible.value = true;
    } catch (error) {
      _clearEditingState();
      LoggerUtil.instance.e('加载对话菜单选项失败: $error');
      DialogUtil.instance.error('加载对话菜单选项失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = collectFromForm();
    validateGossipMenuOptionFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storeGossipMenuOption(candidate);
    } else {
      await _repository.updateGossipMenuOption(originalKey, candidate);
    }

    final candidateKey = GossipMenuOptionKey.fromEntity(candidate);
    editingKey.value = candidateKey;
    await _persistLocale(candidateKey);
    await _refresh();
  }

  Future<void> save() async {
    try {
      await persist();
      DialogUtil.instance.success('保存成功');
    } catch (error) {
      LoggerUtil.instance.e(error.toString());
      DialogUtil.instance.error('保存失败: $error');
    }
  }

  Future<void> search(int menuId) => setParentMenuId(menuId);

  Future<void> setParentMenuId(int menuId) async {
    if (currentMenuId.value != menuId) page.value = 1;
    currentMenuId.value = menuId;
    _clearEditingState();
    await _refresh();
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

  void _clearEditingState() {
    editingKey.value = null;
    localeEditingKey.value = null;
    formVisible.value = false;
  }

  Future<void> _persistLocale(GossipMenuOptionKey candidateKey) async {
    final optionText = localeOptionTextController.collect();
    final boxText = localeBoxTextController.collect();
    final originalLocaleKey = localeEditingKey.value;
    if (optionText.isEmpty && boxText.isEmpty) {
      if (originalLocaleKey != null) {
        await _localeRepository.destroyGossipMenuOptionLocale(
          originalLocaleKey,
        );
        localeEditingKey.value = null;
      }
      return;
    }

    final candidate = GossipMenuOptionLocaleEntity(
      menuId: candidateKey.menuId,
      optionId: candidateKey.optionId,
      locale: 'zhCN',
      optionText: optionText,
      boxText: boxText,
    );
    if (originalLocaleKey == null) {
      await _localeRepository.storeGossipMenuOptionLocale(candidate);
    } else {
      await _localeRepository.updateGossipMenuOptionLocale(
        originalLocaleKey,
        candidate,
      );
    }
    localeEditingKey.value = GossipMenuOptionLocaleKey.fromEntity(candidate);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentMenuId = currentMenuId.value;
    final count = await _repository.countGossipMenuOptions(parentMenuId);
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefGossipMenuOptions(
      parentMenuId,
      page: page.value,
    );
    if (token != _refreshToken) return;
    options.value = data;
    total.value = count;
    _clearEditingState();
  }
}
