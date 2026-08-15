import 'package:foxy/constant/condition_source_types.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// "Normal type | reference template" mode options for the source/condition
/// columns.


class ConditionDetailViewModel with FieldControllerMixin {
  static const modeOptions = <int, String>{0: '普通类型', 1: '引用模板'};

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
      GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
    } catch (e) {
      LoggerUtil.instance.e('记录条件活动失败: $e');
    }
  }

  final _repository = GetIt.instance.get<ConditionRepository>();

  final entity = signal<ConditionEntity?>(null);
  final persistedKey = signal<ConditionKey?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Currently selected condition type; drives the label/cascade rebuild of
  /// the param1/2/3 controls
  final selectedConditionType = signal(0);
  final selectedSourceType = signal(0);
  final selectedSourceGroup = signal(0);
  final selectedConditionValue1 = signal(0);
  final selectedErrorType = signal(0);
  final selectedSourceMode = signal(0);
  final selectedConditionMode = signal(0);

  // Source: two semantic controller groups — mode + type/reference ID
  late final sourceModeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final sourceTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final sourceReferenceIdController = registerController(
    IntFieldController(),
  );
  late final sourceGroupController = registerController(
    IntFieldControllerGroup(),
  );
  late final sourceEntryController = registerController(IntFieldController());
  late final sourceIdController = registerController(IntFieldControllerGroup());
  late final elseGroupController = registerController(IntFieldController());

  // Condition: two semantic controller groups — mode + type/reference ID
  late final conditionModeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final conditionTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final conditionReferenceIdController = registerController(
    IntFieldController(),
  );
  late final conditionTargetController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final conditionValue1Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final conditionValue2Controller = registerController(
    IntFieldControllerGroup(),
  );
  late final conditionValue3Controller = registerController(
    IntFieldControllerGroup(),
  );
  // Non-key fields
  late final negativeConditionController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final errorTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final errorTextIdController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final scriptNameController = registerController(StringFieldController());
  late final commentController = registerController(StringFieldController());

  void dispose() {
    sourceModeController.removeListener(_onSourceModeChange);
    sourceTypeController.removeListener(_onSourceTypeChange);
    sourceGroupController.removeListener(_onSourceGroupChange);
    conditionModeController.removeListener(_onConditionModeChange);
    conditionTypeController.removeListener(_onConditionTypeChange);
    conditionValue1Controller.removeListener(_onConditionValue1Change);
    errorTypeController.removeListener(_onErrorTypeChange);
    disposeControllers();
  }

  Future<void> initSignals({ConditionKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    sourceModeController.addListener(_onSourceModeChange);
    sourceTypeController.addListener(_onSourceTypeChange);
    sourceGroupController.addListener(_onSourceGroupChange);
    conditionModeController.addListener(_onConditionModeChange);
    conditionTypeController.addListener(_onConditionTypeChange);
    conditionValue1Controller.addListener(_onConditionValue1Change);
    errorTypeController.addListener(_onErrorTypeChange);
    try {
      if (key == null) {
        final blank = await _repository.createCondition();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCondition(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyExceptions.message(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final data = _collectCandidate();
      // A type of 0 is neither a valid normal type nor a valid reference;
      // persisting it would stop core from loading the condition
      // (_collectCandidate already ensures negative references are
      // positive).
      _requireWriteableType(data);
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
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _applyCandidate(ConditionEntity c) {
    sourceModeController.init(_decodeMode(c.sourceTypeOrReferenceId));
    sourceTypeController.init(_decodeType(c.sourceTypeOrReferenceId));
    sourceReferenceIdController.init(
      _decodeReferenceId(c.sourceTypeOrReferenceId),
    );
    selectedSourceMode.value = sourceModeController.collect();
    selectedSourceType.value = sourceTypeController.collect();
    sourceGroupController.init(c.sourceGroup);
    selectedSourceGroup.value = c.sourceGroup;
    sourceEntryController.init(c.sourceEntry);
    sourceIdController.init(c.sourceId);
    elseGroupController.init(c.elseGroup);
    conditionModeController.init(_decodeMode(c.conditionTypeOrReference));
    conditionTypeController.init(_decodeType(c.conditionTypeOrReference));
    conditionReferenceIdController.init(
      _decodeReferenceId(c.conditionTypeOrReference),
    );
    selectedConditionMode.value = conditionModeController.collect();
    selectedConditionType.value = conditionTypeController.collect();
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
    // Explicitly refresh the edit specs once, independent of the type
    // controller listener callback order.
    _refreshSourceEditors();
    _refreshConditionValueEditors();
  }

  ConditionEntity _collectCandidate() {
    final sourceReferenceMode = sourceModeController.collect() == 1;
    final conditionReferenceMode = conditionModeController.collect() == 1;
    final sourceTypeOrReferenceId = sourceReferenceMode
        ? -_positiveReferenceId(
            sourceReferenceIdController.collect(),
            'SourceTypeOrReferenceId',
          )
        : sourceTypeController.collect();
    final conditionTypeOrReference = conditionReferenceMode
        ? -_positiveReferenceId(
            conditionReferenceIdController.collect(),
            'ConditionTypeOrReference',
          )
        : conditionTypeController.collect();
    return ConditionEntity(
      sourceTypeOrReferenceId: sourceTypeOrReferenceId,
      // In reference mode, physical fields AzerothCore explicitly ignores
      // project as 0; controller drafts are kept, so editing can resume
      // after switching back to normal mode.
      sourceGroup: sourceReferenceMode ? 0 : sourceGroupController.collect(),
      sourceEntry: sourceReferenceMode ? 0 : sourceEntryController.collect(),
      sourceId: sourceReferenceMode ? 0 : sourceIdController.collect(),
      elseGroup: elseGroupController.collect(),
      conditionTypeOrReference: conditionTypeOrReference,
      conditionTarget: (sourceReferenceMode || conditionReferenceMode)
          ? 0
          : conditionTargetController.collect(),
      conditionValue1: conditionReferenceMode
          ? 0
          : conditionValue1Controller.collect(),
      conditionValue2: conditionReferenceMode
          ? 0
          : conditionValue2Controller.collect(),
      conditionValue3: conditionReferenceMode
          ? 0
          : conditionValue3Controller.collect(),
      negativeCondition: conditionReferenceMode
          ? 0
          : negativeConditionController.collect(),
      errorType: sourceReferenceMode ? 0 : errorTypeController.collect(),
      errorTextId: sourceReferenceMode ? 0 : errorTextIdController.collect(),
      scriptName: scriptNameController.collect(),
      comment: commentController.collect(),
    );
  }

  void _onConditionModeChange() {
    selectedConditionMode.value = conditionModeController.collect();
    _refreshConditionValueEditors();
  }

  void _onConditionTypeChange() {
    selectedConditionType.value = conditionTypeController.collect();
    _refreshConditionValueEditors();
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

  void _onSourceModeChange() {
    selectedSourceMode.value = sourceModeController.collect();
    _refreshSourceEditors();
  }

  void _onSourceTypeChange() {
    selectedSourceType.value = sourceTypeController.collect();
    _refreshSourceEditors();
  }

  void _refreshConditionValueEditors() {
    final type = conditionModeController.collect() == 1
        ? -1
        : conditionTypeController.collect();
    final config = ConditionValueConfig.forType(
      type,
      value1: conditionValue1Controller.collect(),
    );
    conditionValue1Controller.configure(config.value1.editor);
    conditionValue2Controller.configure(config.value2.editor);
    conditionValue3Controller.configure(config.value3.editor);
  }

  void _refreshSourceEditors() {
    final mode = sourceModeController.collect();
    final type = sourceTypeController.collect();
    if (mode == 1) {
      // In reference mode, the source group/source ID are always plain
      // number inputs.
      sourceGroupController.configure(IntegerFieldEditor.number);
      sourceIdController.configure(IntegerFieldEditor.number);
      return;
    }
    sourceGroupController.configure(
      type == 30 ? IntegerFieldEditor.select : IntegerFieldEditor.number,
    );
    sourceIdController.configure(
      type == 22 ? IntegerFieldEditor.select : IntegerFieldEditor.number,
    );
  }

  /// Reference templates (physically negative) must satisfy core's
  /// reference constraints: the source group/source entry fields stay
  /// unset; normal types must exist in core's load table (positive
  /// reference IDs are already guaranteed by _collectCandidate).
  void _requireWriteableType(ConditionEntity condition) {
    final source = condition.sourceTypeOrReferenceId;
    if (source >= 0) {
      if (!ConditionSourceTypes.conditionSourceTypeLabels.containsKey(source)) {
        throw ArgumentError.value(
          source,
          'SourceTypeOrReferenceId',
          'current 3.3.5a core does not load this source type',
        );
      }
    } else if (condition.sourceGroup != 0 || condition.sourceEntry != 0) {
      throw ArgumentError(
        'reference template cannot set SourceGroup or SourceEntry',
      );
    }
    final type = condition.conditionTypeOrReference;
    if (type >= 0 && !ConditionType.conditionTypeLabels.containsKey(type)) {
      throw ArgumentError.value(
        type,
        'ConditionTypeOrReference',
        'unsupported condition type: $type (not loaded by 3.3.5a core)',
      );
    }
  }

  /// Physical value → mode: negative means a reference template, otherwise
  /// a normal type.
  static int _decodeMode(int value) => value < 0 ? 1 : 0;

  /// Physical value → reference ID (positive).
  static int _decodeReferenceId(int value) => value < 0 ? -value : 0;

  /// Physical value → type (non-negative).
  static int _decodeType(int value) => value < 0 ? 0 : value;

  static int _positiveReferenceId(int id, String field) {
    if (id <= 0) {
      throw ArgumentError.value(id, field, 'reference ID must be positive');
    }
    return id;
  }
}
