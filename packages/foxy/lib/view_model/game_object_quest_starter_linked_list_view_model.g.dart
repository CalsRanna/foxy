// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_starter_linked_list_view_model.dart';

mixin _GameObjectQuestStarterLinkedListViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<GameObjectQuestStarterRepository>();

  final linkKey = signal<int?>(null);

  final items = signal(<BriefGameObjectQuestStarterEntity>[]);

  final editingKey = signal<GameObjectQuestStarterKey?>(null);

  final selectedKey = signal<GameObjectQuestStarterKey?>(null);

  final page = signal(1);

  final total = signal(0);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  void _afterApplyCandidate(
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) {}

  void _applyCandidate(GameObjectQuestStarterEntity gameObjectQuestStarter) {
    idController.init(gameObjectQuestStarter.id);
    questController.init(gameObjectQuestStarter.quest);
    _afterApplyCandidate(gameObjectQuestStarter);
  }

  GameObjectQuestStarterEntity _collectCandidate() {
    return GameObjectQuestStarterEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> copy(GameObjectQuestStarterKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.copyGameObjectQuestStarter(key);
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
      final candidate = await _repository.createGameObjectQuestStarter(link);
      if (token != _interactionToken || linkKey.value != link) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    }
  }

  Future<void> destroy(GameObjectQuestStarterKey key) async {
    if (submitting.value) throw BusyException('operation already in progress');
    final link = linkKey.value;
    if (link == null) {
      throw LinkNotLoadedException('link record not loaded');
    }
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyGameObjectQuestStarter(key);
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

  Future<void> edit(GameObjectQuestStarterKey key) async {
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
      final candidate = await _repository.getGameObjectQuestStarter(key);
      if (token != _interactionToken || linkKey.value != link) return;
      if (candidate == null) {
        throw RecordNotFoundException('record not found');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || linkKey.value != link) {
        return;
      }
      editingKey.value = null;
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
      if (originalKey == null) {
        await _repository.storeGameObjectQuestStarter(candidate);
      } else {
        await _repository.updateGameObjectQuestStarter(originalKey, candidate);
      }
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(
          action,
          originalKey ?? GameObjectQuestStarterKey.fromEntity(candidate),
        );
      } catch (_) {
        // Activity log is best-effort; failure (e.g. not registered in
        // tests) must not affect the main flow.
      }
      if (token != _interactionToken || linkKey.value != link) return;
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
    final link = linkKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(GameObjectQuestStarterEntity(quest: link));
    await _refresh();
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, GameObjectQuestStarterKey key) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'gameobject_queststarter',
          actionType: action,
          entityName: key.toString(),
          createdAt: DateTime.now(),
        ),
      ),
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
      final count = await _repository.countGameObjectQuestStarters(link);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefGameObjectQuestStarters(
        link,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
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
