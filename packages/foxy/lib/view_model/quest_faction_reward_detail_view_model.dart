import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_faction_reward_detail_view_model.g.dart';

@FoxyDetailViewModel()
class QuestFactionRewardDetailViewModel
    with FieldControllerMixin, _QuestFactionRewardDetailViewModelMixin {
  /// Collects data from all controllers to build the QuestFactionReward

  /// Leaves the page
}
