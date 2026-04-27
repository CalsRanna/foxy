import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );

    /// StatID 0~9
    final statId0Input = FormItem(
      controller: viewModel.statId0Controller,
      label: 'StatID0',
      placeholder: 'StatID0',
    );
    final statId1Input = FormItem(
      controller: viewModel.statId1Controller,
      label: 'StatID1',
      placeholder: 'StatID1',
    );
    final statId2Input = FormItem(
      controller: viewModel.statId2Controller,
      label: 'StatID2',
      placeholder: 'StatID2',
    );
    final statId3Input = FormItem(
      controller: viewModel.statId3Controller,
      label: 'StatID3',
      placeholder: 'StatID3',
    );
    final statId4Input = FormItem(
      controller: viewModel.statId4Controller,
      label: 'StatID4',
      placeholder: 'StatID4',
    );
    final statId5Input = FormItem(
      controller: viewModel.statId5Controller,
      label: 'StatID5',
      placeholder: 'StatID5',
    );
    final statId6Input = FormItem(
      controller: viewModel.statId6Controller,
      label: 'StatID6',
      placeholder: 'StatID6',
    );
    final statId7Input = FormItem(
      controller: viewModel.statId7Controller,
      label: 'StatID7',
      placeholder: 'StatID7',
    );
    final statId8Input = FormItem(
      controller: viewModel.statId8Controller,
      label: 'StatID8',
      placeholder: 'StatID8',
    );
    final statId9Input = FormItem(
      controller: viewModel.statId9Controller,
      label: 'StatID9',
      placeholder: 'StatID9',
    );

    /// Bonus 0~9
    final bonus0Input = FormItem(
      controller: viewModel.bonus0Controller,
      label: 'Bonus0',
      placeholder: 'Bonus0',
    );
    final bonus1Input = FormItem(
      controller: viewModel.bonus1Controller,
      label: 'Bonus1',
      placeholder: 'Bonus1',
    );
    final bonus2Input = FormItem(
      controller: viewModel.bonus2Controller,
      label: 'Bonus2',
      placeholder: 'Bonus2',
    );
    final bonus3Input = FormItem(
      controller: viewModel.bonus3Controller,
      label: 'Bonus3',
      placeholder: 'Bonus3',
    );
    final bonus4Input = FormItem(
      controller: viewModel.bonus4Controller,
      label: 'Bonus4',
      placeholder: 'Bonus4',
    );
    final bonus5Input = FormItem(
      controller: viewModel.bonus5Controller,
      label: 'Bonus5',
      placeholder: 'Bonus5',
    );
    final bonus6Input = FormItem(
      controller: viewModel.bonus6Controller,
      label: 'Bonus6',
      placeholder: 'Bonus6',
    );
    final bonus7Input = FormItem(
      controller: viewModel.bonus7Controller,
      label: 'Bonus7',
      placeholder: 'Bonus7',
    );
    final bonus8Input = FormItem(
      controller: viewModel.bonus8Controller,
      label: 'Bonus8',
      placeholder: 'Bonus8',
    );
    final bonus9Input = FormItem(
      controller: viewModel.bonus9Controller,
      label: 'Bonus9',
      placeholder: 'Bonus9',
    );

    /// Other
    final maxlevelInput = FormItem(
      controller: viewModel.maxlevelController,
      label: 'Maxlevel',
      placeholder: 'Maxlevel',
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
