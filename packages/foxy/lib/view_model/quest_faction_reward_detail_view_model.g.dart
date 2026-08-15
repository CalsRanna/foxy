// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_faction_reward_detail_view_model.dart';

mixin _QuestFactionRewardDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestFactionRewardRepository>();

  final entity = signal<QuestFactionRewardEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final difficulty0Controller = registerController(IntFieldController());
  late final difficulty1Controller = registerController(IntFieldController());
  late final difficulty2Controller = registerController(IntFieldController());
  late final difficulty3Controller = registerController(IntFieldController());
  late final difficulty4Controller = registerController(IntFieldController());
  late final difficulty5Controller = registerController(IntFieldController());
  late final difficulty6Controller = registerController(IntFieldController());
  late final difficulty7Controller = registerController(IntFieldController());
  late final difficulty8Controller = registerController(IntFieldController());
  late final difficulty9Controller = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createQuestFactionReward();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getQuestFactionReward(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyExceptions.message(error);
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
        final storedKey = await _repository.storeQuestFactionReward(candidate);
        persistedKey.value = storedKey;
      } else {
        await _repository.updateQuestFactionReward(originalKey, candidate);
        persistedKey.value = candidate.id;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(QuestFactionRewardEntity questFactionReward) {}

  void _applyCandidate(QuestFactionRewardEntity questFactionReward) {
    idController.init(questFactionReward.id);
    difficulty0Controller.init(questFactionReward.difficulty0);
    difficulty1Controller.init(questFactionReward.difficulty1);
    difficulty2Controller.init(questFactionReward.difficulty2);
    difficulty3Controller.init(questFactionReward.difficulty3);
    difficulty4Controller.init(questFactionReward.difficulty4);
    difficulty5Controller.init(questFactionReward.difficulty5);
    difficulty6Controller.init(questFactionReward.difficulty6);
    difficulty7Controller.init(questFactionReward.difficulty7);
    difficulty8Controller.init(questFactionReward.difficulty8);
    difficulty9Controller.init(questFactionReward.difficulty9);
    _afterApplyCandidate(questFactionReward);
  }

  QuestFactionRewardEntity _collectCandidate() {
    return QuestFactionRewardEntity(
      id: idController.collect(),
      difficulty0: difficulty0Controller.collect(),
      difficulty1: difficulty1Controller.collect(),
      difficulty2: difficulty2Controller.collect(),
      difficulty3: difficulty3Controller.collect(),
      difficulty4: difficulty4Controller.collect(),
      difficulty5: difficulty5Controller.collect(),
      difficulty6: difficulty6Controller.collect(),
      difficulty7: difficulty7Controller.collect(),
      difficulty8: difficulty8Controller.collect(),
      difficulty9: difficulty9Controller.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    QuestFactionRewardEntity questFactionReward,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_quest_faction_reward',
          actionType: action,
          entityName: 'QuestFactionReward ${questFactionReward.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
