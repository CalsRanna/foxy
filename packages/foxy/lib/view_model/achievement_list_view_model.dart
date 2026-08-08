import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'achievement_list_view_model.g.dart';

@FoxyListViewModel(entity: AchievementEntity, repository: AchievementRepository)
class AchievementListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _AchievementListViewModelMixin {
}
