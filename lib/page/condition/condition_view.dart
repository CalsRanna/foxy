import 'package:flutter/material.dart';
import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ConditionView extends StatefulWidget {
  final Map<String, dynamic>? credential;
  const ConditionView({super.key, this.credential});

  @override
  State<ConditionView> createState() => _ConditionViewState();
}

class _ConditionViewState extends State<ConditionView> {
  final viewModel = GetIt.instance.get<ConditionDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(credential: widget.credential);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      // 复合主键语义列：仅编辑态锁定；新建可填
      final pkReadOnly = viewModel.isExisting.value;
      return _buildForm(pkReadOnly: pkReadOnly);
    });
  }

  Widget _buildForm({required bool pkReadOnly}) {
    final sourceTypeInput = FoxyFormItem(
      label: '源类型/关联',
      child: FoxyShadSelect<int>(
        fieldController: viewModel.sourceTypeOrReferenceIdController,
        options: kConditionSourceTypeLabels,
        placeholder: const Text('SourceTypeOrReferenceId'),
        enabled: !pkReadOnly,
      ),
    );
    final sourceGroupInput = FoxyFormItem(
      label: '来源组',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceGroup',
        fieldController: viewModel.sourceGroupController,
        readOnly: pkReadOnly,
      ),
    );
    final sourceEntryInput = FoxyFormItem(
      label: '来源条目',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceEntry',
        fieldController: viewModel.sourceEntryController,
        readOnly: pkReadOnly,
      ),
    );
    final sourceIdInput = FoxyFormItem(
      label: '来源ID',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceId',
        fieldController: viewModel.sourceIdController,
        readOnly: pkReadOnly,
      ),
    );
    final elseGroupInput = FoxyFormItem(
      label: '否则组',
      child: FoxyNumberInput<int>(
        placeholder: 'ElseGroup',
        fieldController: viewModel.elseGroupController,
        readOnly: pkReadOnly,
      ),
    );

    // 条件信息
    final conditionTypeInput = FoxyFormItem(
      label: '条件类型/关联',
      child: FoxyShadSelect<int>(
        fieldController: viewModel.conditionTypeOrReferenceController,
        options: kConditionTypeLabels,
        placeholder: const Text('ConditionTypeOrReference'),
        maxHeight: 320,
        enabled: !pkReadOnly,
      ),
    );
    final conditionTargetInput = FoxyFormItem(
      label: '条件目标',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionTarget',
        fieldController: viewModel.conditionTargetController,
        readOnly: pkReadOnly,
      ),
    );
    final negativeConditionInput = FoxyFormItem(
      label: '否定条件',
      child: FoxyNumberInput<int>(
        placeholder: 'NegativeCondition',
        fieldController: viewModel.negativeConditionController,
      ),
    );

    // 参数1/2/3 属于完整主键：编辑只读，新建可改
    final valueInputs = Watch((_) {
      final type = viewModel.selectedConditionType.value;
      final cfg = conditionValueConfig(type);
      final pkLocked = viewModel.isExisting.value;
      final value1Input = _buildValue1Input(cfg, viewModel, readOnly: pkLocked);
      final value2Input = FoxyFormItem(
        label: cfg.displayLabel2,
        child: FoxyNumberInput<int>(
          placeholder: 'ConditionValue2',
          fieldController: viewModel.conditionValue2Controller,
          readOnly: pkLocked,
        ),
      );
      final value3Input = FoxyFormItem(
        label: cfg.displayLabel3,
        child: FoxyNumberInput<int>(
          placeholder: 'ConditionValue3',
          fieldController: viewModel.conditionValue3Controller,
          readOnly: pkLocked,
        ),
      );
      return Row(
        spacing: 8,
        children: [
          Expanded(child: value1Input),
          Expanded(child: value2Input),
          Expanded(child: value3Input),
          Expanded(child: SizedBox()),
        ],
      );
    });

    // 错误与脚本
    final errorTypeInput = FoxyFormItem(
      label: '错误类型',
      child: FoxyNumberInput<int>(
        placeholder: 'ErrorType',
        fieldController: viewModel.errorTypeController,
      ),
    );
    final errorTextIdInput = FoxyFormItem(
      label: '错误文本编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ErrorTextId',
        fieldController: viewModel.errorTextIdController,
      ),
    );
    final scriptNameInput = FoxyFormItem(
      label: '脚本名称',
      child: FoxyStringInput(
        controller: viewModel.scriptNameController,
        placeholder: 'ScriptName',
      ),
    );
    final commentInput = FoxyFormItem(
      label: '注解',
      child: FoxyStringInput(
        controller: viewModel.commentController,
        placeholder: 'Comment',
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '来源信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: sourceTypeInput),
                  Expanded(child: sourceGroupInput),
                  Expanded(child: sourceEntryInput),
                  Expanded(child: sourceIdInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: elseGroupInput),
                  Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '条件信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: conditionTypeInput),
                  Expanded(child: conditionTargetInput),
                  Expanded(child: negativeConditionInput),
                  Expanded(child: SizedBox()),
                ],
              ),
              valueInputs,
            ],
          ),
          FoxyFormSection(
            title: '错误与脚本',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: errorTypeInput),
                  Expanded(child: errorTextIdInput),
                  Expanded(child: scriptNameInput),
                  Expanded(child: commentInput),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: () => viewModel.pop(),
                child: Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 参数1控件：随条件类型在 entity picker / 数字输入间切换
  Widget _buildValue1Input(
    ConditionValueConfig cfg,
    ConditionDetailViewModel viewModel, {
    required bool readOnly,
  }) {
    switch (cfg.value1Picker) {
      case ConditionValue1Picker.quest:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.questTemplate,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.spell:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.spell,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.item:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.itemTemplate,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.map:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.map,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.area:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.areaTable,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.faction:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.dbcFaction,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.title:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.charTitle,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.creature:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyEntityPicker(
            delegate: FoxyEntityPickerDelegates.creatureTemplate,
            fieldController: viewModel.conditionValue1Controller,
            placeholder: 'ConditionValue1',
            readOnly: readOnly,
          ),
        );
      case ConditionValue1Picker.none:
        return FoxyFormItem(
          label: cfg.label1,
          child: FoxyNumberInput<int>(
            placeholder: 'ConditionValue1',
            fieldController: viewModel.conditionValue1Controller,
            readOnly: readOnly,
          ),
        );
    }
  }
}
