import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'reference_loot_template_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: ReferenceLootTemplateEntity)
class ReferenceLootTemplateDetailViewModel
    with
        FieldControllerMixin, _ReferenceLootTemplateDetailViewModelMixin {
  final _repository = GetIt.instance.get<ReferenceLootTemplateRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ReferenceLootTemplateEntity?>(null);

  final persistedKey = signal<ReferenceLootTemplateKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);
  final hasReference = signal(false);
  ReferenceLootTemplateDetailViewModel() {
    referenceController.addListener(_syncReferenceState);
  }

  void dispose() {
    referenceController.removeListener(_syncReferenceState);
    disposeControllers();
  }

  Future<void> initSignals({ReferenceLootTemplateKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = key == null
          ? await _repository.createLootTemplate(0)
          : await _repository.getReferenceLootTemplate(key);
      if (candidate == null) {
        throw StateError('原关联掉落不存在，可能已被其他操作修改或删除');
      }
      persistedKey.value = key;
      entity.value = candidate;
      _applyCandidate(candidate);
    } catch (error) {
      errorMessage.value = '$error';
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
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
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _logActivity(
    ActivityActionType action,
    ReferenceLootTemplateEntity candidate,
  ) {
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'reference_loot_template',
        actionType: action,
        entityName:
            'ReferenceLoot ${candidate.entry}/${candidate.item}/'
            '${candidate.reference}/${candidate.groupId}',
        createdAt: DateTime.now(),
      ),
    );
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
