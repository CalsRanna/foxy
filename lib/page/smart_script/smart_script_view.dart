import 'package:flutter/material.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
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
import 'package:signals_flutter/signals_flutter.dart';

class SmartScriptView extends StatefulWidget {
  final int? entryOrGuid;
  final int? sourceType;
  final int? id;
  final int? link;

  const SmartScriptView({
    super.key,
    this.entryOrGuid,
    this.sourceType,
    this.id,
    this.link,
  });

  @override
  State<SmartScriptView> createState() => _SmartScriptViewState();
}

class _SmartScriptViewState extends State<SmartScriptView> {
  final viewModel = GetIt.instance.get<SmartScriptDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.sourceTypeController.addListener(_typeChanged);
    viewModel.eventTypeController.addListener(_typeChanged);
    viewModel.actionTypeController.addListener(_typeChanged);
    viewModel.targetTypeController.addListener(_typeChanged);
    viewModel.initSignals(
      entryOrGuid: widget.entryOrGuid,
      sourceType: widget.sourceType,
      id: widget.id,
      link: widget.link,
    );
  }

  void _typeChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    viewModel.sourceTypeController.removeListener(_typeChanged);
    viewModel.eventTypeController.removeListener(_typeChanged);
    viewModel.actionTypeController.removeListener(_typeChanged);
    viewModel.targetTypeController.removeListener(_typeChanged);
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) => _buildBody(ownerEditable: viewModel.isNew.value));
  }

  Widget _buildBody({required bool ownerEditable}) {
    final eventConfig = smartEventParameterConfig(
      viewModel.eventTypeController.collect(),
    );
    final actionConfig = smartActionParameterConfig(
      viewModel.actionTypeController.collect(),
    );
    final targetConfig = smartTargetParameterConfig(
      viewModel.targetTypeController.collect(),
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
                  readOnly: !ownerEditable,
                ),
                FoxyFormItem(
                  label: '源类型',
                  child: FoxyIntShadSelect(
                    controller: viewModel.sourceTypeController,
                    options: kSourceTypes,
                    placeholder: const Text('source_type'),
                    enabled: ownerEditable,
                  ),
                ),
                _numberItem('ID', 'id', viewModel.idController, readOnly: true),
                _numberItem(
                  '链接事件 ID',
                  'link',
                  viewModel.linkController,
                  readOnly: !ownerEditable,
                ),
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
                  child: FoxyIntShadSelect(
                    controller: viewModel.eventTypeController,
                    options: smartEventTypesForSource(
                      viewModel.sourceTypeController.collect(),
                    ),
                    placeholder: const Text('event_type'),
                  ),
                ),
                FoxyFormItem(
                  label: '阶段掩码',
                  child: FoxyFlagPicker(
                    controller: viewModel.eventPhaseMaskController,
                    flags: kEventPhaseFlagItems,
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
                    flags: kEventFlagItems,
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
                  child: FoxyIntShadSelect(
                    controller: viewModel.actionTypeController,
                    options: kActionTypes,
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
                  child: FoxyIntShadSelect(
                    controller: viewModel.targetTypeController,
                    options: kTargetTypes,
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
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: const Text('保存'),
              ),
              ShadButton.ghost(
                onPressed: viewModel.pop,
                child: const Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
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

  FoxyFormItem _numberItem(
    String label,
    String column,
    IntFieldController controller, {
    bool readOnly = false,
  }) {
    return FoxyFormItem(
      label: label,
      child: FoxyNumberInput<int>(
        placeholder: column,
        controller: controller,
        readOnly: readOnly,
      ),
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

  FoxyFormItem _parameterItem(
    String column,
    SmartParameterFieldConfig config,
    IntFieldController controller,
  ) {
    return FoxyFormItem(
      label: '${config.label} ($column)',
      child: _parameterEditor(column, config, controller),
    );
  }

  Widget _parameterEditor(
    String column,
    SmartParameterFieldConfig config,
    IntFieldController controller,
  ) {
    final delegate = switch (config.reference) {
      SmartParameterReference.area => FoxyEntityPickerDelegates.areaTable,
      SmartParameterReference.cinematicSequence =>
        FoxyEntityPickerDelegates.cinematicSequence,
      SmartParameterReference.creature =>
        FoxyEntityPickerDelegates.creatureTemplate,
      SmartParameterReference.creatureDisplay =>
        FoxyEntityPickerDelegates.creatureDisplayInfo,
      SmartParameterReference.emote => FoxyEntityPickerDelegates.dbcEmote,
      SmartParameterReference.factionTemplate =>
        FoxyEntityPickerDelegates.dbcFactionTemplate,
      SmartParameterReference.gameObject =>
        FoxyEntityPickerDelegates.gameObjectTemplate,
      SmartParameterReference.gossipMenu =>
        FoxyEntityPickerDelegates.gossipMenu,
      SmartParameterReference.item => FoxyEntityPickerDelegates.itemTemplate,
      SmartParameterReference.map => FoxyEntityPickerDelegates.map,
      SmartParameterReference.npcText => FoxyEntityPickerDelegates.npcText,
      SmartParameterReference.quest => FoxyEntityPickerDelegates.questTemplate,
      SmartParameterReference.spell => FoxyEntityPickerDelegates.spell,
      SmartParameterReference.taxiPath => FoxyEntityPickerDelegates.taxiPath,
      SmartParameterReference.textEmote => FoxyEntityPickerDelegates.emote,
      SmartParameterReference.waypointPath =>
        FoxyEntityPickerDelegates.waypointData,
      SmartParameterReference.none => null,
    };
    if (delegate != null) {
      return FoxyEntityPicker(
        controller: controller,
        delegate: delegate,
        placeholder: column,
        readOnly: !config.editable,
      );
    }
    if (config.flags != null) {
      return FoxyFlagPicker(
        controller: controller,
        flags: config.flags!,
        title: config.label,
        placeholder: column,
      );
    }
    if (config.options != null) {
      return FoxyIntShadSelect(
        controller: controller,
        options: config.options!,
        placeholder: Text(column),
        enabled: config.editable,
      );
    }
    return FoxyNumberInput<int>(
      placeholder: column,
      controller: controller,
      readOnly: !config.editable,
    );
  }
}
