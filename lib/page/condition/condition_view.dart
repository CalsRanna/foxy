import 'package:flutter/material.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
    final sourceTypeInput = FormItem(
      label: '源类型/关联',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceTypeOrReferenceId',
        controller: viewModel.sourceTypeOrReferenceIdController,
      ),
    );
    final sourceGroupInput = FormItem(
      label: 'SourceGroup',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceGroup',
        controller: viewModel.sourceGroupController,
      ),
    );
    final sourceEntryInput = FormItem(
      label: 'SourceEntry',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceEntry',
        controller: viewModel.sourceEntryController,
      ),
    );
    final sourceIdInput = FormItem(
      label: 'SourceId',
      child: FoxyNumberInput<int>(
        placeholder: 'SourceId',
        controller: viewModel.sourceIdController,
      ),
    );
    final elseGroupInput = FormItem(
      label: 'ElseGroup',
      child: FoxyNumberInput<int>(
        placeholder: 'ElseGroup',
        controller: viewModel.elseGroupController,
      ),
    );

    // 条件信息
    final conditionTypeInput = FormItem(
      label: '条件类型/关联',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionTypeOrReference',
        controller: viewModel.conditionTypeOrReferenceController,
      ),
    );
    final conditionTargetInput = FormItem(
      label: 'ConditionTarget',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionTarget',
        controller: viewModel.conditionTargetController,
      ),
    );
    final conditionValue1Input = FormItem(
      label: 'ConditionValue1',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionValue1',
        controller: viewModel.conditionValue1Controller,
      ),
    );
    final conditionValue2Input = FormItem(
      label: 'ConditionValue2',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionValue2',
        controller: viewModel.conditionValue2Controller,
      ),
    );
    final conditionValue3Input = FormItem(
      label: 'ConditionValue3',
      child: FoxyNumberInput<int>(
        placeholder: 'ConditionValue3',
        controller: viewModel.conditionValue3Controller,
      ),
    );
    final negativeConditionInput = FormItem(
      label: '否定条件',
      child: FoxyNumberInput<int>(
        placeholder: 'NegativeCondition',
        controller: viewModel.negativeConditionController,
      ),
    );

    // 错误与脚本
    final errorTypeInput = FormItem(
      label: '错误类型',
      child: FoxyNumberInput<int>(
        placeholder: 'ErrorType',
        controller: viewModel.errorTypeController,
      ),
    );
    final errorTextIdInput = FormItem(
      label: '错误文本编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ErrorTextId',
        controller: viewModel.errorTextIdController,
      ),
    );
    final scriptNameInput = FormItem(
      controller: viewModel.scriptNameController,
      label: '脚本名称',
      placeholder: 'ScriptName',
    );
    final commentInput = FormItem(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('来源信息'),
          ),
          ShadCard(padding: EdgeInsets.all(16), child: Column(spacing: 8, children: [
            Row(spacing: 8, children: [
              Expanded(child: sourceTypeInput),
              Expanded(child: sourceGroupInput),
              Expanded(child: sourceEntryInput),
              Expanded(child: sourceIdInput),
            ]),
            Row(spacing: 8, children: [
              Expanded(child: elseGroupInput),
              Expanded(flex: 3, child: SizedBox()),
            ]),
          ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('条件信息'),
          ),
          ShadCard(padding: EdgeInsets.all(16), child: Column(spacing: 8, children: [
            Row(spacing: 8, children: [
              Expanded(child: conditionTypeInput),
              Expanded(child: conditionTargetInput),
              Expanded(child: negativeConditionInput),
              Expanded(child: SizedBox()),
            ]),
            Row(spacing: 8, children: [
              Expanded(child: conditionValue1Input),
              Expanded(child: conditionValue2Input),
              Expanded(child: conditionValue3Input),
              Expanded(child: SizedBox()),
            ]),
          ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('错误与脚本'),
          ),
          ShadCard(padding: EdgeInsets.all(16), child: Column(spacing: 8, children: [
            Row(spacing: 8, children: [
              Expanded(child: errorTypeInput),
              Expanded(child: errorTextIdInput),
              Expanded(child: scriptNameInput),
              Expanded(child: commentInput),
            ]),
          ])),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(onPressed: () => viewModel.pop(), child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }
}
