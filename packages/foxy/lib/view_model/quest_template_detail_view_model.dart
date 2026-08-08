import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_template_detail_view_model.g.dart';

@FoxyDetailViewModel(
  flags: {'allowableRaces', 'flags'},
  selects: {'questType', 'rewardMoneyDifficulty', 'rewardXpDifficulty'},
)
class QuestTemplateDetailViewModel
    with FieldControllerMixin, _QuestTemplateDetailViewModelMixin {}
