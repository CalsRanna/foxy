import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_template_addon_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(flags: {'flags'})
class GameObjectTemplateAddonLinkedDetailViewModel
    with
        FieldControllerMixin,
        _GameObjectTemplateAddonLinkedDetailViewModelMixin {}
