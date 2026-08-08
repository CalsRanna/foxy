// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_detail_view_model.dart';

mixin _GossipMenuDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<GossipMenuRepository>();

  final entity = signal<GossipMenuEntity?>(null);

  final persistedKey = signal<GossipMenuKey?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final menuIdController = registerController(IntFieldController());
  late final textIdController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({GossipMenuKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createGossipMenu();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGossipMenu(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final _ = await _repository.storeGossipMenu(candidate);
        persistedKey.value = GossipMenuKey.fromEntity(candidate);
      } else {
        await _repository.updateGossipMenu(originalKey, candidate);
        persistedKey.value = GossipMenuKey.fromEntity(candidate);
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(GossipMenuEntity gossipMenu) {}

  void _applyCandidate(GossipMenuEntity gossipMenu) {
    menuIdController.init(gossipMenu.menuId);
    textIdController.init(gossipMenu.textId);
    _afterApplyCandidate(gossipMenu);
  }

  GossipMenuEntity _collectCandidate() {
    return GossipMenuEntity(
      menuId: menuIdController.collect(),
      textId: textIdController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, GossipMenuEntity gossipMenu) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'gossip_menu',
          actionType: action,
          entityName: 'GossipMenu',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
