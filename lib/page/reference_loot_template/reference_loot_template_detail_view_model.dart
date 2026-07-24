import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/reference_loot_template_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ReferenceLootTemplateDetailViewModel
    with
        ViewModelValidationMixin,
        ReferenceLootTemplateValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ReferenceLootTemplateRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();
  ReferenceLootTemplateEntity _collectCandidate() {
    return ReferenceLootTemplateEntity(
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }

  void _applyCandidate(ReferenceLootTemplateEntity candidate) {
    entryController.init(candidate.entry);
    itemController.init(candidate.item);
    referenceController.init(candidate.reference);
    chanceController.init(candidate.chance);
    questRequiredController.init(candidate.questRequired ? 1 : 0);
    lootModeController.init(candidate.lootMode);
    groupIdController.init(candidate.groupId);
    minCountController.init(candidate.minCount);
    maxCountController.init(candidate.maxCount);
    commentController.init(candidate.comment);
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

  final entity = signal<ReferenceLootTemplateEntity?>(null);
  final persistedKey = signal<ReferenceLootTemplateKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);
  final hasReference = signal(false);

  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(FlagFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  ReferenceLootTemplateDetailViewModel() {
    referenceController.addListener(_syncReferenceState);
  }

  Future<void> initSignals({ReferenceLootTemplateKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = key == null
          ? await _repository.createLootTemplate(0)
          : await _repository.getLootTemplate(key);
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
    validateReferenceLootTemplateFields(candidate);
    final originalKey = persistedKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeLootTemplate(candidate);
      } else {
        await _repository.updateLootTemplate(originalKey, candidate);
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

  void dispose() {
    referenceController.removeListener(_syncReferenceState);
    disposeControllers();
  }
}
