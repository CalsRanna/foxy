import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScalingStatDistributionView extends StatefulWidget {
  final int? entry;
  const ScalingStatDistributionView({super.key, this.entry});

  @override
  State<ScalingStatDistributionView> createState() =>
      _ScalingStatDistributionViewState();
}

class _ScalingStatDistributionViewState
    extends State<ScalingStatDistributionView> {
  final viewModel = GetIt.instance
      .get<ScalingStatDistributionDetailViewModel>();

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
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        fieldController: viewModel.idController,
        readOnly: true,
      ),
    );

    /// StatID 0~9
    final statId0Input = FoxyFormItem(
      label: 'StatID0',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID0',
        fieldController: viewModel.statId0Controller,
      ),
    );
    final statId1Input = FoxyFormItem(
      label: 'StatID1',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID1',
        fieldController: viewModel.statId1Controller,
      ),
    );
    final statId2Input = FoxyFormItem(
      label: 'StatID2',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID2',
        fieldController: viewModel.statId2Controller,
      ),
    );
    final statId3Input = FoxyFormItem(
      label: 'StatID3',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID3',
        fieldController: viewModel.statId3Controller,
      ),
    );
    final statId4Input = FoxyFormItem(
      label: 'StatID4',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID4',
        fieldController: viewModel.statId4Controller,
      ),
    );
    final statId5Input = FoxyFormItem(
      label: 'StatID5',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID5',
        fieldController: viewModel.statId5Controller,
      ),
    );
    final statId6Input = FoxyFormItem(
      label: 'StatID6',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID6',
        fieldController: viewModel.statId6Controller,
      ),
    );
    final statId7Input = FoxyFormItem(
      label: 'StatID7',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID7',
        fieldController: viewModel.statId7Controller,
      ),
    );
    final statId8Input = FoxyFormItem(
      label: 'StatID8',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID8',
        fieldController: viewModel.statId8Controller,
      ),
    );
    final statId9Input = FoxyFormItem(
      label: 'StatID9',
      child: FoxyNumberInput<int>(
        placeholder: 'StatID9',
        fieldController: viewModel.statId9Controller,
      ),
    );

    /// Bonus 0~9
    final bonus0Input = FoxyFormItem(
      label: 'Bonus0',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus0',
        fieldController: viewModel.bonus0Controller,
      ),
    );
    final bonus1Input = FoxyFormItem(
      label: 'Bonus1',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus1',
        fieldController: viewModel.bonus1Controller,
      ),
    );
    final bonus2Input = FoxyFormItem(
      label: 'Bonus2',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus2',
        fieldController: viewModel.bonus2Controller,
      ),
    );
    final bonus3Input = FoxyFormItem(
      label: 'Bonus3',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus3',
        fieldController: viewModel.bonus3Controller,
      ),
    );
    final bonus4Input = FoxyFormItem(
      label: 'Bonus4',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus4',
        fieldController: viewModel.bonus4Controller,
      ),
    );
    final bonus5Input = FoxyFormItem(
      label: 'Bonus5',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus5',
        fieldController: viewModel.bonus5Controller,
      ),
    );
    final bonus6Input = FoxyFormItem(
      label: 'Bonus6',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus6',
        fieldController: viewModel.bonus6Controller,
      ),
    );
    final bonus7Input = FoxyFormItem(
      label: 'Bonus7',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus7',
        fieldController: viewModel.bonus7Controller,
      ),
    );
    final bonus8Input = FoxyFormItem(
      label: 'Bonus8',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus8',
        fieldController: viewModel.bonus8Controller,
      ),
    );
    final bonus9Input = FoxyFormItem(
      label: 'Bonus9',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus9',
        fieldController: viewModel.bonus9Controller,
      ),
    );

    /// Other
    final maxlevelInput = FoxyFormItem(
      label: 'Maxlevel',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxlevel',
        fieldController: viewModel.maxlevelController,
      ),
    );

    /// 1. 基本信息
    final basicRows = [
      Row(spacing: 8, children: [Expanded(child: idInput)]),
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
      Row(spacing: 8, children: [Expanded(child: maxlevelInput)]),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基本信息', children: basicRows),
          FoxyFormSection(title: 'StatID (0~9)', children: statIdRows),
          FoxyFormSection(title: 'Bonus (0~9)', children: bonusRows),
          FoxyFormSection(title: 'Maxlevel', children: otherRows),
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
