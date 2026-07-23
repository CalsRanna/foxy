import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/quest_sort_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestSortDetailViewModel
    with
        ViewModelValidationMixin,
        QuestSortValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestSortRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<QuestSortEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final sortNameLangFlagsController = registerController(
    IntFieldController(),
  );

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createQuestSort();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getQuestSort(key);
      if (result == null) {
        throw StateError('原任务排序不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      validateQuestSortFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeQuestSort(candidate);
      } else {
        await _repository.updateQuestSort(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void applySortNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      sortNameLangEnUS: values.valueOf('enUS'),
      sortNameLangKoKR: values.valueOf('koKR'),
      sortNameLangFrFR: values.valueOf('frFR'),
      sortNameLangDeDE: values.valueOf('deDE'),
      sortNameLangZhCN: values.valueOf('zhCN'),
      sortNameLangZhTW: values.valueOf('zhTW'),
      sortNameLangEsES: values.valueOf('esES'),
      sortNameLangEsMX: values.valueOf('esMX'),
      sortNameLangRuRU: values.valueOf('ruRU'),
      sortNameLangJaJP: values.valueOf('jaJP'),
      sortNameLangPtPT: values.valueOf('ptPT'),
      sortNameLangPtBR: values.valueOf('ptBR'),
      sortNameLangItIT: values.valueOf('itIT'),
      sortNameLangUnk1: values.valueOf('unk1'),
      sortNameLangUnk2: values.valueOf('unk2'),
      sortNameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

  QuestSortEntity _collectCandidate() {
    return entity.value!.copyWith(
      id: idController.collect(),
      sortNameLangZhCN: nameController.collect(),
      sortNameLangFlags: sortNameLangFlagsController.collect(),
    );
  }

  void _applyCandidate(QuestSortEntity table) {
    idController.init(table.id);
    nameController.init(table.sortNameLangZhCN);
    sortNameLangFlagsController.init(table.sortNameLangFlags);
  }

  void _logActivity(ActivityActionType action, QuestSortEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_sort',
      actionType: action,
      entityName: t.sortNameLangZhCN,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
