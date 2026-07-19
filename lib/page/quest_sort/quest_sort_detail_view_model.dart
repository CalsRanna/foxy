import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/quest_sort_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestSortDetailViewModel
    with
        ViewModelValidationMixin,
        QuestSortValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestSortRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final sortNameLangFlagsController = registerController(
    IntFieldController(),
  );

  final sort = signal(QuestSortEntity());
  final persistedKey = signal<int?>(null);

  void applySortNameLocales(List<DbcLocaleFieldValue> values) {
    sort.value = sort.value.copyWith(
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

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createQuestSort();
        sort.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final entity = await _repository.getQuestSort(key);
      if (entity == null) {
        throw StateError('原任务排序不存在，可能已被其他操作修改或删除');
      }
      sort.value = entity;
      _initControllers(entity);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务排序(key=$key)失败', error: e, stackTrace: s);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
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
    sort.value = candidate;
    routerFacade.updateCurrentLabel(_labelFor(candidate));
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('任务排序数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  QuestSortEntity _collectFromControllers() {
    return sort.value.copyWith(
      id: idController.collect(),
      sortNameLangZhCN: nameController.collect(),
      sortNameLangFlags: sortNameLangFlagsController.collect(),
    );
  }

  void _initControllers(QuestSortEntity table) {
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  String _labelFor(QuestSortEntity value) {
    return value.sortNameLangZhCN.isNotEmpty
        ? value.sortNameLangZhCN
        : '任务排序 #${value.id}';
  }
}
