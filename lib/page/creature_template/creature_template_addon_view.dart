import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
                      child: FormItem(
                        label: '编号',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.creatureIdController,
                          placeholder: 'entry',
                          readOnly: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        label: '路径ID',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.pathIdController,
                          placeholder: 'path_id',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        label: '坐骑编号',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.mountController,
                          placeholder: 'mount',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        label: '表情',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.emoteController,
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
                      child: FormItem(
                        label: '覆盖标识1',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.bytes1Controller,
                          placeholder: 'bytes1',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        label: '覆盖标识2',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.bytes2Controller,
                          placeholder: 'bytes2',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        label: '可见距离类型',
                        child: FoxyNumberInput<int>(
                          controller:
                              viewModel.visibilityDistanceTypeController,
                          placeholder: 'visibilityDistanceType',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        controller: viewModel.aurasController,
                        label: '光环列表',
                        placeholder: 'auras',
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
