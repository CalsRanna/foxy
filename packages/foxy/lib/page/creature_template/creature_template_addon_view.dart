import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_template_addon_linked_detail_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Creature-template addon tab
class CreatureTemplateAddonView extends StatefulWidget {
  final int creatureId;

  const CreatureTemplateAddonView({super.key, required this.creatureId});

  @override
  State<CreatureTemplateAddonView> createState() =>
      _CreatureTemplateAddonViewState();
}

class _CreatureTemplateAddonViewState extends State<CreatureTemplateAddonView> {
  final viewModel = GetIt.instance
      .get<CreatureTemplateAddonLinkedDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch(
      (_) => SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            if (viewModel.errorMessage.value != null)
              FoxyInlineError(message: viewModel.errorMessage.value),
            FoxyFormSection(
              title: '基础信息',
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: FoxyFormItem(
                        label: '编号',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.entryController,
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
                  spacing: 8,
                  children: [
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
                    const Expanded(child: SizedBox()),
                    const Expanded(child: SizedBox()),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
            FoxyFormSection(
              title: '覆盖数据',
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: FoxyFormItem(
                        label: '姿态覆盖',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.bytes1Controller,
                          placeholder: 'bytes1',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '武器收纳覆盖',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.bytes2Controller,
                          placeholder: 'bytes2',
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
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
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
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CreatureTemplateAddonView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
      _initialize();
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(linkKey: widget.creatureId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(foxyErrorMessage(error))));
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
      ).show(ShadToast(description: Text(foxyErrorMessage(error))));
    }
  }
}
