import 'package:flutter/material.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SmartScriptView extends StatefulWidget {
  const SmartScriptView({super.key});

  @override
  State<SmartScriptView> createState() => _SmartScriptViewState();
}

class _SmartScriptViewState extends State<SmartScriptView> {
  final viewModel = GetIt.instance.get<SmartScriptDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '实体编号',
              placeholder: 'entryorguid',
              child: FoxyNumberInput<int>(
                value: viewModel.entryOrGuid.value,
                onChanged: (v) => viewModel.entryOrGuid.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '源类型',
              placeholder: 'source_type',
              child: FoxyNumberInput<int>(
                value: viewModel.sourceType.value,
                onChanged: (v) => viewModel.sourceType.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'ID',
              placeholder: 'id',
              child: FoxyNumberInput<int>(
                value: viewModel.id.value,
                onChanged: (v) => viewModel.id.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '链接',
              placeholder: 'link',
              child: FoxyNumberInput<int>(
                value: viewModel.link.value,
                onChanged: (v) => viewModel.link.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: viewModel.commentController,
              label: '备注',
              placeholder: 'comment',
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final eventRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '事件类型',
              placeholder: 'event_type',
              child: FoxyNumberInput<int>(
                value: viewModel.eventType.value,
                onChanged: (v) => viewModel.eventType.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '阶段掩码',
              placeholder: 'event_phase_mask',
              child: FoxyNumberInput<int>(
                value: viewModel.eventPhaseMask.value,
                onChanged: (v) => viewModel.eventPhaseMask.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '触发几率',
              placeholder: 'event_chance',
              child: FoxyNumberInput<int>(
                value: viewModel.eventChance.value,
                onChanged: (v) => viewModel.eventChance.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '事件标识',
              placeholder: 'event_flags',
              child: FoxyNumberInput<int>(
                value: viewModel.eventFlags.value,
                onChanged: (v) => viewModel.eventFlags.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '事件参数1',
              placeholder: 'event_param1',
              child: FoxyNumberInput<int>(
                value: viewModel.eventParam1.value,
                onChanged: (v) => viewModel.eventParam1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '事件参数2',
              placeholder: 'event_param2',
              child: FoxyNumberInput<int>(
                value: viewModel.eventParam2.value,
                onChanged: (v) => viewModel.eventParam2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '事件参数3',
              placeholder: 'event_param3',
              child: FoxyNumberInput<int>(
                value: viewModel.eventParam3.value,
                onChanged: (v) => viewModel.eventParam3.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '事件参数4',
              placeholder: 'event_param4',
              child: FoxyNumberInput<int>(
                value: viewModel.eventParam4.value,
                onChanged: (v) => viewModel.eventParam4.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '事件参数5',
              placeholder: 'event_param5',
              child: FoxyNumberInput<int>(
                value: viewModel.eventParam5.value,
                onChanged: (v) => viewModel.eventParam5.value = v,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final actionRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '动作类型',
              placeholder: 'action_type',
              child: FoxyNumberInput<int>(
                value: viewModel.actionType.value,
                onChanged: (v) => viewModel.actionType.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '动作参数1',
              placeholder: 'action_param1',
              child: FoxyNumberInput<int>(
                value: viewModel.actionParam1.value,
                onChanged: (v) => viewModel.actionParam1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '动作参数2',
              placeholder: 'action_param2',
              child: FoxyNumberInput<int>(
                value: viewModel.actionParam2.value,
                onChanged: (v) => viewModel.actionParam2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '动作参数3',
              placeholder: 'action_param3',
              child: FoxyNumberInput<int>(
                value: viewModel.actionParam3.value,
                onChanged: (v) => viewModel.actionParam3.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '动作参数4',
              placeholder: 'action_param4',
              child: FoxyNumberInput<int>(
                value: viewModel.actionParam4.value,
                onChanged: (v) => viewModel.actionParam4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '动作参数5',
              placeholder: 'action_param5',
              child: FoxyNumberInput<int>(
                value: viewModel.actionParam5.value,
                onChanged: (v) => viewModel.actionParam5.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '动作参数6',
              placeholder: 'action_param6',
              child: FoxyNumberInput<int>(
                value: viewModel.actionParam6.value,
                onChanged: (v) => viewModel.actionParam6.value = v,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    final targetRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '目标类型',
              placeholder: 'target_type',
              child: FoxyNumberInput<int>(
                value: viewModel.targetType.value,
                onChanged: (v) => viewModel.targetType.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '目标参数1',
              placeholder: 'target_param1',
              child: FoxyNumberInput<int>(
                value: viewModel.targetParam1.value,
                onChanged: (v) => viewModel.targetParam1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '目标参数2',
              placeholder: 'target_param2',
              child: FoxyNumberInput<int>(
                value: viewModel.targetParam2.value,
                onChanged: (v) => viewModel.targetParam2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '目标参数3',
              placeholder: 'target_param3',
              child: FoxyNumberInput<int>(
                value: viewModel.targetParam3.value,
                onChanged: (v) => viewModel.targetParam3.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '目标参数4',
              placeholder: 'target_param4',
              child: FoxyNumberInput<int>(
                value: viewModel.targetParam4.value,
                onChanged: (v) => viewModel.targetParam4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'X坐标',
              placeholder: 'target_x',
              child: FoxyNumberInput<double>(
                value: viewModel.targetX.value,
                onChanged: (v) => viewModel.targetX.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'Y坐标',
              placeholder: 'target_y',
              child: FoxyNumberInput<double>(
                value: viewModel.targetY.value,
                onChanged: (v) => viewModel.targetY.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: 'Z坐标',
              placeholder: 'target_z',
              child: FoxyNumberInput<double>(
                value: viewModel.targetZ.value,
                onChanged: (v) => viewModel.targetZ.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '朝向',
              placeholder: 'target_o',
              child: FoxyNumberInput<double>(
                value: viewModel.targetO.value,
                onChanged: (v) => viewModel.targetO.value = v,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    Widget section(String title, List<Widget> rows) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 0,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(title),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: rows),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          section('基础信息', basicRows),
          section('事件参数', eventRows),
          section('动作参数', actionRows),
          section('目标参数', targetRows),
          Row(
            spacing: 8,
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
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
