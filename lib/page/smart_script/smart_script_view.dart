import 'package:flutter/material.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_form_section.dart';
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
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '实体编号',
              placeholder: 'entryorguid',
              child: FoxyNumberInput<int>(
                controller: viewModel.entryOrGuidController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '源类型',
              placeholder: 'source_type',
              child: FoxyNumberInput<int>(
                controller: viewModel.sourceTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'ID',
              placeholder: 'id',
              child: FoxyNumberInput<int>(controller: viewModel.idController),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '链接',
              placeholder: 'link',
              child: FoxyNumberInput<int>(controller: viewModel.linkController),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
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
            child: FoxyFormItem(
              label: '事件类型',
              placeholder: 'event_type',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '阶段掩码',
              placeholder: 'event_phase_mask',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventPhaseMaskController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '触发几率',
              placeholder: 'event_chance',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventChanceController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件标识',
              placeholder: 'event_flags',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventFlagsController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '事件参数1',
              placeholder: 'event_param1',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventParam1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件参数2',
              placeholder: 'event_param2',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventParam2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件参数3',
              placeholder: 'event_param3',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventParam3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件参数4',
              placeholder: 'event_param4',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventParam4Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '事件参数5',
              placeholder: 'event_param5',
              child: FoxyNumberInput<int>(
                controller: viewModel.eventParam5Controller,
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
            child: FoxyFormItem(
              label: '动作类型',
              placeholder: 'action_type',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数1',
              placeholder: 'action_param1',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionParam1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数2',
              placeholder: 'action_param2',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionParam2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数3',
              placeholder: 'action_param3',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionParam3Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '动作参数4',
              placeholder: 'action_param4',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionParam4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数5',
              placeholder: 'action_param5',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionParam5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数6',
              placeholder: 'action_param6',
              child: FoxyNumberInput<int>(
                controller: viewModel.actionParam6Controller,
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
            child: FoxyFormItem(
              label: '目标类型',
              placeholder: 'target_type',
              child: FoxyNumberInput<int>(
                controller: viewModel.targetTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标参数1',
              placeholder: 'target_param1',
              child: FoxyNumberInput<int>(
                controller: viewModel.targetParam1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标参数2',
              placeholder: 'target_param2',
              child: FoxyNumberInput<int>(
                controller: viewModel.targetParam2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标参数3',
              placeholder: 'target_param3',
              child: FoxyNumberInput<int>(
                controller: viewModel.targetParam3Controller,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '目标参数4',
              placeholder: 'target_param4',
              child: FoxyNumberInput<int>(
                controller: viewModel.targetParam4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'X坐标',
              placeholder: 'target_x',
              child: FoxyNumberInput<double>(
                controller: viewModel.targetXController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'Y坐标',
              placeholder: 'target_y',
              child: FoxyNumberInput<double>(
                controller: viewModel.targetYController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'Z坐标',
              placeholder: 'target_z',
              child: FoxyNumberInput<double>(
                controller: viewModel.targetZController,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '朝向',
              placeholder: 'target_o',
              child: FoxyNumberInput<double>(
                controller: viewModel.targetOController,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基础信息', children: basicRows),
          FoxyFormSection(title: '事件参数', children: eventRows),
          FoxyFormSection(title: '动作参数', children: actionRows),
          FoxyFormSection(title: '目标参数', children: targetRows),
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
