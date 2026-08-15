// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_addon_linked_detail_view_model.dart';

mixin _GameObjectTemplateAddonLinkedDetailViewModelMixin
    on FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectTemplateAddonRepository>();

  final linkKey = signal<int?>(null);

  final editingKey = signal<int?>(null);

  final entity = signal<GameObjectTemplateAddonEntity?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final entryController = registerController(IntFieldController());
  late final factionController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final minGoldController = registerController(IntFieldController());
  late final maxGoldController = registerController(IntFieldController());
  late final artkit0Controller = registerController(IntFieldController());
  late final artkit1Controller = registerController(IntFieldController());
  late final artkit2Controller = registerController(IntFieldController());
  late final artkit3Controller = registerController(IntFieldController());

  void _afterApplyCandidate(
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) {}

  void _applyCandidate(GameObjectTemplateAddonEntity gameObjectTemplateAddon) {
    entryController.init(gameObjectTemplateAddon.entry);
    factionController.init(gameObjectTemplateAddon.faction);
    flagsController.init(gameObjectTemplateAddon.flags);
    minGoldController.init(gameObjectTemplateAddon.minGold);
    maxGoldController.init(gameObjectTemplateAddon.maxGold);
    artkit0Controller.init(gameObjectTemplateAddon.artkit0);
    artkit1Controller.init(gameObjectTemplateAddon.artkit1);
    artkit2Controller.init(gameObjectTemplateAddon.artkit2);
    artkit3Controller.init(gameObjectTemplateAddon.artkit3);
    _afterApplyCandidate(gameObjectTemplateAddon);
  }

  GameObjectTemplateAddonEntity _collectCandidate() {
    return GameObjectTemplateAddonEntity(
      entry: entryController.collect(),
      faction: factionController.collect(),
      flags: flagsController.collect(),
      minGold: minGoldController.collect(),
      maxGold: maxGoldController.collect(),
      artkit0: artkit0Controller.collect(),
      artkit1: artkit1Controller.collect(),
      artkit2: artkit2Controller.collect(),
      artkit3: artkit3Controller.collect(),
    );
  }

  int _refreshToken = 0;
  int _linkToken = 0;

  Future<void> destroy() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final key = editingKey.value;
    if (key == null) return;
    final linkSnapshot = linkKey.value;
    final linkToken = _linkToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyGameObjectTemplateAddon(key);
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      try {
        _logActivity(ActivityActionType.delete, key);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({required int linkKey}) {
    return setLinkKey(linkKey);
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final linkSnapshot = linkKey.value;
    if (linkSnapshot == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final linkToken = _linkToken;
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeGameObjectTemplateAddon(candidate);
      } else {
        await _repository.updateGameObjectTemplateAddon(originalKey, candidate);
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.entry;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(action, originalKey ?? candidate.entry);
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      await _refresh();
    } catch (error) {
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> setLinkKey(int linkKey) async {
    if (this.linkKey.value == linkKey && entity.value != null) return;
    _linkToken++;
    this.linkKey.value = linkKey;
    editingKey.value = null;
    await _refresh();
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, int key) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'gameobject_template_addon',
          actionType: action,
          entityName: key.toString(),
          createdAt: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final linkSnapshot = linkKey.value;
    if (linkSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getGameObjectTemplateAddon(
        linkSnapshot,
      );
      if (token != _refreshToken || isDisposed) return;
      final candidate =
          existing ??
          await _repository.createGameObjectTemplateAddon(linkSnapshot);
      if (token != _refreshToken || isDisposed) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : linkSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken || isDisposed) return;
      errorMessage.value = FoxyExceptions.message(error);
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
    } finally {
      if (token == _refreshToken && !isDisposed) loading.value = false;
    }
  }
}
