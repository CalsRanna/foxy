// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_on_kill_reputation_linked_detail_view_model.dart';

mixin _CreatureOnKillReputationLinkedDetailViewModelMixin
    on FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureOnKillReputationRepository>();

  final linkKey = signal<int?>(null);

  final editingKey = signal<int?>(null);

  final entity = signal<CreatureOnKillReputationEntity?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final creatureIDController = registerController(IntFieldController());
  late final rewOnKillRepFaction1Controller = registerController(
    IntFieldController(),
  );
  late final rewOnKillRepFaction2Controller = registerController(
    IntFieldController(),
  );
  late final maxStanding1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final maxStanding2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward1Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final isTeamAward2Controller = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rewOnKillRepValue1Controller = registerController(
    DoubleFieldController(),
  );
  late final rewOnKillRepValue2Controller = registerController(
    DoubleFieldController(),
  );
  late final teamDependentController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  void _afterApplyCandidate(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) {}

  void _applyCandidate(
    CreatureOnKillReputationEntity creatureOnKillReputation,
  ) {
    creatureIDController.init(creatureOnKillReputation.creatureID);
    rewOnKillRepFaction1Controller.init(
      creatureOnKillReputation.rewOnKillRepFaction1,
    );
    rewOnKillRepFaction2Controller.init(
      creatureOnKillReputation.rewOnKillRepFaction2,
    );
    maxStanding1Controller.init(creatureOnKillReputation.maxStanding1);
    maxStanding2Controller.init(creatureOnKillReputation.maxStanding2);
    isTeamAward1Controller.init(creatureOnKillReputation.isTeamAward1 ? 1 : 0);
    isTeamAward2Controller.init(creatureOnKillReputation.isTeamAward2 ? 1 : 0);
    rewOnKillRepValue1Controller.init(
      creatureOnKillReputation.rewOnKillRepValue1,
    );
    rewOnKillRepValue2Controller.init(
      creatureOnKillReputation.rewOnKillRepValue2,
    );
    teamDependentController.init(creatureOnKillReputation.teamDependent);
    _afterApplyCandidate(creatureOnKillReputation);
  }

  CreatureOnKillReputationEntity _collectCandidate() {
    return CreatureOnKillReputationEntity(
      creatureID: creatureIDController.collect(),
      rewOnKillRepFaction1: rewOnKillRepFaction1Controller.collect(),
      rewOnKillRepFaction2: rewOnKillRepFaction2Controller.collect(),
      maxStanding1: maxStanding1Controller.collect(),
      maxStanding2: maxStanding2Controller.collect(),
      isTeamAward1: isTeamAward1Controller.collect() == 1,
      isTeamAward2: isTeamAward2Controller.collect() == 1,
      rewOnKillRepValue1: rewOnKillRepValue1Controller.collect(),
      rewOnKillRepValue2: rewOnKillRepValue2Controller.collect(),
      teamDependent: teamDependentController.collect(),
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
      await _repository.destroyCreatureOnKillReputation(key);
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
        await _repository.storeCreatureOnKillReputation(candidate);
      } else {
        await _repository.updateCreatureOnKillReputation(
          originalKey,
          candidate,
        );
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.creatureID;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(action, originalKey ?? candidate.creatureID);
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
          module: 'creature_onkill_reputation',
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
      final existing = await _repository.getCreatureOnKillReputation(
        linkSnapshot,
      );
      if (token != _refreshToken || isDisposed) return;
      final candidate =
          existing ??
          await _repository.createCreatureOnKillReputation(linkSnapshot);
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
