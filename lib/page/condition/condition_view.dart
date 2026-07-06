import 'package:flutter/material.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    // 来源信息
    final sourceTypeInput = FoxyFormItem(
      label: '源类型/关联',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceTypeOrReferenceId',
        controller: viewModel.sourceTypeOrReferenceIdController,
      ),
    );
    final sourceGroupInput = FoxyFormItem(
      label: 'SourceGroup',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceGroup',
        controller: viewModel.sourceGroupController,
      ),
    );
    final sourceEntryInput = FoxyFormItem(
      label: 'SourceEntry',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceEntry',
        controller: viewModel.sourceEntryController,
      ),
    );
    final sourceIdInput = FoxyFormItem(
      label: 'SourceId',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceId',
        controller: viewModel.sourceIdController,
      ),
    );
    final elseGroupInput = FoxyFormItem(
      label: 'ElseGroup',
      child: FoxyNumberInput<int>(
        placeholder: 'ElseGroup',
        controller: viewModel.elseGroupController,
      ),
    );

    // 条件信息
    final conditionTypeInput = FoxyFormItem(
      label: '条件类型/关联',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionTypeOrReference',
        controller: viewModel.conditionTypeOrReferenceController,
      ),
    );
    final conditionTargetInput = FoxyFormItem(
      label: 'ConditionTarget',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionTarget',
        controller: viewModel.conditionTargetController,
      ),
    );
    final conditionValue1Input = FoxyFormItem(
      label: 'ConditionValue1',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionValue1',
        controller: viewModel.conditionValue1Controller,
      ),
    );
    final conditionValue2Input = FoxyFormItem(
      label: 'ConditionValue2',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionValue2',
        controller: viewModel.conditionValue2Controller,
      ),
    );
    final conditionValue3Input = FoxyFormItem(
      label: 'ConditionValue3',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionValue3',
        controller: viewModel.conditionValue3Controller,
      ),
    );
    final negativeConditionInput = FoxyFormItem(
      label: '否定条件',
      child: FoxyNumberInput<int>(
        placeholder: 'NegativeCondition',
        controller: viewModel.negativeConditionController,
      ),
    );

    // 错误与脚本
    final errorTypeInput = FoxyFormItem(
      label: '错误类型',
      child: FoxyNumberInput<int>(
        placeholder: 'ErrorType',
        controller: viewModel.errorTypeController,
      ),
    );
    final errorTextIdInput = FoxyFormItem(
      label: '错误文本编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ErrorTextId',
        controller: viewModel.errorTextIdController,
      ),
    );
    final scriptNameInput = FoxyFormItem(
      controller: viewModel.scriptNameController,
      label: '脚本名称',
      placeholder: 'ScriptName',
    );
    final commentInput = FoxyFormItem(
      controller: viewModel.commentController,
      label: '注解',
      placeholder: 'Comment',
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
              Row(
                spacing: 8,
                children: [
                  Expanded(child: conditionValue1Input),
                  Expanded(child: conditionValue2Input),
                  Expanded(child: conditionValue3Input),
                  Expanded(child: SizedBox()),
                ],
              ),
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
}
