import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'glyph_property_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: GlyphPropertyEntity,
  selects: {'glyphSlotFlags': 0},
  repository: GlyphPropertyRepository,
)
class GlyphPropertyDetailViewModel
    with FieldControllerMixin, _GlyphPropertyDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Collects data from all controllers to build the GlyphProperty

  /// Leaves the page

  @override
  void _logActivity(
    ActivityActionType action,
    GlyphPropertyEntity glyphProperty,
  ) {
    final log = ActivityLogEntity(
      module: 'glyph_property',
      actionType: action,
      entityName: 'GlyphProperty ${glyphProperty.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
