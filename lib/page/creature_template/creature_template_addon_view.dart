import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/creature_template/creature_template_addon_single_editor_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// 生物模板附加数据Tab
class CreatureTemplateAddonView extends StatefulWidget {
  final int creatureId;

  const CreatureTemplateAddonView({super.key, required this.creatureId});

  @override
  State<CreatureTemplateAddonView> createState() =>
      _CreatureTemplateAddonViewState();
}

class _CreatureTemplateAddonViewState extends State<CreatureTemplateAddonView> {
  final viewModel = GetIt.instance
      .get<CreatureTemplateAddonSingleEditorViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant CreatureTemplateAddonView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(parentKey: widget.creatureId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('模板补充数据已保存')));
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
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
                          controller: viewModel.creatureIdController,
                          placeholder: 'entry',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '路径ID',
                        child: FoxyEntityPicker(
                          delegate: FoxyEntityPickerDelegates.waypointData,
                          controller: viewModel.pathIdController,
                          placeholder: 'path_id',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '坐骑编号',
                        child: FoxyEntityPicker(
                          delegate:
                              FoxyEntityPickerDelegates.creatureDisplayInfo,
                          controller: viewModel.mountController,
                          placeholder: 'mount',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '表情',
                        child: FoxyEntityPicker(
                          delegate: FoxyEntityPickerDelegates.dbcEmote,
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
                      child: FoxyFormItem(
                        label: '覆盖标识1',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.bytes1Controller,
                          placeholder: 'bytes1',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '覆盖标识2',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.bytes2Controller,
                          placeholder: 'bytes2',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '可见距离类型',
                        child: FoxyShadSelect<int>(
                          controller:
                              viewModel.visibilityDistanceTypeController,
                          options: kVisibilityDistanceTypeOptions,
                          placeholder: Text('visibilityDistanceType'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '光环列表',
                        child: FoxyStringInput(
                          controller: viewModel.aurasController,
                          placeholder: '以空格分隔的法术 ID',
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
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(),
                  child: Text('保存'),
                ),
              ),
              ShadButton.ghost(onPressed: () => _goBack(), child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }
}
