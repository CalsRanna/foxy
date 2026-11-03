import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_info_detail_view_model.g.dart';

@FoxyDetailViewModel(
  // Other locales are kept in entity and edited through the locale dialog.
  exclude: {
    'infoNameLangEnUS',
    'infoNameLangKoKR',
    'infoNameLangFrFR',
    'infoNameLangDeDE',
    'infoNameLangZhTW',
    'infoNameLangEsES',
    'infoNameLangEsMX',
    'infoNameLangRuRU',
    'infoNameLangJaJP',
    'infoNameLangPtPT',
    'infoNameLangPtBR',
    'infoNameLangItIT',
    'infoNameLangUnk1',
    'infoNameLangUnk2',
    'infoNameLangUnk3',
  },
)
class QuestInfoDetailViewModel
    with FieldControllerMixin, _QuestInfoDetailViewModelMixin {
  StringFieldController get nameController => infoNameLangZhCNController;

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

  @override
  QuestInfoEntity _collectCandidate() {
    return entity.value!.copyWith(
      id: idController.collect(),
      infoNameLangZhCN: nameController.collect(),
      infoNameLangFlags: infoNameLangFlagsController.collect(),
    );
  }

  @override
  void _logActivity(ActivityActionType action, QuestInfoEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_info',
      actionType: action,
      entityName: t.infoNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }
}
