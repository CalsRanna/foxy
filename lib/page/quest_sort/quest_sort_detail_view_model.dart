import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestSortDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestSortRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());

  final sort = signal(QuestSortEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = (await _repository.getQuestSort(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeQuestSort(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateQuestSort(t);
      }
      sort.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('任务排序数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

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

  void pop() {
    routerFacade.goBack();
  }

  QuestSortEntity _collectFromControllers() {
    return sort.value.copyWith(
      id: idController.collect(),
      sortNameLangZhCN: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, QuestSortEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_sort',
      actionType: action,
      entityId: t.id,
      entityName: t.sortNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createQuestSort();
        sort.value = blank;
        _initControllers(blank);
        return;
      }
      sort.value = (await _repository.getQuestSort(id))!;
      _initControllers(sort.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载任务排序(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(QuestSortEntity table) {
    idController.init(table.id);
    nameController.init(table.sortNameLangZhCN);
  }
}
