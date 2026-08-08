import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_offer_reward_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: QuestOfferRewardEntity,
  repository: QuestOfferRewardRepository,
)
class QuestOfferRewardLinkedDetailViewModel
    with FieldControllerMixin, _QuestOfferRewardLinkedDetailViewModelMixin {
}