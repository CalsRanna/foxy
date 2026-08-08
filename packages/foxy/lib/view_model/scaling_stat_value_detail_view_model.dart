import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'scaling_stat_value_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: ScalingStatValueEntity,
  repository: ScalingStatValueRepository,
)
class ScalingStatValueDetailViewModel
    with FieldControllerMixin, _ScalingStatValueDetailViewModelMixin {

  /// Collects data from all controllers to build the ScalingStatValue

  /// Leaves the page

}
