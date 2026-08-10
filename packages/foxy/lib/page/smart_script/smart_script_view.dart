import 'package:flutter/material.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/smart_script_detail_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class SmartScriptView extends StatelessWidget {
  final SmartScriptDetailViewModel viewModel;

  const SmartScriptView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final eventConfig = SmartScriptConstants.eventParameterConfig(
        viewModel.selectedEventType.value,
      );
      final actionConfig = SmartScriptConstants.actionParameterConfig(
        viewModel.selectedActionType.value,
      );
      final targetConfig = SmartScriptConstants.targetParameterConfig(
        viewModel.selectedTargetType.value,
      );

      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            FoxyFormSection(
              title: '基础信息',
              children: [
                _row(
                  _numberItem(
                    '实体编号',
                    'entryorguid',
                    viewModel.entryOrGuidController,
                  ),
                  FoxyFormItem(
                    label: '源类型',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.sourceTypeController,
                      options: SmartScriptConstants.sourceTypes,
                      placeholder: const Text('source_type'),
                    ),
                  ),
                  _numberItem('ID', 'id', viewModel.idController),
                  _numberItem('链接事件 ID', 'link', viewModel.linkController),
                ),
                _row(
                  FoxyFormItem(
                    label: '备注',
                    child: FoxyStringInput(
                      controller: viewModel.commentController,
                      placeholder: 'comment',
                    ),
                  ),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                ),
              ],
            ),
            FoxyFormSection(
              title: '事件参数',
              children: [
                _row(
                  FoxyFormItem(
                    label: '事件类型',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.eventTypeController,
                      options: SmartScriptConstants.eventTypesForSource(
                        viewModel.selectedSourceType.value,
                      ),
                      placeholder: const Text('event_type'),
                    ),
                  ),
                  FoxyFormItem(
                    label: '阶段掩码',
                    child: FoxyFlagPicker(
                      controller: viewModel.eventPhaseMaskController,
                      flags: SmartScriptConstants.eventPhaseFlagItems,
                      title: '事件阶段掩码',
                      placeholder: 'event_phase_mask',
                    ),
                  ),
                  _numberItem(
                    '触发几率',
                    'event_chance',
                    viewModel.eventChanceController,
                  ),
                  FoxyFormItem(
                    label: '事件标志',
                    child: FoxyFlagPicker(
                      controller: viewModel.eventFlagsController,
                      flags: SmartScriptConstants.eventFlagItems,
                      title: '事件标志',
                      placeholder: 'event_flags',
                    ),
                  ),
                ),
                _row(
                  _parameterItem(
                    'event_param1',
                    eventConfig.param1,
                    viewModel.eventParam1Controller,
                  ),
                  _parameterItem(
                    'event_param2',
                    eventConfig.param2,
                    viewModel.eventParam2Controller,
                  ),
                  _parameterItem(
                    'event_param3',
                    eventConfig.param3,
                    viewModel.eventParam3Controller,
                  ),
                  _parameterItem(
                    'event_param4',
                    eventConfig.param4,
                    viewModel.eventParam4Controller,
                  ),
                ),
                _row(
                  _parameterItem(
                    'event_param5',
                    eventConfig.param5,
                    viewModel.eventParam5Controller,
                  ),
                  _parameterItem(
                    'event_param6',
                    eventConfig.param6,
                    viewModel.eventParam6Controller,
                  ),
                  const SizedBox(),
                  const SizedBox(),
                ),
              ],
            ),
            FoxyFormSection(
              title: '动作参数',
              children: [
                _row(
                  FoxyFormItem(
                    label: '动作类型',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.actionTypeController,
                      options: SmartScriptConstants.actionTypes,
                      placeholder: const Text('action_type'),
                    ),
                  ),
                  _parameterItem(
                    'action_param1',
                    actionConfig.param1,
                    viewModel.actionParam1Controller,
                  ),
                  _parameterItem(
                    'action_param2',
                    actionConfig.param2,
                    viewModel.actionParam2Controller,
                  ),
                  _parameterItem(
                    'action_param3',
                    actionConfig.param3,
                    viewModel.actionParam3Controller,
                  ),
                ),
                _row(
                  _parameterItem(
                    'action_param4',
                    actionConfig.param4,
                    viewModel.actionParam4Controller,
                  ),
                  _parameterItem(
                    'action_param5',
                    actionConfig.param5,
                    viewModel.actionParam5Controller,
                  ),
                  _parameterItem(
                    'action_param6',
                    actionConfig.param6,
                    viewModel.actionParam6Controller,
                  ),
                  const SizedBox(),
                ),
              ],
            ),
            FoxyFormSection(
              title: '目标参数',
              children: [
                _row(
                  FoxyFormItem(
                    label: '目标类型',
                    child: FoxyShadSelect<int>(
                      controller: viewModel.targetTypeController,
                      options: SmartScriptConstants.targetTypes,
                      placeholder: const Text('target_type'),
                    ),
                  ),
                  _parameterItem(
                    'target_param1',
                    targetConfig.param1,
                    viewModel.targetParam1Controller,
                  ),
                  _parameterItem(
                    'target_param2',
                    targetConfig.param2,
                    viewModel.targetParam2Controller,
                  ),
                  _parameterItem(
                    'target_param3',
                    targetConfig.param3,
                    viewModel.targetParam3Controller,
                  ),
                ),
                _row(
                  _parameterItem(
                    'target_param4',
                    targetConfig.param4,
                    viewModel.targetParam4Controller,
                  ),
                  _doubleItem('X 坐标', 'target_x', viewModel.targetXController),
                  _doubleItem('Y 坐标', 'target_y', viewModel.targetYController),
                  _doubleItem('Z 坐标', 'target_z', viewModel.targetZController),
                ),
                _row(
                  _doubleItem('朝向', 'target_o', viewModel.targetOController),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Watch(
                  (_) => ShadButton(
                    enabled: !viewModel.submitting.value,
                    onPressed: () => _persist(context),
                    child: const Text('保存'),
                  ),
                ),
                ShadButton.ghost(onPressed: _goBack, child: const Text('取消')),
              ],
            ),
          ],
        ),
      );
    });
  }

  /// Reference-field picker built from [delegate]: the concrete row type
  /// follows from the delegate, so each reference branch instantiates the
  /// picker at the call site with no type erasure.
  Widget _referencePicker<T>(
    String column,
    IntFieldControllerGroup controllers,
    FoxyEntityPickerDelegate<T> delegate, {
    required bool readOnly,
  }) {
    return FoxyEntityPicker<T>(
      controller: controllers.numberController,
      delegate: delegate,
      placeholder: column,
      readOnly: readOnly,
    );
  }

  FoxyFormItem _doubleItem(
    String label,
    String column,
    DoubleFieldController controller,
  ) {
    return FoxyFormItem(
      label: label,
      child: FoxyNumberInput<double>(
        placeholder: column,
        controller: controller,
      ),
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  FoxyFormItem _numberItem(
    String label,
    String column,
    IntFieldController controller,
  ) {
    return FoxyFormItem(
      label: label,
      child: FoxyNumberInput<int>(placeholder: column, controller: controller),
    );
  }

  Widget _parameterEditor(
    String column,
    IntegerFieldSpec<SmartParameterReference> spec,
    IntFieldControllerGroup controllers,
  ) {
    return switch (spec) {
      IntegerNumberFieldSpec() => FoxyNumberInput<int>(
        controller: controllers.numberController,
        placeholder: column,
        readOnly: !spec.editable,
      ),
      IntegerSelectFieldSpec(:final options) => FoxyShadSelect<int>(
        controller: controllers.selectController,
        options: options,
        placeholder: Text(column),
        enabled: spec.editable,
      ),
      IntegerFlagsFieldSpec(:final flags) => FoxyFlagPicker(
        controller: controllers.flagController,
        flags: flags,
        title: spec.label,
        placeholder: column,
      ),
      IntegerReferenceFieldSpec(:final reference) => switch (reference) {
        SmartParameterReference.area => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.areaTable,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.cinematicSequence => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.cinematicSequence,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.creature => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.creatureTemplate,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.creatureDisplay => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.creatureDisplayInfo,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.emote => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.dbcEmote,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.factionTemplate => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.dbcFactionTemplate,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.gameObject => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.gameObjectTemplate,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.gossipMenu => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.gossipMenu,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.item => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.itemTemplate,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.map => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.map,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.npcText => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.npcText,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.quest => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.questTemplate,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.spell => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.spell,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.taxiPath => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.taxiPath,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.textEmote => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.emote,
          readOnly: !spec.editable,
        ),
        SmartParameterReference.waypointPath => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.waypointData,
          readOnly: !spec.editable,
        ),
      },
    };
  }

  FoxyFormItem _parameterItem(
    String column,
    IntegerFieldSpec<SmartParameterReference> spec,
    IntFieldControllerGroup controllers,
  ) {
    return FoxyFormItem(
      label: spec.label,
      child: _parameterEditor(column, spec, controllers),
    );
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('脚本数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyError.message(error))));
    }
  }

  Widget _row(Widget first, Widget second, Widget third, Widget fourth) {
    return Row(
      spacing: 8,
      children: [
        Expanded(child: first),
        Expanded(child: second),
        Expanded(child: third),
        Expanded(child: fourth),
      ],
    );
  }
}
