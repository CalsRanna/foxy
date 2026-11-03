// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info_detail_view_model.dart';

mixin _QuestInfoDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestInfoRepository>();

  final entity = signal<QuestInfoEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final infoNameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final infoNameLangFlagsController = registerController(
    IntFieldController(),
  );

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createQuestInfo();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getQuestInfo(key);
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
      var candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        final storedKey = await _repository.storeQuestInfo(candidate);
        persistedKey.value = storedKey;
        if (storedKey != candidate.id) {
          candidate = candidate.copyWith(id: storedKey);
          if (!isDisposed) {
            idController.init(storedKey);
          }
        }
      } else {
        await _repository.updateQuestInfo(originalKey, candidate);
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

  void _afterApplyCandidate(QuestInfoEntity questInfo) {}

  void _applyCandidate(QuestInfoEntity questInfo) {
    idController.init(questInfo.id);
    infoNameLangZhCNController.init(questInfo.infoNameLangZhCN);
    infoNameLangFlagsController.init(questInfo.infoNameLangFlags);
    _afterApplyCandidate(questInfo);
  }

  QuestInfoEntity _collectCandidate() {
    return QuestInfoEntity(
      id: idController.collect(),
      infoNameLangZhCN: infoNameLangZhCNController.collect(),
      infoNameLangFlags: infoNameLangFlagsController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(ActivityActionType action, QuestInfoEntity questInfo) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_quest_info',
          actionType: action,
          entityName: 'QuestInfo ${questInfo.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
