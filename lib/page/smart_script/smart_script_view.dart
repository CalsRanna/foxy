import 'package:flutter/material.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    viewModel.initSignals(
      entryOrGuid: widget.entryOrGuid,
      sourceType: widget.sourceType,
      id: widget.id,
      link: widget.link,
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = viewModel;

    final basicRows = [
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.entryOrGuidController, label: '实体编号', placeholder: 'entryorguid')),
        Expanded(child: FormItem(controller: vm.sourceTypeController, label: '源类型', placeholder: 'source_type')),
        Expanded(child: FormItem(controller: vm.idController, label: 'ID', placeholder: 'id')),
        Expanded(child: FormItem(controller: vm.linkController, label: '链接', placeholder: 'link')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.commentController, label: '备注', placeholder: 'comment')),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
      ]),
    ];

    final eventRows = [
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.eventTypeController, label: '事件类型', placeholder: 'event_type')),
        Expanded(child: FormItem(controller: vm.eventPhaseMaskController, label: '阶段掩码', placeholder: 'event_phase_mask')),
        Expanded(child: FormItem(controller: vm.eventChanceController, label: '触发几率', placeholder: 'event_chance')),
        Expanded(child: FormItem(controller: vm.eventFlagsController, label: '事件标识', placeholder: 'event_flags')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.eventParam1Controller, label: '事件参数1', placeholder: 'event_param1')),
        Expanded(child: FormItem(controller: vm.eventParam2Controller, label: '事件参数2', placeholder: 'event_param2')),
        Expanded(child: FormItem(controller: vm.eventParam3Controller, label: '事件参数3', placeholder: 'event_param3')),
        Expanded(child: FormItem(controller: vm.eventParam4Controller, label: '事件参数4', placeholder: 'event_param4')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.eventParam5Controller, label: '事件参数5', placeholder: 'event_param5')),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
      ]),
    ];

    final actionRows = [
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.actionTypeController, label: '动作类型', placeholder: 'action_type')),
        Expanded(child: FormItem(controller: vm.actionParam1Controller, label: '动作参数1', placeholder: 'action_param1')),
        Expanded(child: FormItem(controller: vm.actionParam2Controller, label: '动作参数2', placeholder: 'action_param2')),
        Expanded(child: FormItem(controller: vm.actionParam3Controller, label: '动作参数3', placeholder: 'action_param3')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.actionParam4Controller, label: '动作参数4', placeholder: 'action_param4')),
        Expanded(child: FormItem(controller: vm.actionParam5Controller, label: '动作参数5', placeholder: 'action_param5')),
        Expanded(child: FormItem(controller: vm.actionParam6Controller, label: '动作参数6', placeholder: 'action_param6')),
        Expanded(child: SizedBox()),
      ]),
    ];

    final targetRows = [
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.targetTypeController, label: '目标类型', placeholder: 'target_type')),
        Expanded(child: FormItem(controller: vm.targetParam1Controller, label: '目标参数1', placeholder: 'target_param1')),
        Expanded(child: FormItem(controller: vm.targetParam2Controller, label: '目标参数2', placeholder: 'target_param2')),
        Expanded(child: FormItem(controller: vm.targetParam3Controller, label: '目标参数3', placeholder: 'target_param3')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.targetParam4Controller, label: '目标参数4', placeholder: 'target_param4')),
        Expanded(child: FormItem(controller: vm.targetXController, label: 'X坐标', placeholder: 'target_x')),
        Expanded(child: FormItem(controller: vm.targetYController, label: 'Y坐标', placeholder: 'target_y')),
        Expanded(child: FormItem(controller: vm.targetZController, label: 'Z坐标', placeholder: 'target_z')),
      ]),
      Row(spacing: 8, children: [
        Expanded(child: FormItem(controller: vm.targetOController, label: '朝向', placeholder: 'target_o')),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
      ]),
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
