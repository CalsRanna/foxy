import 'package:flutter/material.dart';
import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/constant/condition_error_types.dart';
import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ConditionView extends StatelessWidget {
  final ConditionDetailViewModel viewModel;

  const ConditionView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final sourceType = viewModel.selectedSourceType.value;
      final sourceGroup = viewModel.selectedSourceGroup.value;
      final conditionType = viewModel.selectedConditionType.value;
      final conditionValue1 = viewModel.selectedConditionValue1.value;
      final errorType = viewModel.selectedErrorType.value;
      final valueConfig = conditionValueConfig(
        conditionType,
        value1: conditionValue1,
      );
      final referenceCondition = conditionType < 0;
      final referenceTemplate = sourceType < 0;

      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            FoxyFormSection(
              title: '来源信息',
              children: [
                _row(
                  FoxyFormItem(
                    label: '源类型 / 引用模板',
                    child: FoxyIntEnumInput(
                      controller: viewModel.sourceTypeOrReferenceIdController,
                      options: kConditionSourceTypeLabels,
                      placeholder: 'SourceTypeOrReferenceId',
                      title: '来源类型',
                    ),
                  ),
                  _sourceGroupItem(
                    sourceType,
                    referenceTemplate: referenceTemplate,
                  ),
                  _sourceEntryItem(
                    sourceType,
                    sourceGroup,
                    referenceTemplate: referenceTemplate,
                  ),
                  _sourceIdItem(
                    sourceType,
                    referenceTemplate: referenceTemplate,
                  ),
                ),
                _row(
                  _numberItem(
                    '逻辑分组',
                    'ElseGroup',
                    viewModel.elseGroupController,
                  ),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                ),
              ],
            ),
            FoxyFormSection(
              title: '条件信息',
              children: [
                _row(
                  FoxyFormItem(
                    label: '条件类型 / 引用',
                    child: FoxyIntEnumInput(
                      controller: viewModel.conditionTypeOrReferenceController,
                      options: kConditionTypeLabels,
                      placeholder: 'ConditionTypeOrReference',
                      title: '条件类型',
                    ),
                  ),
                  FoxyFormItem(
                    label: '条件目标',
                    child: FoxyIntShadSelect(
                      controller: viewModel.conditionTargetController,
                      options: _targetOptions(sourceType),
                      placeholder: const Text('ConditionTarget'),
                      enabled: !referenceCondition,
                    ),
                  ),
                  FoxyFormItem(
                    label: '否定条件',
                    child: FoxyIntShadSelect(
                      controller: viewModel.negativeConditionController,
                      options: kConditionBooleanOptions,
                      placeholder: const Text('NegativeCondition'),
                      enabled: !referenceCondition,
                    ),
                  ),
                  const SizedBox(),
                ),
                _row(
                  _valueItem(
                    'ConditionValue1',
                    valueConfig.value1,
                    viewModel.conditionValue1Controller,
                  ),
                  _valueItem(
                    'ConditionValue2',
                    valueConfig.value2,
                    viewModel.conditionValue2Controller,
                  ),
                  _valueItem(
                    'ConditionValue3',
                    valueConfig.value3,
                    viewModel.conditionValue3Controller,
                  ),
                  const SizedBox(),
                ),
              ],
            ),
            FoxyFormSection(
              title: '错误与脚本',
              children: [
                _row(
                  FoxyFormItem(
                    label: '法术失败类型',
                    child: FoxyIntShadSelect(
                      controller: viewModel.errorTypeController,
                      options: kConditionErrorTypeOptions,
                      placeholder: const Text('ErrorType'),
                      enabled: sourceType == 17,
                      maxHeight: 360,
                    ),
                  ),
                  FoxyFormItem(
                    label: '自定义错误文本',
                    child: FoxyIntShadSelect(
                      controller: viewModel.errorTextIdController,
                      options: kConditionCustomErrorOptions,
                      placeholder: const Text('ErrorTextId'),
                      enabled: sourceType == 17 && errorType == 172,
                      maxHeight: 360,
                    ),
                  ),
                  FoxyFormItem(
                    label: '脚本名称',
                    child: FoxyStringInput(
                      controller: viewModel.scriptNameController,
                      placeholder: 'ScriptName',
                    ),
                  ),
                  FoxyFormItem(
                    label: '注释',
                    child: FoxyStringInput(
                      controller: viewModel.commentController,
                      placeholder: 'Comment',
                    ),
                  ),
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
    });
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

  Map<int, String> _targetOptions(int sourceType) {
    final count = sourceType < 0 ? 1 : conditionTargetCount(sourceType);
    return {0: '目标 0', if (count > 1) 1: '目标 1', if (count > 2) 2: '目标 2'};
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

  FoxyFormItem _sourceGroupItem(
    int sourceType, {
    required bool referenceTemplate,
  }) {
    if (sourceType == 30) {
      return FoxyFormItem(
        label: '对象类型',
        child: FoxyIntShadSelect(
          controller: viewModel.sourceGroupController,
          options: const {0: '生物', 1: '游戏对象'},
          placeholder: const Text('SourceGroup'),
          enabled: !referenceTemplate,
        ),
      );
    }
    final label = switch (sourceType) {
      >= 1 && <= 12 || 28 => '掉落模板 Entry',
      13 => '效果掩码',
      14 => '对话菜单 ID',
      15 => '对话菜单 ID',
      18 || 21 => '生物 Entry',
      20 => '对话菜单 ID',
      22 => 'SmartAI 事件 ID',
      23 => '商人生物 Entry',
      _ => '来源组',
    };
    final canEdit = kConditionSourceTypesWithGroup.contains(sourceType);
    return _numberItem(
      label,
      'SourceGroup',
      viewModel.sourceGroupController,
      readOnly: referenceTemplate || !canEdit,
    );
  }

  FoxyFormItem _sourceEntryItem(
    int sourceType,
    int sourceGroup, {
    required bool referenceTemplate,
  }) {
    final delegate = switch (sourceType) {
      13 || 17 || 18 || 21 || 24 => FoxyEntityPickerDelegates.spell,
      16 || 20 || 29 => FoxyEntityPickerDelegates.creatureTemplate,
      19 => FoxyEntityPickerDelegates.questTemplate,
      23 => FoxyEntityPickerDelegates.itemTemplate,
      30 when sourceGroup == 0 => FoxyEntityPickerDelegates.creatureTemplate,
      30 when sourceGroup == 1 => FoxyEntityPickerDelegates.gameObjectTemplate,
      _ => null,
    };
    final label = switch (sourceType) {
      >= 1 && <= 12 || 28 => '物品 / 引用条目',
      13 || 17 || 18 || 21 || 24 => '法术 ID',
      14 => 'NPC 文本 ID',
      15 => '选项 ID',
      16 || 20 || 29 => '生物 Entry',
      19 => '任务 ID',
      22 => 'SmartAI Entry / GUID',
      23 => '物品 ID',
      30 => sourceGroup == 0 ? '生物 Entry' : '游戏对象 Entry',
      _ => '来源条目',
    };
    if (delegate != null) {
      return FoxyFormItem(
        label: label,
        child: FoxyEntityPicker(
          controller: viewModel.sourceEntryController,
          delegate: delegate,
          placeholder: 'SourceEntry',
          readOnly: referenceTemplate,
        ),
      );
    }
    return _numberItem(
      label,
      'SourceEntry',
      viewModel.sourceEntryController,
      readOnly: referenceTemplate,
    );
  }

  FoxyFormItem _sourceIdItem(
    int sourceType, {
    required bool referenceTemplate,
  }) {
    if (sourceType == 22) {
      return FoxyFormItem(
        label: 'SmartAI 来源类型',
        child: FoxyIntShadSelect(
          controller: viewModel.sourceIdController,
          options: kSourceTypes,
          placeholder: const Text('SourceId'),
          enabled: !referenceTemplate,
        ),
      );
    }
    return _numberItem(
      sourceType == 30 ? '生成 GUID' : '来源 ID',
      'SourceId',
      viewModel.sourceIdController,
      readOnly:
          referenceTemplate ||
          !kConditionSourceTypesWithSourceId.contains(sourceType),
    );
  }

  FoxyFormItem _valueItem(
    String column,
    ConditionValueFieldConfig config,
    IntFieldController controller,
  ) {
    final readOnly = !config.editable;
    return FoxyFormItem(
      label: config.label,
      child: _valueEditor(column, config, controller, readOnly: readOnly),
    );
  }

  Widget _valueEditor(
    String column,
    ConditionValueFieldConfig config,
    IntFieldController controller, {
    required bool readOnly,
  }) {
    final delegate = switch (config.reference) {
      ConditionValueReference.achievement =>
        FoxyEntityPickerDelegates.achievement,
      ConditionValueReference.area => FoxyEntityPickerDelegates.areaTable,
      ConditionValueReference.creature =>
        FoxyEntityPickerDelegates.creatureTemplate,
      ConditionValueReference.faction => FoxyEntityPickerDelegates.dbcFaction,
      ConditionValueReference.gameObject =>
        FoxyEntityPickerDelegates.gameObjectTemplate,
      ConditionValueReference.item => FoxyEntityPickerDelegates.itemTemplate,
      ConditionValueReference.map => FoxyEntityPickerDelegates.map,
      ConditionValueReference.quest => FoxyEntityPickerDelegates.questTemplate,
      ConditionValueReference.skill => FoxyEntityPickerDelegates.skillLine,
      ConditionValueReference.spell => FoxyEntityPickerDelegates.spell,
      ConditionValueReference.title => FoxyEntityPickerDelegates.charTitle,
      ConditionValueReference.none => null,
    };
    if (delegate != null) {
      return FoxyEntityPicker(
        controller: controller,
        delegate: delegate,
        placeholder: column,
        readOnly: readOnly,
      );
    }
    if (config.flags != null && !readOnly) {
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
        enabled: !readOnly,
        maxHeight: 360,
      );
    }
    return FoxyNumberInput<int>(
      placeholder: column,
      controller: controller,
      readOnly: readOnly,
    );
  }
}
