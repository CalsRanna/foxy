import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
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
  final sourceTypeOrReferenceIdController = ShadSelectController<int>();
  final sourceGroupController = TextEditingController();
  final sourceEntryController = TextEditingController();
  final sourceIdController = TextEditingController();
  final elseGroupController = TextEditingController();
  final conditionTypeOrReferenceController = ShadSelectController<int>();
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
  /// 当前选中的条件类型，驱动参数1/2/3 的 label 与控件联动重建
  final selectedConditionType = signal(0);
  Map<String, dynamic>? _originalCredential;

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void _setSelectValue(ShadSelectController<int> controller, int value) =>
      controller.value = {value};

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    // 监听条件类型变化，驱动 View 重建参数区域
    conditionTypeOrReferenceController.addListener(_onConditionTypeChange);
    if (credential == null) return;
    _originalCredential = credential;
    try {
      final result = await _repository.getCondition(
        credential['SourceTypeOrReferenceId'] as int,
        credential['SourceGroup'] as int,
        credential['SourceEntry'] as int,
        credential['SourceId'] as int,
        credential['ElseGroup'] as int,
        credential['ConditionTypeOrReference'] as int,
        credential['ConditionTarget'] as int,
      );
      if (result == null) return;
      condition.value = result;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载条件失败', error: e, stackTrace: s);
    }
  }

  void _onConditionTypeChange() {
    selectedConditionType.value = _getSelectValue(
      conditionTypeOrReferenceController,
    );
  }

  void _initControllers(ConditionEntity c) {
    _setSelectValue(sourceTypeOrReferenceIdController, c.sourceTypeOrReferenceId);
    sourceGroupController.text = _fmt(c.sourceGroup);
    sourceEntryController.text = _fmt(c.sourceEntry);
    sourceIdController.text = _fmt(c.sourceId);
    elseGroupController.text = _fmt(c.elseGroup);
    _setSelectValue(conditionTypeOrReferenceController, c.conditionTypeOrReference);
    selectedConditionType.value = c.conditionTypeOrReference;
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
        final c = _originalCredential!;
        await _repository.updateCondition(
          c['SourceTypeOrReferenceId'] as int,
          c['SourceGroup'] as int,
          c['SourceEntry'] as int,
          c['SourceId'] as int,
          c['ElseGroup'] as int,
          c['ConditionTypeOrReference'] as int,
          c['ConditionTarget'] as int,
          data,
        );
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
      sourceTypeOrReferenceId: _getSelectValue(sourceTypeOrReferenceIdController),
      sourceGroup: _pi(sourceGroupController.text),
      sourceEntry: _pi(sourceEntryController.text),
      sourceId: _pi(sourceIdController.text),
      elseGroup: _pi(elseGroupController.text),
      conditionTypeOrReference: _getSelectValue(conditionTypeOrReferenceController),
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
    conditionTypeOrReferenceController.removeListener(_onConditionTypeChange);
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
