import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 生物模板附加数据Tab
class CreatureTemplateAddonView extends StatefulWidget {
  final int creatureId;

  const CreatureTemplateAddonView({super.key, required this.creatureId});

  @override
  State<CreatureTemplateAddonView> createState() =>
      _CreatureTemplateAddonViewState();
}

class _CreatureTemplateAddonViewState extends State<CreatureTemplateAddonView> {
  final viewModel = GetIt.instance.get<CreatureTemplateAddonViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(creatureId: widget.creatureId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          ShadCard(
            padding: EdgeInsets.all(20),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: FoxyFormItem(
                        label: '编号',
                        child: FoxyNumberInput<int>(
                          fieldController: viewModel.creatureIdController,
                          placeholder: 'entry',
                          readOnly: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '路径ID',
                        child: FoxyNumberInput<int>(
                          fieldController: viewModel.pathIdController,
                          placeholder: 'path_id',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '坐骑编号',
                        child: FoxyNumberInput<int>(
                          fieldController: viewModel.mountController,
                          placeholder: 'mount',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '表情',
                        child: FoxyNumberInput<int>(
                          fieldController: viewModel.emoteController,
                          placeholder: 'emote',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: FoxyFormItem(
                        label: '覆盖标识1',
                        child: FoxyNumberInput<int>(
                          fieldController: viewModel.bytes1Controller,
                          placeholder: 'bytes1',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '覆盖标识2',
                        child: FoxyNumberInput<int>(
                          fieldController: viewModel.bytes2Controller,
                          placeholder: 'bytes2',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '可见距离类型',
                        child: FoxyNumberInput<int>(
                          fieldController:
                              viewModel.visibilityDistanceTypeController,
                          placeholder: 'visibilityDistanceType',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '光环列表',
                        child: FoxyStringInput(
                          controller: viewModel.aurasController,
                          placeholder: 'auras',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
