import 'dart:math';

import 'package:foxy/entity/brief_gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_key.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/use_case/gossip_menu/copy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/destroy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_gossip_menu_option_use_case.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/gossip_menu_option_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuOptionCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        GossipMenuOptionValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuOptionRepository>();
  final _localeRepository = GetIt.instance
      .get<GossipMenuOptionLocaleRepository>();
  final _saveUseCase = GetIt.instance.get<SaveGossipMenuOptionUseCase>();
  final _copyUseCase = GetIt.instance.get<CopyGossipMenuOptionUseCase>();
  final _destroyUseCase = GetIt.instance.get<DestroyGossipMenuOptionUseCase>();

  final parentKey = signal<int?>(null);
  final items = signal<List<BriefGossipMenuOptionEntity>>([]);
  final editingKey = signal<GossipMenuOptionKey?>(null);
  final selectedKey = signal<GossipMenuOptionKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  final localeEditingKey = signal<GossipMenuOptionLocaleKey?>(null);
  final formVisible = signal(false);

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
  int _interactionToken = 0;

  Future<void> initSignals({required int parentKey}) => setParentKey(parentKey);

  Future<void> setParentKey(int parentKey) async {
    _interactionToken++;
    if (this.parentKey.value != parentKey) page.value = 1;
    this.parentKey.value = parentKey;
    _clearEditingState();
    _applyCandidate(GossipMenuOptionEntity(menuId: parentKey));
    _applyLocaleCandidate(null);
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createGossipMenuOption(parent);
      if (token != _interactionToken || parentKey.value != parent) return;
      editingKey.value = null;
      selectedKey.value = null;
      localeEditingKey.value = null;
      _applyCandidate(candidate);
      _applyLocaleCandidate(null);
      formVisible.value = true;
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    }
  }

  Future<void> edit(GossipMenuOptionKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getGossipMenuOption(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      final localeKey = GossipMenuOptionLocaleKey(
        menuId: key.menuId,
        optionId: key.optionId,
        locale: 'zhCN',
      );
      final locale = await _localeRepository.getGossipMenuOptionLocale(
        localeKey,
      );
      if (token != _interactionToken || parentKey.value != parent) return;
      _applyCandidate(candidate);
      _applyLocaleCandidate(locale);
      localeEditingKey.value = locale == null ? null : localeKey;
      formVisible.value = true;
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      _clearEditingState();
      errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final candidate = _collectCandidate();
    validateGossipMenuOptionFields(candidate);
    final originalKey = editingKey.value;
    final originalLocaleKey = localeEditingKey.value;
    final localeCandidate = _collectLocaleCandidate(
      GossipMenuOptionKey.fromEntity(candidate),
    );
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _saveUseCase.execute(
        SaveGossipMenuOptionInput(
          originalKey: originalKey,
          candidate: candidate,
          originalLocaleKey: originalLocaleKey,
          localeCandidate: localeCandidate,
        ),
      );
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(GossipMenuOptionKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _destroyUseCase.execute(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> copy(GossipMenuOptionKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _copyUseCase.execute(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  void cancel() => _clearEditingState();

  GossipMenuOptionEntity _collectCandidate() {
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

  GossipMenuOptionLocaleEntity? _collectLocaleCandidate(
    GossipMenuOptionKey candidateKey,
  ) {
    final optionText = localeOptionTextController.collect();
    final boxText = localeBoxTextController.collect();
    if (optionText.isEmpty && boxText.isEmpty) return null;
    return GossipMenuOptionLocaleEntity(
      menuId: candidateKey.menuId,
      optionId: candidateKey.optionId,
      locale: 'zhCN',
      optionText: optionText,
      boxText: boxText,
    );
  }

  void _applyCandidate(GossipMenuOptionEntity candidate) {
    menuIdController.init(candidate.menuId);
    optionIdController.init(candidate.optionId);
    optionIconController.init(candidate.optionIcon);
    optionTextController.init(candidate.optionText);
    optionBroadcastTextIdController.init(candidate.optionBroadcastTextId);
    optionTypeController.init(candidate.optionType);
    optionNpcFlagController.init(candidate.optionNpcFlag);
    actionMenuIdController.init(candidate.actionMenuId);
    actionPoiIdController.init(candidate.actionPoiId);
    boxCodedController.init(candidate.boxCoded);
    boxMoneyController.init(candidate.boxMoney);
    boxTextController.init(candidate.boxText);
    boxBroadcastTextIdController.init(candidate.boxBroadcastTextId);
    verifiedBuildController.init(candidate.verifiedBuild);
  }

  void _applyLocaleCandidate(GossipMenuOptionLocaleEntity? candidate) {
    localeOptionTextController.init(candidate?.optionText ?? '');
    localeBoxTextController.init(candidate?.boxText ?? '');
  }

  void _clearEditingState() {
    editingKey.value = null;
    selectedKey.value = null;
    localeEditingKey.value = null;
    formVisible.value = false;
  }

  Future<void> _refresh() async {
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countGossipMenuOptions(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefGossipMenuOptions(
        parent,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      _clearEditingState();
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() => disposeControllers();
}
