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
  final _repository = GetIt.instance.get<ConditionRepository>();

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

  final condition = signal<ConditionEntity?>(null);
  Map<String, dynamic>? _originalCredential;

  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    if (credential == null) return;
    _originalCredential = credential;
    try {
      final result = await _repository.getCondition(credential);
      condition.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载条件失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(ConditionEntity c) {
    sourceTypeOrReferenceIdController.text = _fmt(c.sourceTypeOrReferenceId);
    sourceGroupController.text = _fmt(c.sourceGroup);
    sourceEntryController.text = _fmt(c.sourceEntry);
    sourceIdController.text = _fmt(c.sourceId);
    elseGroupController.text = _fmt(c.elseGroup);
    conditionTypeOrReferenceController.text = _fmt(c.conditionTypeOrReference);
    conditionTargetController.text = _fmt(c.conditionTarget);
    conditionValue1Controller.text = _fmt(c.conditionValue1);
    conditionValue2Controller.text = _fmt(c.conditionValue2);
    conditionValue3Controller.text = _fmt(c.conditionValue3);
    negativeConditionController.text = _fmt(c.negativeCondition);
    errorTypeController.text = _fmt(c.errorType);
    errorTextIdController.text = _fmt(c.errorTextId);
    scriptNameController.text = c.scriptName;
    commentController.text = c.comment;
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collectFromControllers();
      if (_originalCredential == null) {
        await _repository.storeCondition(data);
      } else {
        await _repository.updateCondition(_originalCredential!, data);
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
      sourceTypeOrReferenceId: _pi(sourceTypeOrReferenceIdController.text),
      sourceGroup: _pi(sourceGroupController.text),
      sourceEntry: _pi(sourceEntryController.text),
      sourceId: _pi(sourceIdController.text),
      elseGroup: _pi(elseGroupController.text),
      conditionTypeOrReference: _pi(conditionTypeOrReferenceController.text),
      conditionTarget: _pi(conditionTargetController.text),
      conditionValue1: _pi(conditionValue1Controller.text),
      conditionValue2: _pi(conditionValue2Controller.text),
      conditionValue3: _pi(conditionValue3Controller.text),
      negativeCondition: _pi(negativeConditionController.text),
      errorType: _pi(errorTypeController.text),
      errorTextId: _pi(errorTextIdController.text),
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
    commentController.dispose();
    conditionTargetController.dispose();
    conditionTypeOrReferenceController.dispose();
    conditionValue1Controller.dispose();
    conditionValue2Controller.dispose();
    conditionValue3Controller.dispose();
    elseGroupController.dispose();
    errorTextIdController.dispose();
    errorTypeController.dispose();
    negativeConditionController.dispose();
    scriptNameController.dispose();
    sourceEntryController.dispose();
    sourceGroupController.dispose();
    sourceIdController.dispose();
    sourceTypeOrReferenceIdController.dispose();
  }
}
