import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'smart_script_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: SmartScriptEntity,
  selects: {'sourceType': 0, 'eventType': 0, 'actionType': 0, 'targetType': 0},
  flags: {'eventPhaseMask', 'eventFlags'},
  groups: {
    'eventParam1',
    'eventParam2',
    'eventParam3',
    'eventParam4',
    'eventParam5',
    'eventParam6',
    'actionParam1',
    'actionParam2',
    'actionParam3',
    'actionParam4',
    'actionParam5',
    'actionParam6',
    'targetParam1',
    'targetParam2',
    'targetParam3',
    'targetParam4',
  },
  repository: SmartScriptRepository,
)
class SmartScriptDetailViewModel
    with FieldControllerMixin, _SmartScriptDetailViewModelMixin {

  /// Currently selected four discriminator types; drive each parameter
  /// group's edit specs
  final selectedSourceType = signal(0);
  final selectedEventType = signal(0);
  final selectedActionType = signal(0);
  final selectedTargetType = signal(0);

  @override
  void dispose() {
    sourceTypeController.removeListener(_onSourceTypeChange);
    eventTypeController.removeListener(_onEventTypeChange);
    actionTypeController.removeListener(_onActionTypeChange);
    targetTypeController.removeListener(_onTargetTypeChange);
    disposeControllers();
  }

  @override
  Future<void> initSignals({SmartScriptKey? key}) async {
    loading.value = true;
    errorMessage.value = null;
    sourceTypeController.addListener(_onSourceTypeChange);
    eventTypeController.addListener(_onEventTypeChange);
    actionTypeController.addListener(_onActionTypeChange);
    targetTypeController.addListener(_onTargetTypeChange);
    try {
      if (key == null) {
        final blank = await _repository.createSmartScript();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getSmartScript(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
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

  @override
  void _afterApplyCandidate(SmartScriptEntity smartScript) {
    // Explicitly refresh the edit specs once, independent of the type
    // controller listener callback order.
    _refreshParamEditors();
  }


  void _onActionTypeChange() {
    selectedActionType.value = actionTypeController.collect();
    _refreshActionEditors();
  }

  void _onEventTypeChange() {
    selectedEventType.value = eventTypeController.collect();
    _refreshEventEditors();
  }

  void _onSourceTypeChange() {
    selectedSourceType.value = sourceTypeController.collect();
    // source type decides the event-type options; refresh the event
    // parameter specs to keep them in sync.
    _refreshEventEditors();
  }

  void _onTargetTypeChange() {
    selectedTargetType.value = targetTypeController.collect();
    _refreshTargetEditors();
  }

  void _refreshActionEditors() {
    final config = smartActionParameterConfig(selectedActionType.value);
    actionParam1Controller.configure(config.param1.editor);
    actionParam2Controller.configure(config.param2.editor);
    actionParam3Controller.configure(config.param3.editor);
    actionParam4Controller.configure(config.param4.editor);
    actionParam5Controller.configure(config.param5.editor);
    actionParam6Controller.configure(config.param6.editor);
  }

  void _refreshEventEditors() {
    final config = smartEventParameterConfig(selectedEventType.value);
    eventParam1Controller.configure(config.param1.editor);
    eventParam2Controller.configure(config.param2.editor);
    eventParam3Controller.configure(config.param3.editor);
    eventParam4Controller.configure(config.param4.editor);
    eventParam5Controller.configure(config.param5.editor);
    eventParam6Controller.configure(config.param6.editor);
  }

  void _refreshParamEditors() {
    _refreshEventEditors();
    _refreshActionEditors();
    _refreshTargetEditors();
  }

  void _refreshTargetEditors() {
    final config = smartTargetParameterConfig(selectedTargetType.value);
    targetParam1Controller.configure(config.param1.editor);
    targetParam2Controller.configure(config.param2.editor);
    targetParam3Controller.configure(config.param3.editor);
    targetParam4Controller.configure(config.param4.editor);
  }
}
