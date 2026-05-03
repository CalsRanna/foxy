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
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );

    /// StatID 0~9
    final statId0Input = FormItem(
      label: 'StatID0',
      placeholder: 'StatID0',
      child: FoxyNumberInput<int>(
        value: viewModel.statId0.value,
        onChanged: (v) => viewModel.statId0.value = v,
      ),
    );
    final statId1Input = FormItem(
      label: 'StatID1',
      placeholder: 'StatID1',
      child: FoxyNumberInput<int>(
        value: viewModel.statId1.value,
        onChanged: (v) => viewModel.statId1.value = v,
      ),
    );
    final statId2Input = FormItem(
      label: 'StatID2',
      placeholder: 'StatID2',
      child: FoxyNumberInput<int>(
        value: viewModel.statId2.value,
        onChanged: (v) => viewModel.statId2.value = v,
      ),
    );
    final statId3Input = FormItem(
      label: 'StatID3',
      placeholder: 'StatID3',
      child: FoxyNumberInput<int>(
        value: viewModel.statId3.value,
        onChanged: (v) => viewModel.statId3.value = v,
      ),
    );
    final statId4Input = FormItem(
      label: 'StatID4',
      placeholder: 'StatID4',
      child: FoxyNumberInput<int>(
        value: viewModel.statId4.value,
        onChanged: (v) => viewModel.statId4.value = v,
      ),
    );
    final statId5Input = FormItem(
      label: 'StatID5',
      placeholder: 'StatID5',
      child: FoxyNumberInput<int>(
        value: viewModel.statId5.value,
        onChanged: (v) => viewModel.statId5.value = v,
      ),
    );
    final statId6Input = FormItem(
      label: 'StatID6',
      placeholder: 'StatID6',
      child: FoxyNumberInput<int>(
        value: viewModel.statId6.value,
        onChanged: (v) => viewModel.statId6.value = v,
      ),
    );
    final statId7Input = FormItem(
      label: 'StatID7',
      placeholder: 'StatID7',
      child: FoxyNumberInput<int>(
        value: viewModel.statId7.value,
        onChanged: (v) => viewModel.statId7.value = v,
      ),
    );
    final statId8Input = FormItem(
      label: 'StatID8',
      placeholder: 'StatID8',
      child: FoxyNumberInput<int>(
        value: viewModel.statId8.value,
        onChanged: (v) => viewModel.statId8.value = v,
      ),
    );
    final statId9Input = FormItem(
      label: 'StatID9',
      placeholder: 'StatID9',
      child: FoxyNumberInput<int>(
        value: viewModel.statId9.value,
        onChanged: (v) => viewModel.statId9.value = v,
      ),
    );

    /// Bonus 0~9
    final bonus0Input = FormItem(
      label: 'Bonus0',
      placeholder: 'Bonus0',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus0.value,
        onChanged: (v) => viewModel.bonus0.value = v,
      ),
    );
    final bonus1Input = FormItem(
      label: 'Bonus1',
      placeholder: 'Bonus1',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus1.value,
        onChanged: (v) => viewModel.bonus1.value = v,
      ),
    );
    final bonus2Input = FormItem(
      label: 'Bonus2',
      placeholder: 'Bonus2',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus2.value,
        onChanged: (v) => viewModel.bonus2.value = v,
      ),
    );
    final bonus3Input = FormItem(
      label: 'Bonus3',
      placeholder: 'Bonus3',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus3.value,
        onChanged: (v) => viewModel.bonus3.value = v,
      ),
    );
    final bonus4Input = FormItem(
      label: 'Bonus4',
      placeholder: 'Bonus4',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus4.value,
        onChanged: (v) => viewModel.bonus4.value = v,
      ),
    );
    final bonus5Input = FormItem(
      label: 'Bonus5',
      placeholder: 'Bonus5',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus5.value,
        onChanged: (v) => viewModel.bonus5.value = v,
      ),
    );
    final bonus6Input = FormItem(
      label: 'Bonus6',
      placeholder: 'Bonus6',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus6.value,
        onChanged: (v) => viewModel.bonus6.value = v,
      ),
    );
    final bonus7Input = FormItem(
      label: 'Bonus7',
      placeholder: 'Bonus7',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus7.value,
        onChanged: (v) => viewModel.bonus7.value = v,
      ),
    );
    final bonus8Input = FormItem(
      label: 'Bonus8',
      placeholder: 'Bonus8',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus8.value,
        onChanged: (v) => viewModel.bonus8.value = v,
      ),
    );
    final bonus9Input = FormItem(
      label: 'Bonus9',
      placeholder: 'Bonus9',
      child: FoxyNumberInput<int>(
        value: viewModel.bonus9.value,
        onChanged: (v) => viewModel.bonus9.value = v,
      ),
    );

    /// Other
    final maxlevelInput = FormItem(
      label: 'Maxlevel',
      placeholder: 'Maxlevel',
      child: FoxyNumberInput<int>(
        value: viewModel.maxlevel.value,
        onChanged: (v) => viewModel.maxlevel.value = v,
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
