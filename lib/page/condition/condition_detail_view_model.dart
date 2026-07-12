import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ConditionDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<ConditionRepository>();

  // 主键字段（完整 10 列）
  final sourceTypeOrReferenceIdController = SelectFieldController<int>(
    fallback: 0,
  );
  final sourceGroupController = IntFieldController();
  final sourceEntryController = IntFieldController();
  final sourceIdController = IntFieldController();
  final elseGroupController = IntFieldController();
  final conditionTypeOrReferenceController = SelectFieldController<int>(
    fallback: 0,
  );
  final conditionTargetController = IntFieldController();
  final conditionValue1Controller = IntFieldController();
  final conditionValue2Controller = IntFieldController();
  final conditionValue3Controller = IntFieldController();

  // 非键字段
  final negativeConditionController = IntFieldController();
  final errorTypeController = IntFieldController();
  final errorTextIdController = IntFieldController();
  final scriptNameController = StringFieldController();
  final commentController = StringFieldController();

  late final _controllers = <FieldController>[
    sourceTypeOrReferenceIdController,
    sourceGroupController,
    sourceEntryController,
    sourceIdController,
    elseGroupController,
    conditionTypeOrReferenceController,
    conditionTargetController,
    conditionValue1Controller,
    conditionValue2Controller,
    conditionValue3Controller,
    negativeConditionController,
    errorTypeController,
    errorTextIdController,
    scriptNameController,
    commentController,
  ];

  final condition = signal<ConditionEntity?>(null);

  /// 当前选中的条件类型，驱动参数1/2/3 的 label 与控件联动重建
  final selectedConditionType = signal(0);

  /// 现有记录：完整 10 列主键只读
  final isExisting = signal(false);
  Map<String, dynamic>? _originalCredential;

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    conditionTypeOrReferenceController.controller.addListener(
      _onConditionTypeChange,
    );
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

  void _initControllers(ConditionEntity c) {
    sourceTypeOrReferenceIdController.init(c.sourceTypeOrReferenceId);
    sourceGroupController.init(c.sourceGroup);
    sourceEntryController.init(c.sourceEntry);
    sourceIdController.init(c.sourceId);
    elseGroupController.init(c.elseGroup);
    conditionTypeOrReferenceController.init(c.conditionTypeOrReference);
    selectedConditionType.value = c.conditionTypeOrReference;
    conditionTargetController.init(c.conditionTarget);
    conditionValue1Controller.init(c.conditionValue1);
    conditionValue2Controller.init(c.conditionValue2);
    conditionValue3Controller.init(c.conditionValue3);
    negativeConditionController.init(c.negativeCondition);
    errorTypeController.init(c.errorType);
    errorTextIdController.init(c.errorTextId);
    scriptNameController.init(c.scriptName);
    commentController.init(c.comment);
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
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
    conditionTypeOrReferenceController.controller.removeListener(
      _onConditionTypeChange,
    );
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
