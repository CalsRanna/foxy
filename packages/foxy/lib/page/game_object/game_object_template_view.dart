import 'package:flutter/material.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/game_object_template_detail_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class GameObjectTemplateView extends StatelessWidget {
  static final gameObjectLootDelegate =
      FoxyEntityPickerDelegates.gameObjectLoot;
  final GameObjectTemplateDetailViewModel viewModel;

  const GameObjectTemplateView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
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
                          options: GameObjectConstants.gameObjectTypeOptions,
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
                        label: '验证版本',
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
    });
  }

  Widget _dataEditor(
    IntegerFieldSpec<GameObjectDataReference> spec,
    IntFieldControllerGroup controllers,
    int index,
  ) {
    final column = 'Data$index';
    return switch (spec) {
      IntegerNumberFieldSpec() => FoxyNumberInput<int>(
        controller: controllers.numberController,
        placeholder: column,
        readOnly: !spec.editable,
      ),
      IntegerSelectFieldSpec(:final options) => FoxyShadSelect<int>(
        controller: controllers.selectController,
        options: options,
        placeholder: Text(column),
        enabled: spec.editable,
      ),
      IntegerFlagsFieldSpec(:final flags) => FoxyFlagPicker(
        controller: controllers.flagController,
        flags: flags,
        title: spec.label,
        placeholder: column,
      ),
      IntegerReferenceFieldSpec(:final reference) => switch (reference) {
        GameObjectDataReference.area => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.areaTable,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.cinematicSequence => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.cinematicSequence,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.creatureTemplate => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.creatureTemplate,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.destructibleModelData => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.destructibleModelData,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.gameObjectLoot => _referencePicker(
          column,
          controllers,
          gameObjectLootDelegate,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.gameObjectDisplayInfo => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.gameObjectDisplayInfo,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.gameObjectTemplate => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.gameObjectTemplate,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.gossipMenu => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.gossipMenu,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.lock => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.lock,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.map => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.map,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.pageText => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.pageText,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.questTemplate => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.questTemplate,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.spell => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.spell,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.spellFocusObject => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.spellFocusObject,
          readOnly: !spec.editable,
        ),
        GameObjectDataReference.taxiPath => _referencePicker(
          column,
          controllers,
          FoxyEntityPickerDelegates.taxiPath,
          readOnly: !spec.editable,
        ),
        // The sealed spec guarantees the reference branch always carries a
        // real reference; none can only come from a config error, so expose
        // it instead of rendering silently.
        GameObjectDataReference.none => throw ArgumentError(
          '$reference is not a valid reference spec',
        ),
      },
    };
  }

  FoxyFormItem _dataInput(int index, IntFieldControllerGroup controllers) {
    final spec = GameObjectConstants.dataFieldSpec(
      viewModel.selectedType.value,
      index,
    );
    return FoxyFormItem(
      label: spec.label,
      child: _dataEditor(spec, controllers, index),
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

  /// Reference-field picker built from [delegate]: the concrete row type
  /// follows from the delegate, so each reference branch instantiates the
  /// picker at the call site with no type erasure.
  Widget _referencePicker<T>(
    String column,
    IntFieldControllerGroup controllers,
    FoxyEntityPickerDelegate<T> delegate, {
    required bool readOnly,
  }) {
    return FoxyEntityPicker<T>(
      controller: controllers.numberController,
      delegate: delegate,
      placeholder: column,
      readOnly: readOnly,
    );
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('模板数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyExceptions.message(error))));
    }
  }
}
