import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScalingStatDistributionView extends StatefulWidget {
  final int? entry;
  const ScalingStatDistributionView({super.key, this.entry});

  @override
  State<ScalingStatDistributionView> createState() => _ScalingStatDistributionViewState();
}

class _ScalingStatDistributionViewState extends State<ScalingStatDistributionView> {
  final viewModel = GetIt.instance.get<ScalingStatDistributionDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Basic
    final idInput = FormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );

    /// StatID 0~9
    final statId0Input = FormItem(
      label: 'StatID0',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID0',
        controller: viewModel.statId0Controller,
      ),
    );
    final statId1Input = FormItem(
      label: 'StatID1',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID1',
        controller: viewModel.statId1Controller,
      ),
    );
    final statId2Input = FormItem(
      label: 'StatID2',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID2',
        controller: viewModel.statId2Controller,
      ),
    );
    final statId3Input = FormItem(
      label: 'StatID3',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID3',
        controller: viewModel.statId3Controller,
      ),
    );
    final statId4Input = FormItem(
      label: 'StatID4',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID4',
        controller: viewModel.statId4Controller,
      ),
    );
    final statId5Input = FormItem(
      label: 'StatID5',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID5',
        controller: viewModel.statId5Controller,
      ),
    );
    final statId6Input = FormItem(
      label: 'StatID6',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID6',
        controller: viewModel.statId6Controller,
      ),
    );
    final statId7Input = FormItem(
      label: 'StatID7',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID7',
        controller: viewModel.statId7Controller,
      ),
    );
    final statId8Input = FormItem(
      label: 'StatID8',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID8',
        controller: viewModel.statId8Controller,
      ),
    );
    final statId9Input = FormItem(
      label: 'StatID9',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID9',
        controller: viewModel.statId9Controller,
      ),
    );

    /// Bonus 0~9
    final bonus0Input = FormItem(
      label: 'Bonus0',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus0',
        controller: viewModel.bonus0Controller,
      ),
    );
    final bonus1Input = FormItem(
      label: 'Bonus1',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus1',
        controller: viewModel.bonus1Controller,
      ),
    );
    final bonus2Input = FormItem(
      label: 'Bonus2',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus2',
        controller: viewModel.bonus2Controller,
      ),
    );
    final bonus3Input = FormItem(
      label: 'Bonus3',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus3',
        controller: viewModel.bonus3Controller,
      ),
    );
    final bonus4Input = FormItem(
      label: 'Bonus4',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus4',
        controller: viewModel.bonus4Controller,
      ),
    );
    final bonus5Input = FormItem(
      label: 'Bonus5',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus5',
        controller: viewModel.bonus5Controller,
      ),
    );
    final bonus6Input = FormItem(
      label: 'Bonus6',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus6',
        controller: viewModel.bonus6Controller,
      ),
    );
    final bonus7Input = FormItem(
      label: 'Bonus7',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus7',
        controller: viewModel.bonus7Controller,
      ),
    );
    final bonus8Input = FormItem(
      label: 'Bonus8',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus8',
        controller: viewModel.bonus8Controller,
      ),
    );
    final bonus9Input = FormItem(
      label: 'Bonus9',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus9',
        controller: viewModel.bonus9Controller,
      ),
    );

    /// Other
    final maxlevelInput = FormItem(
      label: 'Maxlevel',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxlevel',
        controller: viewModel.maxlevelController,
      ),
    );

    /// 1. 基本信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
        ],
      ),
    ];

    /// 2. StatID (0~9) 4+4+2
    final statIdRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId0Input),
          Expanded(child: statId1Input),
          Expanded(child: statId2Input),
          Expanded(child: statId3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId4Input),
          Expanded(child: statId5Input),
          Expanded(child: statId6Input),
          Expanded(child: statId7Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId8Input),
          Expanded(child: statId9Input),
        ],
      ),
    ];

    /// 3. Bonus (0~9) 4+4+2
    final bonusRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: bonus0Input),
          Expanded(child: bonus1Input),
          Expanded(child: bonus2Input),
          Expanded(child: bonus3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: bonus4Input),
          Expanded(child: bonus5Input),
          Expanded(child: bonus6Input),
          Expanded(child: bonus7Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: bonus8Input),
          Expanded(child: bonus9Input),
        ],
      ),
    ];

    /// 4. Maxlevel
    final otherRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: maxlevelInput),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // 基本信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // StatID (0~9)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('StatID (0~9)'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: statIdRows),
          ),
          // Bonus (0~9)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('Bonus (0~9)'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: bonusRows),
          ),
          // Maxlevel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('Maxlevel'),
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
}
