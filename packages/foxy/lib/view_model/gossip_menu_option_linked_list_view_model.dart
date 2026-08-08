import 'dart:math';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/use_case/gossip_menu/destroy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_gossip_menu_option_use_case.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GossipMenuOptionLinkedListViewModel with FieldControllerMixin {
  void _logActivity(ActivityActionType action, GossipMenuOptionKey key) {
    final log = ActivityLogEntity(
      module: 'gossip_menu_option',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }

  final _repository = GetIt.instance.get<GossipMenuOptionRepository>();
  final _saveUseCase = GetIt.instance.get<SaveGossipMenuOptionUseCase>();
  final _destroyUseCase = GetIt.instance.get<DestroyGossipMenuOptionUseCase>();

  final linkKey = signal<int?>(null);
  final items = signal<List<BriefGossipMenuOptionEntity>>([]);
  final editingKey = signal<GossipMenuOptionKey?>(null);
  final selectedKey = signal<GossipMenuOptionKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

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

  int _refreshToken = 0;
  int _interactionToken = 0;

  void cancel() => _clearEditingState();

  Future<void> copy(GossipMenuOptionKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyGossipMenuOption(key);
      if (token != _interactionToken || linkKey.value != link) return;
      try {
        _logActivity(ActivityActionType.copy, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> create() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createGossipMenuOption(link);
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
      formVisible.value = true;
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    }
  }

  Future<void> destroy(GossipMenuOptionKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _destroyUseCase.execute(key);
      if (token != _interactionToken || linkKey.value != link) return;
      try {
        _logActivity(ActivityActionType.delete, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() => disposeControllers();

  Future<void> edit(GossipMenuOptionKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getGossipMenuOption(key);
      if (token != _interactionToken || linkKey.value != link) return;
      if (candidate == null) {
        throw RecordNotFoundException('record not found');
      }
      _applyCandidate(candidate);
      formVisible.value = true;
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      _clearEditingState();
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> initSignals({required int linkKey}) => setLinkKey(linkKey);

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _saveUseCase.execute(
        SaveGossipMenuOptionInput(
          originalKey: originalKey,
          candidate: candidate,
          originalLocaleKey: null,
          localeCandidate: null,
        ),
      );
      if (token != _interactionToken || linkKey.value != link) return;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(
          action,
          originalKey ?? GossipMenuOptionKey.fromEntity(candidate),
        );
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(int linkKey) async {
    _interactionToken++;
    if (this.linkKey.value != linkKey) page.value = 1;
    this.linkKey.value = linkKey;
    _clearEditingState();
    _applyCandidate(GossipMenuOptionEntity(menuId: linkKey));
    await _refresh();
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

  void _clearEditingState() {
    editingKey.value = null;
    selectedKey.value = null;
    formVisible.value = false;
  }

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

  Future<void> _refresh() async {
    final link = linkKey.value;
    if (link == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countGossipMenuOptions(link);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefGossipMenuOptions(
        link,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      _clearEditingState();
    } catch (error) {
      if (token == _refreshToken) {
        errorMessage.value = foxyErrorMessage(error);
        LoggerUtil.instance.e('刷新子表列表失败: $error');
      }
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
