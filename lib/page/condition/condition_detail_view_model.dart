import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/condition_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/condition_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ConditionDetailViewModel
    with
        ViewModelValidationMixin,
        ConditionValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<ConditionRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<ConditionEntity?>(null);
  final persistedKey = signal<ConditionKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// 当前选中的条件类型，驱动参数1/2/3 的 label 与控件联动重建
  final selectedConditionType = signal(0);
  final selectedSourceType = signal(0);
  final selectedSourceGroup = signal(0);
  final selectedConditionValue1 = signal(0);
  final selectedErrorType = signal(0);

  // 主键字段（完整 10 列）
  late final sourceTypeOrReferenceIdController = registerController(
    IntFieldController(),
  );
  late final sourceGroupController = registerController(IntFieldController());
  late final sourceEntryController = registerController(IntFieldController());
  late final sourceIdController = registerController(IntFieldController());
  late final elseGroupController = registerController(IntFieldController());
  late final conditionTypeOrReferenceController = registerController(
    IntFieldController(),
  );
  late final conditionTargetController = registerController(
    IntFieldController(),
  );
  late final conditionValue1Controller = registerController(
    IntFieldController(),
  );
  late final conditionValue2Controller = registerController(
    IntFieldController(),
  );
  late final conditionValue3Controller = registerController(
    IntFieldController(),
  );
  // 非键字段
  late final negativeConditionController = registerController(
    IntFieldController(),
  );
  late final errorTypeController = registerController(IntFieldController());
  late final errorTextIdController = registerController(IntFieldController());
  late final scriptNameController = registerController(StringFieldController());
  late final commentController = registerController(StringFieldController());

  Future<void> initSignals({ConditionKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    sourceTypeOrReferenceIdController.addListener(_onSourceTypeChange);
    sourceGroupController.addListener(_onSourceGroupChange);
    conditionTypeOrReferenceController.addListener(_onConditionTypeChange);
    conditionValue1Controller.addListener(_onConditionValue1Change);
    errorTypeController.addListener(_onErrorTypeChange);
    try {
      if (key == null) {
        final blank = await _repository.createCondition();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCondition(key);
      if (result == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final data = _collectCandidate();
      validateConditionFields(data);
      final originalKey = persistedKey.value;
      final newKey = ConditionKey.fromEntity(data);
      final isCreate = originalKey == null;
      if (isCreate) {
        await _repository.storeCondition(data);
      } else {
        await _repository.updateCondition(originalKey, data);
      }
      persistedKey.value = newKey;
      entity.value = data;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        data,
      );
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  ConditionEntity _collectCandidate() {
    return ConditionEntity(
      sourceTypeOrReferenceId: sourceTypeOrReferenceIdController.collect(),
      sourceGroup: sourceGroupController.collect(),
      sourceEntry: sourceEntryController.collect(),
      sourceId: sourceIdController.collect(),
      elseGroup: elseGroupController.collect(),
      conditionTypeOrReference: conditionTypeOrReferenceController.collect(),
      conditionTarget: conditionTargetController.collect(),
      conditionValue1: conditionValue1Controller.collect(),
      conditionValue2: conditionValue2Controller.collect(),
      conditionValue3: conditionValue3Controller.collect(),
      negativeCondition: negativeConditionController.collect(),
      errorType: errorTypeController.collect(),
      errorTextId: errorTextIdController.collect(),
      scriptName: scriptNameController.collect(),
      comment: commentController.collect(),
    );
  }

  void _applyCandidate(ConditionEntity c) {
    sourceTypeOrReferenceIdController.init(c.sourceTypeOrReferenceId);
    selectedSourceType.value = c.sourceTypeOrReferenceId;
    sourceGroupController.init(c.sourceGroup);
    selectedSourceGroup.value = c.sourceGroup;
    sourceEntryController.init(c.sourceEntry);
    sourceIdController.init(c.sourceId);
    elseGroupController.init(c.elseGroup);
    conditionTypeOrReferenceController.init(c.conditionTypeOrReference);
    selectedConditionType.value = c.conditionTypeOrReference;
    conditionTargetController.init(c.conditionTarget);
    conditionValue1Controller.init(c.conditionValue1);
    selectedConditionValue1.value = c.conditionValue1;
    conditionValue2Controller.init(c.conditionValue2);
    conditionValue3Controller.init(c.conditionValue3);
    negativeConditionController.init(c.negativeCondition);
    errorTypeController.init(c.errorType);
    selectedErrorType.value = c.errorType;
    errorTextIdController.init(c.errorTextId);
    scriptNameController.init(c.scriptName);
    commentController.init(c.comment);
  }

  void _logActivity(ActivityActionType action, ConditionEntity c) {
    try {
      final log = ActivityLogEntity(
        module: 'conditions',
        actionType: action,
        entityName:
            'Condition ${c.sourceTypeOrReferenceId}/${c.sourceGroup}/'
            '${c.sourceEntry}/${c.sourceId}/${c.elseGroup}'
            '${c.comment.isEmpty ? '' : ' - ${c.comment}'}',
        createdAt: DateTime.now(),
      );
      _activityLogService.recordBestEffort(log);
    } catch (e) {
      LoggerUtil.instance.e('记录条件活动失败: $e');
    }
  }

  void _onConditionTypeChange() {
    selectedConditionType.value = conditionTypeOrReferenceController.collect();
  }

  void _onConditionValue1Change() {
    selectedConditionValue1.value = conditionValue1Controller.collect();
  }

  void _onErrorTypeChange() {
    selectedErrorType.value = errorTypeController.collect();
  }

  void _onSourceGroupChange() {
    selectedSourceGroup.value = sourceGroupController.collect();
  }

  void _onSourceTypeChange() {
    selectedSourceType.value = sourceTypeOrReferenceIdController.collect();
  }

  void dispose() {
    sourceTypeOrReferenceIdController.removeListener(_onSourceTypeChange);
    sourceGroupController.removeListener(_onSourceGroupChange);
    conditionTypeOrReferenceController.removeListener(_onConditionTypeChange);
    conditionValue1Controller.removeListener(_onConditionValue1Change);
    errorTypeController.removeListener(_onErrorTypeChange);
    disposeControllers();
  }
}
