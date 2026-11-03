import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_sort_detail_view_model.g.dart';

@FoxyDetailViewModel(
  // Other locales are kept in entity and edited through the locale dialog.
  exclude: {
    'sortNameLangEnUS',
    'sortNameLangKoKR',
    'sortNameLangFrFR',
    'sortNameLangDeDE',
    'sortNameLangZhTW',
    'sortNameLangEsES',
    'sortNameLangEsMX',
    'sortNameLangRuRU',
    'sortNameLangJaJP',
    'sortNameLangPtPT',
    'sortNameLangPtBR',
    'sortNameLangItIT',
    'sortNameLangUnk1',
    'sortNameLangUnk2',
    'sortNameLangUnk3',
  },
)
class QuestSortDetailViewModel
    with FieldControllerMixin, _QuestSortDetailViewModelMixin {
  StringFieldController get nameController => sortNameLangZhCNController;

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

  @override
  QuestSortEntity _collectCandidate() {
    return entity.value!.copyWith(
      id: idController.collect(),
      sortNameLangZhCN: nameController.collect(),
      sortNameLangFlags: sortNameLangFlagsController.collect(),
    );
  }

  @override
  void _logActivity(ActivityActionType action, QuestSortEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_sort',
      actionType: action,
      entityName: t.sortNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }
}
