import 'package:flutter/material.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
    // 复合主键策略：
    // - entryorguid / source_type：归属键，仅新建可改
    // - id：范围内 MAX+1，始终只读
    // - link：默认 0，始终只读
    return Watch((_) {
      final ownerEditable = viewModel.isNew.value;
      return _buildBody(ownerEditable: ownerEditable);
    });
  }

  Widget _buildBody({required bool ownerEditable}) {
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '实体编号',
              child: FoxyNumberInput<int>(
                placeholder: 'entryorguid',
                controller: viewModel.entryOrGuidController,
                readOnly: !ownerEditable,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '源类型',
              child: FoxyNumberInput<int>(
                placeholder: 'source_type',
                controller: viewModel.sourceTypeController,
                readOnly: !ownerEditable,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'ID',
              child: FoxyNumberInput<int>(
                placeholder: 'id',
                controller: viewModel.idController,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '链接',
              child: FoxyNumberInput<int>(
                placeholder: 'link',
                controller: viewModel.linkController,
                readOnly: true,
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
              label: '备注',
              child: FoxyStringInput(
                controller: viewModel.commentController,
                placeholder: 'comment',
              ),
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
              child: FoxyNumberInput<int>(
                placeholder: 'event_type',
                controller: viewModel.eventTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '阶段掩码',
              child: FoxyNumberInput<int>(
                placeholder: 'event_phase_mask',
                controller: viewModel.eventPhaseMaskController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '触发几率',
              child: FoxyNumberInput<int>(
                placeholder: 'event_chance',
                controller: viewModel.eventChanceController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件标识',
              child: FoxyNumberInput<int>(
                placeholder: 'event_flags',
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
              child: FoxyNumberInput<int>(
                placeholder: 'event_param1',
                controller: viewModel.eventParam1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件参数2',
              child: FoxyNumberInput<int>(
                placeholder: 'event_param2',
                controller: viewModel.eventParam2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件参数3',
              child: FoxyNumberInput<int>(
                placeholder: 'event_param3',
                controller: viewModel.eventParam3Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '事件参数4',
              child: FoxyNumberInput<int>(
                placeholder: 'event_param4',
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
              child: FoxyNumberInput<int>(
                placeholder: 'event_param5',
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
              child: FoxyNumberInput<int>(
                placeholder: 'action_type',
                controller: viewModel.actionTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数1',
              child: FoxyNumberInput<int>(
                placeholder: 'action_param1',
                controller: viewModel.actionParam1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数2',
              child: FoxyNumberInput<int>(
                placeholder: 'action_param2',
                controller: viewModel.actionParam2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数3',
              child: FoxyNumberInput<int>(
                placeholder: 'action_param3',
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
              child: FoxyNumberInput<int>(
                placeholder: 'action_param4',
                controller: viewModel.actionParam4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数5',
              child: FoxyNumberInput<int>(
                placeholder: 'action_param5',
                controller: viewModel.actionParam5Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '动作参数6',
              child: FoxyNumberInput<int>(
                placeholder: 'action_param6',
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
              child: FoxyNumberInput<int>(
                placeholder: 'target_type',
                controller: viewModel.targetTypeController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标参数1',
              child: FoxyNumberInput<int>(
                placeholder: 'target_param1',
                controller: viewModel.targetParam1Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标参数2',
              child: FoxyNumberInput<int>(
                placeholder: 'target_param2',
                controller: viewModel.targetParam2Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '目标参数3',
              child: FoxyNumberInput<int>(
                placeholder: 'target_param3',
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
              child: FoxyNumberInput<int>(
                placeholder: 'target_param4',
                controller: viewModel.targetParam4Controller,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'X坐标',
              child: FoxyNumberInput<double>(
                placeholder: 'target_x',
                controller: viewModel.targetXController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'Y坐标',
              child: FoxyNumberInput<double>(
                placeholder: 'target_y',
                controller: viewModel.targetYController,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: 'Z坐标',
              child: FoxyNumberInput<double>(
                placeholder: 'target_z',
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
              child: FoxyNumberInput<double>(
                placeholder: 'target_o',
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
