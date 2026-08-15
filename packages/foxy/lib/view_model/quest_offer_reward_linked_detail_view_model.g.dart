// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_offer_reward_linked_detail_view_model.dart';

mixin _QuestOfferRewardLinkedDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestOfferRewardRepository>();

  final linkKey = signal<int?>(null);

  final editingKey = signal<int?>(null);

  final entity = signal<QuestOfferRewardEntity?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final emote1Controller = registerController(IntFieldController());
  late final emote2Controller = registerController(IntFieldController());
  late final emote3Controller = registerController(IntFieldController());
  late final emote4Controller = registerController(IntFieldController());
  late final emoteDelay1Controller = registerController(IntFieldController());
  late final emoteDelay2Controller = registerController(IntFieldController());
  late final emoteDelay3Controller = registerController(IntFieldController());
  late final emoteDelay4Controller = registerController(IntFieldController());
  late final rewardTextController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(QuestOfferRewardEntity questOfferReward) {}

  void _applyCandidate(QuestOfferRewardEntity questOfferReward) {
    idController.init(questOfferReward.id);
    emote1Controller.init(questOfferReward.emote1);
    emote2Controller.init(questOfferReward.emote2);
    emote3Controller.init(questOfferReward.emote3);
    emote4Controller.init(questOfferReward.emote4);
    emoteDelay1Controller.init(questOfferReward.emoteDelay1);
    emoteDelay2Controller.init(questOfferReward.emoteDelay2);
    emoteDelay3Controller.init(questOfferReward.emoteDelay3);
    emoteDelay4Controller.init(questOfferReward.emoteDelay4);
    rewardTextController.init(questOfferReward.rewardText);
    verifiedBuildController.init(questOfferReward.verifiedBuild);
    _afterApplyCandidate(questOfferReward);
  }

  QuestOfferRewardEntity _collectCandidate() {
    return QuestOfferRewardEntity(
      id: idController.collect(),
      emote1: emote1Controller.collect(),
      emote2: emote2Controller.collect(),
      emote3: emote3Controller.collect(),
      emote4: emote4Controller.collect(),
      emoteDelay1: emoteDelay1Controller.collect(),
      emoteDelay2: emoteDelay2Controller.collect(),
      emoteDelay3: emoteDelay3Controller.collect(),
      emoteDelay4: emoteDelay4Controller.collect(),
      rewardText: rewardTextController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
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
      await _repository.destroyQuestOfferReward(key);
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
        await _repository.storeQuestOfferReward(candidate);
      } else {
        await _repository.updateQuestOfferReward(originalKey, candidate);
      }
      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.id;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      try {
        _logActivity(action, originalKey ?? candidate.id);
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
          module: 'quest_offer_reward',
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
      final existing = await _repository.getQuestOfferReward(linkSnapshot);
      if (token != _refreshToken || isDisposed) return;
      final candidate =
          existing ?? await _repository.createQuestOfferReward(linkSnapshot);
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
