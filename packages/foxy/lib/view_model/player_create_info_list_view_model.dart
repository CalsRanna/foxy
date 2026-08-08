import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'player_create_info_list_view_model.g.dart';

@FoxyListViewModel(entity: PlayerCreateInfoEntity, repository: PlayerCreateInfoRepository)
class PlayerCreateInfoListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _PlayerCreateInfoListViewModelMixin {
}
