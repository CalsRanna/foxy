import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class ConditionDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = ConditionRepository();

  // 主键字段
  final sourceTypeOrReferenceId = signal<int>(0);
  final sourceGroup = signal<int>(0);
  final sourceEntry = signal<int>(0);
  final sourceId = signal<int>(0);
  final elseGroup = signal<int>(0);
  final conditionTypeOrReference = signal<int>(0);
  final conditionTarget = signal<int>(0);
  final conditionValue1 = signal<int>(0);
  final conditionValue2 = signal<int>(0);
  final conditionValue3 = signal<int>(0);

  // 非键字段
  final negativeCondition = signal<int>(0);
  final errorType = signal<int>(0);
  final errorTextId = signal<int>(0);
  final scriptNameController = TextEditingController();
  final commentController = TextEditingController();

  final condition = signal<ConditionEntity?>(null);
  Map<String, dynamic>? _originalCredential;

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    if (credential == null) return;
    _originalCredential = credential;
    try {
      final result = await repository.getCondition(credential);
      condition.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载条件失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ConditionEntity c) {
    sourceTypeOrReferenceId.value = c.sourceTypeOrReferenceId;
    sourceGroup.value = c.sourceGroup;
    sourceEntry.value = c.sourceEntry;
    sourceId.value = c.sourceId;
    elseGroup.value = c.elseGroup;
    conditionTypeOrReference.value = c.conditionTypeOrReference;
    conditionTarget.value = c.conditionTarget;
    conditionValue1.value = c.conditionValue1;
    conditionValue2.value = c.conditionValue2;
    conditionValue3.value = c.conditionValue3;
    negativeCondition.value = c.negativeCondition;
    errorType.value = c.errorType;
    errorTextId.value = c.errorTextId;
    scriptNameController.text = c.scriptName;
    commentController.text = c.comment;
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      if (_originalCredential == null) {
        await repository.storeCondition(data);
      } else {
        await repository.updateCondition(_originalCredential!, data);
      }
      condition.value = data;
      _logActivity(
        _originalCredential == null
            ? ActivityActionType.create
            : ActivityActionType.update,
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
    final c = ConditionEntity(
      sourceTypeOrReferenceId: sourceTypeOrReferenceId.value,
      sourceGroup: sourceGroup.value,
      sourceEntry: sourceEntry.value,
      sourceId: sourceId.value,
      elseGroup: elseGroup.value,
      conditionTypeOrReference: conditionTypeOrReference.value,
      conditionTarget: conditionTarget.value,
      conditionValue1: conditionValue1.value,
      conditionValue2: conditionValue2.value,
      conditionValue3: conditionValue3.value,
      negativeCondition: negativeCondition.value,
      errorType: errorType.value,
      errorTextId: errorTextId.value,
      scriptName: scriptNameController.text,
      comment: commentController.text,
    );
    return c;
  }

  void _logActivity(ActivityActionType action, ConditionEntity c) {
    final log = ActivityLogEntity(
      module: 'conditions',
      actionType: action,
      entityId: c.sourceTypeOrReferenceId,
      entityName: c.comment,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    scriptNameController.dispose();
    commentController.dispose();
  }
}
