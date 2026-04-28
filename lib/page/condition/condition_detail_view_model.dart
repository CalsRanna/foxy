import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/condition.dart';
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
  final sourceTypeOrReferenceIdController = TextEditingController();
  final sourceGroupController = TextEditingController();
  final sourceEntryController = TextEditingController();
  final sourceIdController = TextEditingController();
  final elseGroupController = TextEditingController();
  final conditionTypeOrReferenceController = TextEditingController();
  final conditionTargetController = TextEditingController();
  final conditionValue1Controller = TextEditingController();
  final conditionValue2Controller = TextEditingController();
  final conditionValue3Controller = TextEditingController();

  // 非键字段
  final negativeConditionController = TextEditingController();
  final errorTypeController = TextEditingController();
  final errorTextIdController = TextEditingController();
  final scriptNameController = TextEditingController();
  final commentController = TextEditingController();

  final condition = signal<Condition?>(null);
  final saving = signal(false);
  Map<String, dynamic>? _originalCredential;

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    if (credential == null) return;
    _originalCredential = credential;
    try {
      final result = await repository.getCondition(credential);
      condition.value = result;
      _initControllers(result);
    } catch (e, s) {
      logger.e('加载条件失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(Condition c) {
    sourceTypeOrReferenceIdController.text = c.sourceTypeOrReferenceId.toString();
    sourceGroupController.text = c.sourceGroup.toString();
    sourceEntryController.text = c.sourceEntry.toString();
    sourceIdController.text = c.sourceId.toString();
    elseGroupController.text = c.elseGroup.toString();
    conditionTypeOrReferenceController.text = c.conditionTypeOrReference.toString();
    conditionTargetController.text = c.conditionTarget.toString();
    conditionValue1Controller.text = c.conditionValue1.toString();
    conditionValue2Controller.text = c.conditionValue2.toString();
    conditionValue3Controller.text = c.conditionValue3.toString();
    negativeConditionController.text = c.negativeCondition.toString();
    errorTypeController.text = c.errorType.toString();
    errorTextIdController.text = c.errorTextId.toString();
    scriptNameController.text = c.scriptName;
    commentController.text = c.comment;
  }

  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final data = _collectFromControllers();
      if (_originalCredential == null) {
        await repository.storeCondition(data);
      } else {
        await repository.updateCondition(_originalCredential!, data);
      }
      condition.value = data;
      _logActivity(
        _originalCredential == null ? ActivityActionType.create : ActivityActionType.update,
        data,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('条件已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    } finally {
      saving.value = false;
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Condition _collectFromControllers() {
    final c = Condition();
    c.sourceTypeOrReferenceId = _parseInt(sourceTypeOrReferenceIdController.text);
    c.sourceGroup = _parseInt(sourceGroupController.text);
    c.sourceEntry = _parseInt(sourceEntryController.text);
    c.sourceId = _parseInt(sourceIdController.text);
    c.elseGroup = _parseInt(elseGroupController.text);
    c.conditionTypeOrReference = _parseInt(conditionTypeOrReferenceController.text);
    c.conditionTarget = _parseInt(conditionTargetController.text);
    c.conditionValue1 = _parseInt(conditionValue1Controller.text);
    c.conditionValue2 = _parseInt(conditionValue2Controller.text);
    c.conditionValue3 = _parseInt(conditionValue3Controller.text);
    c.negativeCondition = _parseInt(negativeConditionController.text);
    c.errorType = _parseInt(errorTypeController.text);
    c.errorTextId = _parseInt(errorTextIdController.text);
    c.scriptName = scriptNameController.text;
    c.comment = commentController.text;
    return c;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void _logActivity(ActivityActionType action, Condition c) {
    final log = ActivityLog(
      module: 'conditions',
      actionType: action,
      entityId: c.sourceTypeOrReferenceId,
      entityName: c.comment,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    sourceTypeOrReferenceIdController.dispose();
    sourceGroupController.dispose();
    sourceEntryController.dispose();
    sourceIdController.dispose();
    elseGroupController.dispose();
    conditionTypeOrReferenceController.dispose();
    conditionTargetController.dispose();
    conditionValue1Controller.dispose();
    conditionValue2Controller.dispose();
    conditionValue3Controller.dispose();
    negativeConditionController.dispose();
    errorTypeController.dispose();
    errorTextIdController.dispose();
    scriptNameController.dispose();
    commentController.dispose();
  }
}
