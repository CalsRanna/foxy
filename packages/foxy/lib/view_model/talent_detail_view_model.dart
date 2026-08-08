import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'talent_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: TalentEntity,
  selects: {'flags': 0},
  repository: TalentRepository,
)
class TalentDetailViewModel
    with FieldControllerMixin, _TalentDetailViewModelMixin {

  /// Collects data from all controllers to build the Talent

  /// Leaves the page

}
