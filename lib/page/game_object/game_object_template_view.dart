import 'package:flutter/material.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_locale_name_selector.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.entryController,
      label: '编号',
      placeholder: 'entry',
      readOnly: true,
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
      controller: viewModel.displayIdController,
      label: '外观模型',
      placeholder: 'displayId',
    );
    final sizeInput = FormItem(
      controller: viewModel.sizeController,
      label: '尺寸',
      placeholder: 'size',
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
      controller: viewModel.verifiedBuildController,
      label: 'VerifiedBuild',
      placeholder: 'VerifiedBuild',
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
    final controllers = [
      viewModel.data0Controller,
      viewModel.data1Controller,
      viewModel.data2Controller,
      viewModel.data3Controller,
      viewModel.data4Controller,
      viewModel.data5Controller,
      viewModel.data6Controller,
      viewModel.data7Controller,
      viewModel.data8Controller,
      viewModel.data9Controller,
      viewModel.data10Controller,
      viewModel.data11Controller,
      viewModel.data12Controller,
      viewModel.data13Controller,
      viewModel.data14Controller,
      viewModel.data15Controller,
      viewModel.data16Controller,
      viewModel.data17Controller,
      viewModel.data18Controller,
      viewModel.data19Controller,
      viewModel.data20Controller,
      viewModel.data21Controller,
      viewModel.data22Controller,
      viewModel.data23Controller,
    ];
    return FormItem(
      controller: controllers[index],
      label: 'Data$index',
      placeholder: 'Data$index',
    );
  }
}
