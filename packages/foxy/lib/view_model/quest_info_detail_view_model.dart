import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestInfoDetailViewModel with FieldControllerMixin {
  void _logActivity(ActivityActionType action, QuestInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_info',
      actionType: action,
      entityName: t.infoNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }

  final _repository = GetIt.instance.get<QuestInfoRepository>();

  final entity = signal<QuestInfoEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final infoNameLangFlagsController = registerController(
    IntFieldController(),
  );

  void applyInfoNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      infoNameLangEnUS: values.valueOf('enUS'),
      infoNameLangKoKR: values.valueOf('koKR'),
      infoNameLangFrFR: values.valueOf('frFR'),
      infoNameLangDeDE: values.valueOf('deDE'),
      infoNameLangZhCN: values.valueOf('zhCN'),
      infoNameLangZhTW: values.valueOf('zhTW'),
      infoNameLangEsES: values.valueOf('esES'),
      infoNameLangEsMX: values.valueOf('esMX'),
      infoNameLangRuRU: values.valueOf('ruRU'),
      infoNameLangJaJP: values.valueOf('jaJP'),
      infoNameLangPtPT: values.valueOf('ptPT'),
      infoNameLangPtBR: values.valueOf('ptBR'),
      infoNameLangItIT: values.valueOf('itIT'),
      infoNameLangUnk1: values.valueOf('unk1'),
      infoNameLangUnk2: values.valueOf('unk2'),
      infoNameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

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
      errorMessage.value = FoxyError.message(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeQuestInfo(candidate);
      } else {
        await _repository.updateQuestInfo(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyError.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _applyCandidate(QuestInfoEntity table) {
    idController.init(table.id);
    nameController.init(table.infoNameLangZhCN);
    infoNameLangFlagsController.init(table.infoNameLangFlags);
  }

  QuestInfoEntity _collectCandidate() {
    return entity.value!.copyWith(
      id: idController.collect(),
      infoNameLangZhCN: nameController.collect(),
      infoNameLangFlags: infoNameLangFlagsController.collect(),
    );
  }
}
