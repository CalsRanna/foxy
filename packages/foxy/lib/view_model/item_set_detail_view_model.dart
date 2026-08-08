import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_set_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: ItemSetEntity, repository: ItemSetRepository)
class ItemSetDetailViewModel
    with FieldControllerMixin, _ItemSetDetailViewModelMixin {

  final nameLangFlags = signal<int>(0);

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    nameLangEnUSController.init(values.valueOf('enUS'));
    nameLangKoKRController.init(values.valueOf('koKR'));
    nameLangFrFRController.init(values.valueOf('frFR'));
    nameLangDeDEController.init(values.valueOf('deDE'));
    nameLangZhCNController.init(values.valueOf('zhCN'));
    nameLangZhTWController.init(values.valueOf('zhTW'));
    nameLangEsESController.init(values.valueOf('esES'));
    nameLangEsMXController.init(values.valueOf('esMX'));
    nameLangRuRUController.init(values.valueOf('ruRU'));
    nameLangJaJPController.init(values.valueOf('jaJP'));
    nameLangPtPTController.init(values.valueOf('ptPT'));
    nameLangPtBRController.init(values.valueOf('ptBR'));
    nameLangItITController.init(values.valueOf('itIT'));
    nameLangUnk1Controller.init(values.valueOf('unk1'));
    nameLangUnk2Controller.init(values.valueOf('unk2'));
    nameLangUnk3Controller.init(values.valueOf('unk3'));
    entity.value = _collectCandidate();
  }

  /// Collects data from all controllers to build the ItemSetEntity

  /// Leaves the page

}
