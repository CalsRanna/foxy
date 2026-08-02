import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// 来源/条件两列的「普通类型 | 引用模板」模式选项。
const kConditionModeOptions = <int, String>{0: '普通类型', 1: '引用模板'};

class ConditionDetailViewModel with FieldControllerMixin {
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
  final selectedSourceMode = signal(0);
  final selectedConditionMode = signal(0);

  // 来源：模式 + 类型/引用 ID 两组语义 controller
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

  // 条件：模式 + 类型/引用 ID 两组语义 controller
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
  // 非键字段
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
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCondition(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
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
      // 来源/条件类型为 0 时既不是合法普通类型也不是合法引用，写库会
      // 导致 core 无法加载该条件（_collectCandidate 已校验负数引用为正）。
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
      errorMessage.value = foxyErrorMessage(error);
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
    // 显式刷新一次编辑规格，不依赖类型 controller 监听的回调顺序。
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
      // 引用模式下 AzerothCore 明确不使用的物理字段投影为 0；
      // controller 草稿保留，切回普通模式后仍可继续编辑。
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
    final config = conditionValueConfig(
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
      // 引用模式下来源组/来源 ID 始终是只读数字输入。
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

  /// 引用模板（物理负值）必须满足 core 的引用约束：不设置来源组、来源
  /// 条目等字段；普通类型必须存在于 core 加载表（引用 ID 为正已由
  /// _collectCandidate 保证）。
  void _requireWriteableType(ConditionEntity condition) {
    final source = condition.sourceTypeOrReferenceId;
    if (source >= 0) {
      if (!kConditionSourceTypeLabels.containsKey(source)) {
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
    if (type >= 0 && !kConditionTypeLabels.containsKey(type)) {
      throw ArgumentError.value(
        type,
        'ConditionTypeOrReference',
        '当前 3.3.5a core 不加载该条件类型',
      );
    }
  }

  /// 物理值 → 模式：负数表示引用模板，否则为普通类型。
  static int _decodeMode(int value) => value < 0 ? 1 : 0;

  /// 物理值 → 引用 ID（正数）。
  static int _decodeReferenceId(int value) => value < 0 ? -value : 0;

  /// 物理值 → 类型（非负）。
  static int _decodeType(int value) => value < 0 ? 0 : value;

  static int _positiveReferenceId(int id, String field) {
    if (id <= 0) {
      throw ArgumentError.value(id, field, 'reference ID must be positive');
    }
    return id;
  }
}
