import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'currency_type_detail_view_model.g.dart';

@FoxyDetailViewModel()
class CurrencyTypeDetailViewModel
    with FieldControllerMixin, _CurrencyTypeDetailViewModelMixin {
  /// Collects data from all controllers to build the CurrencyType

  /// Leaves the page
}
