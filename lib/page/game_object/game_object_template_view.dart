import 'package:flutter/material.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GameObjectTemplateView extends StatefulWidget {
  final int? entry;
  const GameObjectTemplateView({super.key, this.entry});

  @override
  State<GameObjectTemplateView> createState() => _GameObjectTemplateViewState();
}

class _GameObjectTemplateViewState extends State<GameObjectTemplateView> {
  final viewModel = GetIt.instance.get<GameObjectTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entry: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 基础信息
    final entryInput = FoxyFormItem(
      label: '编号',
      placeholder: 'entry',
      child: FoxyNumberInput<int>(
        controller: viewModel.entryController,
        readOnly: true,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: FoxyLocalePicker(
        entry: widget.entry,
        controller: viewModel.nameController,
        delegate: FoxyLocalePickerDelegates.gameObjectName,
        placeholder: 'name',
        title: '名称',
      ),
    );
    final castBarCaptionInput = FoxyFormItem(
      label: '使用说明',
      child: FoxyLocalePicker(
        entry: widget.entry,
        controller: viewModel.castBarCaptionController,
        delegate: FoxyLocalePickerDelegates.gameObjectCaption,
        placeholder: 'castBarCaption',
        title: '使用说明',
      ),
    );
    final iconNameInput = FoxyFormItem.legacy(
      controller: viewModel.iconNameController,
      label: '鼠标形状',
      placeholder: 'IconName',
    );

    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: entryInput),
          Expanded(child: nameInput),
          Expanded(child: castBarCaptionInput),
          Expanded(child: iconNameInput),
        ],
      ),
    ];

    /// 类型与外观
    final typeInput = FoxyFormItem(
      label: '类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.typeController,
        options: kGameObjectTypeOptions,
        placeholder: const Text('类型'),
      ),
    );
    final displayIdInput = FoxyFormItem(
      label: '外观模型',
      placeholder: 'displayId',
      child: FoxyNumberInput<int>(controller: viewModel.displayIdController),
    );
    final sizeInput = FoxyFormItem(
      label: '尺寸',
      placeholder: 'size',
      child: FoxyNumberInput<double>(controller: viewModel.sizeController),
    );
    final unk1Input = FoxyFormItem.legacy(
      controller: viewModel.unk1Controller,
      label: '未知字段',
      placeholder: 'unk1',
    );

    final typeRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: typeInput),
          Expanded(child: displayIdInput),
          Expanded(child: sizeInput),
          Expanded(child: unk1Input),
        ],
      ),
    ];

    /// 动态数据 Data0-Data23
    List<Widget> dataRows = [];
    for (var i = 0; i < 24; i += 4) {
      var children = <Widget>[];
      for (var j = i; j < i + 4 && j < 24; j++) {
        children.add(Expanded(child: _buildDataInput(j)));
      }
      dataRows.add(Row(spacing: 8, children: children));
    }

    /// AI与脚本
    final aiNameInput = FoxyFormItem.legacy(
      controller: viewModel.aiNameController,
      label: 'AI',
      placeholder: 'AIName',
    );
    final scriptNameInput = FoxyFormItem.legacy(
      controller: viewModel.scriptNameController,
      label: '脚本',
      placeholder: 'ScriptName',
    );
    final verifiedBuildInput = FoxyFormItem(
      label: 'VerifiedBuild',
      placeholder: 'VerifiedBuild',
      child: FoxyNumberInput<int>(
        controller: viewModel.verifiedBuildController,
      ),
    );

    final otherRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: aiNameInput),
          Expanded(child: scriptNameInput),
          Expanded(child: verifiedBuildInput),
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
          FoxyFormSection(title: '类型与外观', children: typeRows),
          FoxyFormSection(title: '动态数据', children: dataRows),
          FoxyFormSection(title: 'AI与脚本', children: otherRows),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
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

  FoxyFormItem _buildDataInput(int index) {
    return FoxyFormItem(
      label: 'Data$index',
      placeholder: 'Data$index',
      child: FoxyNumberInput<int>(controller: viewModel.dataControllers[index]),
    );
  }
}
