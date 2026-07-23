import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class GameObjectTemplateView extends StatefulWidget {
  final GameObjectTemplateDetailViewModel viewModel;

  const GameObjectTemplateView({super.key, required this.viewModel});

  @override
  State<GameObjectTemplateView> createState() => _GameObjectTemplateViewState();
}

class _GameObjectTemplateViewState extends State<GameObjectTemplateView> {
  GameObjectTemplateDetailViewModel get viewModel => widget.viewModel;

  late final gameObjectLootDelegate = FoxyEntityPickerDelegates.gameObjectLoot;

  @override
  void initState() {
    super.initState();
    viewModel.typeController.addListener(_typeChanged);
  }

  void _typeChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    viewModel.typeController.removeListener(_typeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedEntry = viewModel.persistedKey.value;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
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
                        placeholder: 'entry',
                        controller: viewModel.entryController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '名称',
                      child: FoxyLocalePicker(
                        entry: savedEntry,
                        controller: viewModel.nameController,
                        delegate: FoxyLocalePickerDelegates.gameObjectName,
                        placeholder: 'name',
                        title: '名称',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '使用说明',
                      child: FoxyLocalePicker(
                        entry: savedEntry,
                        controller: viewModel.castBarCaptionController,
                        delegate: FoxyLocalePickerDelegates.gameObjectCaption,
                        placeholder: 'castBarCaption',
                        title: '使用说明',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '鼠标形状',
                      child: FoxyStringInput(
                        controller: viewModel.iconNameController,
                        placeholder: 'IconName',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '类型与外观',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '类型',
                      child: FoxyShadSelect<int>(
                        controller: viewModel.typeController,
                        options: kGameObjectTypeOptions,
                        placeholder: const Text('type'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '外观模型',
                      child: FoxyEntityPicker(
                        delegate:
                            FoxyEntityPickerDelegates.gameObjectDisplayInfo,
                        controller: viewModel.displayIdController,
                        placeholder: 'displayId',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '尺寸',
                      child: FoxyNumberInput<double>(
                        placeholder: 'size',
                        controller: viewModel.sizeController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '未知字段',
                      child: FoxyStringInput(
                        controller: viewModel.unk1Controller,
                        placeholder: 'unk1',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '动态数据',
            children: [
              _dataRow(
                _dataInput(0, viewModel.data0Controller),
                _dataInput(1, viewModel.data1Controller),
                _dataInput(2, viewModel.data2Controller),
                _dataInput(3, viewModel.data3Controller),
              ),
              _dataRow(
                _dataInput(4, viewModel.data4Controller),
                _dataInput(5, viewModel.data5Controller),
                _dataInput(6, viewModel.data6Controller),
                _dataInput(7, viewModel.data7Controller),
              ),
              _dataRow(
                _dataInput(8, viewModel.data8Controller),
                _dataInput(9, viewModel.data9Controller),
                _dataInput(10, viewModel.data10Controller),
                _dataInput(11, viewModel.data11Controller),
              ),
              _dataRow(
                _dataInput(12, viewModel.data12Controller),
                _dataInput(13, viewModel.data13Controller),
                _dataInput(14, viewModel.data14Controller),
                _dataInput(15, viewModel.data15Controller),
              ),
              _dataRow(
                _dataInput(16, viewModel.data16Controller),
                _dataInput(17, viewModel.data17Controller),
                _dataInput(18, viewModel.data18Controller),
                _dataInput(19, viewModel.data19Controller),
              ),
              _dataRow(
                _dataInput(20, viewModel.data20Controller),
                _dataInput(21, viewModel.data21Controller),
                _dataInput(22, viewModel.data22Controller),
                _dataInput(23, viewModel.data23Controller),
              ),
            ],
          ),
          FoxyFormSection(
            title: 'AI与脚本',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: 'AI',
                      child: FoxyStringInput(
                        controller: viewModel.aiNameController,
                        placeholder: 'AIName',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '脚本',
                      child: FoxyStringInput(
                        controller: viewModel.scriptNameController,
                        placeholder: 'ScriptName',
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'VerifiedBuild',
                      child: FoxyNumberInput<int>(
                        placeholder: 'VerifiedBuild',
                        controller: viewModel.verifiedBuildController,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: const Text('保存'),
                ),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(onPressed: _goBack, child: const Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dataRow(Widget first, Widget second, Widget third, Widget fourth) {
    return Row(
      spacing: 8,
      children: [
        Expanded(child: first),
        Expanded(child: second),
        Expanded(child: third),
        Expanded(child: fourth),
      ],
    );
  }

  FoxyFormItem _dataInput(int index, IntFieldController controller) {
    final config = gameObjectDataFieldConfig(
      viewModel.typeController.collect(),
      index,
    );
    return FoxyFormItem(
      label: '${config.label} (Data$index)',
      child: _dataEditor(config, controller, index),
    );
  }

  Widget _dataEditor(
    GameObjectDataFieldConfig config,
    IntFieldController controller,
    int index,
  ) {
    final delegate = switch (config.reference) {
      GameObjectDataReference.area => FoxyEntityPickerDelegates.areaTable,
      GameObjectDataReference.cinematicSequence =>
        FoxyEntityPickerDelegates.cinematicSequence,
      GameObjectDataReference.creatureTemplate =>
        FoxyEntityPickerDelegates.creatureTemplate,
      GameObjectDataReference.destructibleModelData =>
        FoxyEntityPickerDelegates.destructibleModelData,
      GameObjectDataReference.gameObjectLoot => gameObjectLootDelegate,
      GameObjectDataReference.gameObjectDisplayInfo =>
        FoxyEntityPickerDelegates.gameObjectDisplayInfo,
      GameObjectDataReference.gameObjectTemplate =>
        FoxyEntityPickerDelegates.gameObjectTemplate,
      GameObjectDataReference.gossipMenu =>
        FoxyEntityPickerDelegates.gossipMenu,
      GameObjectDataReference.lock => FoxyEntityPickerDelegates.lock,
      GameObjectDataReference.map => FoxyEntityPickerDelegates.map,
      GameObjectDataReference.pageText => FoxyEntityPickerDelegates.pageText,
      GameObjectDataReference.questTemplate =>
        FoxyEntityPickerDelegates.questTemplate,
      GameObjectDataReference.spell => FoxyEntityPickerDelegates.spell,
      GameObjectDataReference.spellFocusObject =>
        FoxyEntityPickerDelegates.spellFocusObject,
      GameObjectDataReference.taxiPath => FoxyEntityPickerDelegates.taxiPath,
      GameObjectDataReference.none => null,
    };
    if (delegate != null) {
      return FoxyEntityPicker(
        delegate: delegate,
        controller: controller,
        placeholder: 'Data$index',
        readOnly: !config.editable,
      );
    }
    if (config.options != null) {
      return FoxyIntShadSelect(
        controller: controller,
        options: config.options!,
        placeholder: Text('Data$index'),
        enabled: config.editable,
      );
    }
    return FoxyNumberInput<int>(
      placeholder: 'Data$index',
      controller: controller,
      readOnly: !config.editable,
    );
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '游戏对象 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('模板数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }
}
