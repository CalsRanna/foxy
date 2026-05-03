import 'package:flutter/material.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_locale_name_selector.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
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
    final entryInput = FormItem(
      label: '编号',
      placeholder: 'entry',
      child: FoxyNumberInput<int>(
        value: viewModel.entry.value,
        onChanged: (v) => viewModel.entry.value = v,
        readOnly: true,
      ),
    );
    final nameInput = FormItem(
      label: '名称',
      child: GameObjectTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.nameController,
        placeholder: 'name',
        title: '名称',
      ),
    );
    final castBarCaptionInput = FormItem(
      label: '使用说明',
      child: GameObjectTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.castBarCaptionController,
        placeholder: 'castBarCaption',
        title: '使用说明',
        isCaption: true,
      ),
    );
    final iconNameInput = FormItem(
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
    final typeInput = FormItem(
      label: '类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.typeController,
        options: kGameObjectTypeOptions,
        placeholder: const Text('类型'),
      ),
    );
    final displayIdInput = FormItem(
      label: '外观模型',
      placeholder: 'displayId',
      child: FoxyNumberInput<int>(
        value: viewModel.displayId.value,
        onChanged: (v) => viewModel.displayId.value = v,
      ),
    );
    final sizeInput = FormItem(
      label: '尺寸',
      placeholder: 'size',
      child: FoxyNumberInput<double>(
        value: viewModel.size.value,
        onChanged: (v) => viewModel.size.value = v,
      ),
    );
    final unk1Input = FormItem(
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
    final aiNameInput = FormItem(
      controller: viewModel.aiNameController,
      label: 'AI',
      placeholder: 'AIName',
    );
    final scriptNameInput = FormItem(
      controller: viewModel.scriptNameController,
      label: '脚本',
      placeholder: 'ScriptName',
    );
    final verifiedBuildInput = FormItem(
      label: 'VerifiedBuild',
      placeholder: 'VerifiedBuild',
      child: FoxyNumberInput<int>(
        value: viewModel.verifiedBuild.value,
        onChanged: (v) => viewModel.verifiedBuild.value = v,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基础信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('类型与外观'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: typeRows),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('动态数据'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: dataRows),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('AI与脚本'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: otherRows),
          ),
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

  FormItem _buildDataInput(int index) {
    final signals = [
      viewModel.data0,
      viewModel.data1,
      viewModel.data2,
      viewModel.data3,
      viewModel.data4,
      viewModel.data5,
      viewModel.data6,
      viewModel.data7,
      viewModel.data8,
      viewModel.data9,
      viewModel.data10,
      viewModel.data11,
      viewModel.data12,
      viewModel.data13,
      viewModel.data14,
      viewModel.data15,
      viewModel.data16,
      viewModel.data17,
      viewModel.data18,
      viewModel.data19,
      viewModel.data20,
      viewModel.data21,
      viewModel.data22,
      viewModel.data23,
    ];
    final s = signals[index];
    return FormItem(
      label: 'Data$index',
      placeholder: 'Data$index',
      child: FoxyNumberInput<int>(
        value: s.value,
        onChanged: (v) => s.value = v,
      ),
    );
  }
}
