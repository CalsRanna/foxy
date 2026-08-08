import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_template_detail_view_model.g.dart';

@FoxyDetailViewModel(
  flags: {
    'dynamicFlags',
    'flagsExtra',
    'npcFlag',
    'typeFlags',
    'unitFlags',
    'unitFlags2',
  },
  selects: {
    'damageSchool': 0,
    'exp': 0,
    'family': 0,
    'movementType': 0,
    'racialLeader': 0,
    'rank': 0,
    'regenHealth': 0,
    'type': 0,
    'unitClass': 1,
  },
)
class CreatureTemplateDetailViewModel
    with FieldControllerMixin, _CreatureTemplateDetailViewModelMixin {
  /// Collects data from all fields to build the CreatureTemplate

  /// Leaves the page
  @override
  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      if (candidate.entry <= 0) {
        throw ValidationException('invalid creature template entry');
      }
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeCreatureTemplate(candidate);
      } else {
        await _repository.updateCreatureTemplate(originalKey, candidate);
      }
      persistedKey.value = candidate.entry;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }
}
