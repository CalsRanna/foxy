import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'reference_loot_template_detail_view_model.g.dart';

@FoxyDetailViewModel()
class ReferenceLootTemplateDetailViewModel
    with FieldControllerMixin, _ReferenceLootTemplateDetailViewModelMixin {
  final hasReference = signal(false);
  ReferenceLootTemplateDetailViewModel() {
    referenceController.addListener(_syncReferenceState);
  }

  @override
  void dispose() {
    referenceController.removeListener(_syncReferenceState);
    disposeControllers();
  }

  @override
  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    final candidate = _collectCandidate();
    final originalKey = persistedKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeReferenceLootTemplate(candidate);
      } else {
        await _repository.updateReferenceLootTemplate(originalKey, candidate);
      }
      entity.value = candidate;
      persistedKey.value = ReferenceLootTemplateKey.fromEntity(candidate);
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _syncReferenceState() {
    try {
      final value = referenceController.collect() != 0;
      hasReference.value = value;
      if (value && questRequiredController.collect() != 0) {
        questRequiredController.init(0);
      }
    } on FormatException {
      hasReference.value = false;
    }
  }
}
