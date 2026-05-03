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
      placeholder: 'SourceTypeOrReferenceId',
      child: FoxyNumberInput<int>(
        value: viewModel.sourceTypeOrReferenceId.value,
        onChanged: (v) => viewModel.sourceTypeOrReferenceId.value = v,
      ),
    );
    final sourceGroupInput = FormItem(
      label: 'SourceGroup',
      placeholder: 'SourceGroup',
      child: FoxyNumberInput<int>(
        value: viewModel.sourceGroup.value,
        onChanged: (v) => viewModel.sourceGroup.value = v,
      ),
    );
    final sourceEntryInput = FormItem(
      label: 'SourceEntry',
      placeholder: 'SourceEntry',
      child: FoxyNumberInput<int>(
        value: viewModel.sourceEntry.value,
        onChanged: (v) => viewModel.sourceEntry.value = v,
      ),
    );
    final sourceIdInput = FormItem(
      label: 'SourceId',
      placeholder: 'SourceId',
      child: FoxyNumberInput<int>(
        value: viewModel.sourceId.value,
        onChanged: (v) => viewModel.sourceId.value = v,
      ),
    );
    final elseGroupInput = FormItem(
      label: 'ElseGroup',
      placeholder: 'ElseGroup',
      child: FoxyNumberInput<int>(
        value: viewModel.elseGroup.value,
        onChanged: (v) => viewModel.elseGroup.value = v,
      ),
    );

    // 条件信息
    final conditionTypeInput = FormItem(
      label: '条件类型/关联',
      placeholder: 'ConditionTypeOrReference',
      child: FoxyNumberInput<int>(
        value: viewModel.conditionTypeOrReference.value,
        onChanged: (v) => viewModel.conditionTypeOrReference.value = v,
      ),
    );
    final conditionTargetInput = FormItem(
      label: 'ConditionTarget',
      placeholder: 'ConditionTarget',
      child: FoxyNumberInput<int>(
        value: viewModel.conditionTarget.value,
        onChanged: (v) => viewModel.conditionTarget.value = v,
      ),
    );
    final conditionValue1Input = FormItem(
      label: 'ConditionValue1',
      placeholder: 'ConditionValue1',
      child: FoxyNumberInput<int>(
        value: viewModel.conditionValue1.value,
        onChanged: (v) => viewModel.conditionValue1.value = v,
      ),
    );
    final conditionValue2Input = FormItem(
      label: 'ConditionValue2',
      placeholder: 'ConditionValue2',
      child: FoxyNumberInput<int>(
        value: viewModel.conditionValue2.value,
        onChanged: (v) => viewModel.conditionValue2.value = v,
      ),
    );
    final conditionValue3Input = FormItem(
      label: 'ConditionValue3',
      placeholder: 'ConditionValue3',
      child: FoxyNumberInput<int>(
        value: viewModel.conditionValue3.value,
        onChanged: (v) => viewModel.conditionValue3.value = v,
      ),
    );
    final negativeConditionInput = FormItem(
      label: '否定条件',
      placeholder: 'NegativeCondition',
      child: FoxyNumberInput<int>(
        value: viewModel.negativeCondition.value,
        onChanged: (v) => viewModel.negativeCondition.value = v,
      ),
    );

    // 错误与脚本
    final errorTypeInput = FormItem(
      label: '错误类型',
      placeholder: 'ErrorType',
      child: FoxyNumberInput<int>(
        value: viewModel.errorType.value,
        onChanged: (v) => viewModel.errorType.value = v,
      ),
    );
    final errorTextIdInput = FormItem(
      label: '错误文本编号',
      placeholder: 'ErrorTextId',
      child: FoxyNumberInput<int>(
        value: viewModel.errorTextId.value,
        onChanged: (v) => viewModel.errorTextId.value = v,
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
