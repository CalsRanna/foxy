import 'package:flutter/material.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/page/game_object/game_object_template_addon_single_editor_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class GameObjectTemplateAddonView extends StatefulWidget {
  final int gameObjectId;

  const GameObjectTemplateAddonView({super.key, required this.gameObjectId});

  @override
  State<GameObjectTemplateAddonView> createState() =>
      _GameObjectTemplateAddonViewState();
}

class _GameObjectTemplateAddonViewState
    extends State<GameObjectTemplateAddonView> {
  final viewModel = GetIt.instance
      .get<GameObjectTemplateAddonSingleEditorViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant GameObjectTemplateAddonView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameObjectId != widget.gameObjectId) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(parentKey: widget.gameObjectId);
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
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '模板补充',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '编号',
                      child: FoxyNumberInput<int>(
                        placeholder: 'entry',
                        controller: viewModel.gameObjectIdController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '阵营模板',
                      child: FoxyEntityPicker(
                        delegate: FoxyEntityPickerDelegates.dbcFactionTemplate,
                        controller: viewModel.factionController,
                        placeholder: 'faction',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '标志位',
                      child: FoxyFlagPicker(
                        controller: viewModel.flagsController,
                        flags: kGameObjectFlagItems,
                        title: '游戏对象标志位',
                        placeholder: 'flags',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '最小金币',
                      child: FoxyNumberInput<int>(
                        placeholder: 'mingold',
                        controller: viewModel.minGoldController,
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
                      label: '最大金币',
                      child: FoxyNumberInput<int>(
                        placeholder: 'maxgold',
                        controller: viewModel.maxGoldController,
                      ),
                    ),
                  ),
                  Expanded(child: _artKitInput(0, viewModel.artkit0Controller)),
                  Expanded(child: _artKitInput(1, viewModel.artkit1Controller)),
                  Expanded(child: _artKitInput(2, viewModel.artkit2Controller)),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: _artKitInput(3, viewModel.artkit3Controller)),
                  const Expanded(child: SizedBox()),
                  const Expanded(child: SizedBox()),
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
                  child: const Text('保存'),
                ),
              ),
              ShadButton.ghost(onPressed: _goBack, child: const Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  FoxyFormItem _artKitInput(int index, IntFieldController controller) {
    return FoxyFormItem(
      label: 'ArtKit $index',
      child: FoxyEntityPicker(
        delegate: FoxyEntityPickerDelegates.gameObjectArtKit,
        controller: controller,
        placeholder: 'artkit$index',
      ),
    );
  }
}
