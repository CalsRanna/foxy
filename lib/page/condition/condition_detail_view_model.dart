import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/condition_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ConditionDetailViewModel
    with
        ViewModelValidationMixin,
        ConditionValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<ConditionRepository>();

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

  final condition = signal<ConditionEntity?>(null);

  /// 当前选中的条件类型，驱动参数1/2/3 的 label 与控件联动重建
  final selectedConditionType = signal(0);
  final selectedSourceType = signal(0);
  final selectedSourceGroup = signal(0);
  final selectedConditionValue1 = signal(0);
  final selectedErrorType = signal(0);

  /// 现有记录：完整 10 列主键只读
  final isExisting = signal(false);
  Map<String, dynamic>? _originalCredential;

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    sourceTypeOrReferenceIdController.addListener(_onSourceTypeChange);
    sourceGroupController.addListener(_onSourceGroupChange);
    conditionTypeOrReferenceController.addListener(_onConditionTypeChange);
    conditionValue1Controller.addListener(_onConditionValue1Change);
    errorTypeController.addListener(_onErrorTypeChange);
    try {
      // 复合主键均为语义列：新建可编辑；编辑锁定。无简单 MAX+1。
      if (credential == null) {
        isExisting.value = false;
        _originalCredential = null;
        final blank = await _repository.createCondition();
        condition.value = blank;
        _initControllers(blank);
        return;
      }
      isExisting.value = true;
      _originalCredential = credential;
      final result = await _repository.getConditionFromCredential(credential);
      if (result == null) return;
      condition.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载条件失败', error: e, stackTrace: s);
    }
  }

  void _onConditionTypeChange() {
    selectedConditionType.value = conditionTypeOrReferenceController.collect();
  }

  void _onSourceTypeChange() {
    selectedSourceType.value = sourceTypeOrReferenceIdController.collect();
  }

  void _onSourceGroupChange() {
    selectedSourceGroup.value = sourceGroupController.collect();
  }

  void _onConditionValue1Change() {
    selectedConditionValue1.value = conditionValue1Controller.collect();
  }

  void _onErrorTypeChange() {
    selectedErrorType.value = errorTypeController.collect();
  }

  void _initControllers(ConditionEntity c) {
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

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      validateConditionFields(data);
      final isCreate = _originalCredential == null;
      if (isCreate) {
        await _repository.storeCondition(data);
        _originalCredential = data.buildCredential();
        isExisting.value = true;
      } else {
        await _repository.updateCondition(_originalCredential!, data);
      }
      condition.value = data;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        data,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('条件已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  ConditionEntity _collectFromControllers() {
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

  void _logActivity(ActivityActionType action, ConditionEntity c) {
    final log = ActivityLogEntity(
      module: 'conditions',
      actionType: action,
      entityId: c.sourceTypeOrReferenceId,
      entityName: c.comment,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
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
