import 'package:flutter/material.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
    final isNew = widget.credential == null;

    // 来源信息
    final sourceTypeInput = FormItem(
      controller: viewModel.sourceTypeOrReferenceIdController,
      label: '源类型/关联',
      placeholder: 'SourceTypeOrReferenceId',
    );
    final sourceGroupInput = FormItem(
      controller: viewModel.sourceGroupController,
      label: 'SourceGroup',
      placeholder: 'SourceGroup',
    );
    final sourceEntryInput = FormItem(
      controller: viewModel.sourceEntryController,
      label: 'SourceEntry',
      placeholder: 'SourceEntry',
    );
    final sourceIdInput = FormItem(
      controller: viewModel.sourceIdController,
      label: 'SourceId',
      placeholder: 'SourceId',
    );
    final elseGroupInput = FormItem(
      controller: viewModel.elseGroupController,
      label: 'ElseGroup',
      placeholder: 'ElseGroup',
    );

    // 条件信息
    final conditionTypeInput = FormItem(
      controller: viewModel.conditionTypeOrReferenceController,
      label: '条件类型/关联',
      placeholder: 'ConditionTypeOrReference',
    );
    final conditionTargetInput = FormItem(
      controller: viewModel.conditionTargetController,
      label: 'ConditionTarget',
      placeholder: 'ConditionTarget',
    );
    final conditionValue1Input = FormItem(
      controller: viewModel.conditionValue1Controller,
      label: 'ConditionValue1',
      placeholder: 'ConditionValue1',
    );
    final conditionValue2Input = FormItem(
      controller: viewModel.conditionValue2Controller,
      label: 'ConditionValue2',
      placeholder: 'ConditionValue2',
    );
    final conditionValue3Input = FormItem(
      controller: viewModel.conditionValue3Controller,
      label: 'ConditionValue3',
      placeholder: 'ConditionValue3',
    );
    final negativeConditionInput = FormItem(
      controller: viewModel.negativeConditionController,
      label: '否定条件',
      placeholder: 'NegativeCondition',
    );

    // 错误与脚本
    final errorTypeInput = FormItem(
      controller: viewModel.errorTypeController,
      label: '错误类型',
      placeholder: 'ErrorType',
    );
    final errorTextIdInput = FormItem(
      controller: viewModel.errorTextIdController,
      label: '错误文本编号',
      placeholder: 'ErrorTextId',
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
                onPressed: () => isNew ? viewModel.save(context) : viewModel.update(context),
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
