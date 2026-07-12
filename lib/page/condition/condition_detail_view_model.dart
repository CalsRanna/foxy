import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
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

  // 主键字段（完整 10 列）
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

  /// 现有记录：完整 10 列主键只读
  final isExisting = signal(false);
  Map<String, dynamic>? _originalCredential;

  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void _setSelectValue(ShadSelectController<int> controller, int value) =>
      controller.value = {value};

  Future<void> initSignals({Map<String, dynamic>? credential}) async {
    conditionTypeOrReferenceController.addListener(_onConditionTypeChange);
    if (credential == null) {
      isExisting.value = false;
      return;
    }
    isExisting.value = true;
    _originalCredential = credential;
    try {
      final result = await _repository.getConditionFromCredential(credential);
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
    _setSelectValue(
      sourceTypeOrReferenceIdController,
      c.sourceTypeOrReferenceId,
    );
    sourceGroupController.text = _fmt(c.sourceGroup);
    sourceEntryController.text = _fmt(c.sourceEntry);
    sourceIdController.text = _fmt(c.sourceId);
    elseGroupController.text = _fmt(c.elseGroup);
    _setSelectValue(
      conditionTypeOrReferenceController,
      c.conditionTypeOrReference,
    );
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
      sourceTypeOrReferenceId: _getSelectValue(
        sourceTypeOrReferenceIdController,
      ),
      sourceGroup: _pi(sourceGroupController.text, 'SourceGroup'),
      sourceEntry: _pi(sourceEntryController.text, 'SourceEntry'),
      sourceId: _pi(sourceIdController.text, 'SourceId'),
      elseGroup: _pi(elseGroupController.text, 'ElseGroup'),
      conditionTypeOrReference: _getSelectValue(
        conditionTypeOrReferenceController,
      ),
      conditionTarget: _pi(conditionTargetController.text, 'ConditionTarget'),
      conditionValue1: _pi(conditionValue1Controller.text, 'ConditionValue1'),
      conditionValue2: _pi(conditionValue2Controller.text, 'ConditionValue2'),
      conditionValue3: _pi(conditionValue3Controller.text, 'ConditionValue3'),
      negativeCondition: _pi(
        negativeConditionController.text,
        'NegativeCondition',
      ),
      errorType: _pi(errorTypeController.text, 'ErrorType'),
      errorTextId: _pi(errorTextIdController.text, 'ErrorTextId'),
      scriptName: scriptNameController.text,
      comment: commentController.text,
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
