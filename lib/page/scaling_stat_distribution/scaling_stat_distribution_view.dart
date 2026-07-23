import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ScalingStatDistributionView extends StatelessWidget {
  final ScalingStatDistributionDetailViewModel viewModel;

  const ScalingStatDistributionView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final maxlevelInput = FoxyFormItem(
      label: '最大等级',
      child: FoxyNumberInput<int>(
        placeholder: 'Maxlevel',
        controller: viewModel.maxlevelController,
      ),
    );

    final statId0Input = FoxyFormItem(
      label: '属性类型 0',
      child: FoxyIntShadSelect(
        controller: viewModel.statId0Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID0'),
      ),
    );
    final bonus0Input = FoxyFormItem(
      label: '缩放系数 0',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus0',
        controller: viewModel.bonus0Controller,
      ),
    );
    final statId1Input = FoxyFormItem(
      label: '属性类型 1',
      child: FoxyIntShadSelect(
        controller: viewModel.statId1Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID1'),
      ),
    );
    final bonus1Input = FoxyFormItem(
      label: '缩放系数 1',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus1',
        controller: viewModel.bonus1Controller,
      ),
    );
    final statId2Input = FoxyFormItem(
      label: '属性类型 2',
      child: FoxyIntShadSelect(
        controller: viewModel.statId2Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID2'),
      ),
    );
    final bonus2Input = FoxyFormItem(
      label: '缩放系数 2',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus2',
        controller: viewModel.bonus2Controller,
      ),
    );
    final statId3Input = FoxyFormItem(
      label: '属性类型 3',
      child: FoxyIntShadSelect(
        controller: viewModel.statId3Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID3'),
      ),
    );
    final bonus3Input = FoxyFormItem(
      label: '缩放系数 3',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus3',
        controller: viewModel.bonus3Controller,
      ),
    );
    final statId4Input = FoxyFormItem(
      label: '属性类型 4',
      child: FoxyIntShadSelect(
        controller: viewModel.statId4Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID4'),
      ),
    );
    final bonus4Input = FoxyFormItem(
      label: '缩放系数 4',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus4',
        controller: viewModel.bonus4Controller,
      ),
    );
    final statId5Input = FoxyFormItem(
      label: '属性类型 5',
      child: FoxyIntShadSelect(
        controller: viewModel.statId5Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID5'),
      ),
    );
    final bonus5Input = FoxyFormItem(
      label: '缩放系数 5',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus5',
        controller: viewModel.bonus5Controller,
      ),
    );
    final statId6Input = FoxyFormItem(
      label: '属性类型 6',
      child: FoxyIntShadSelect(
        controller: viewModel.statId6Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID6'),
      ),
    );
    final bonus6Input = FoxyFormItem(
      label: '缩放系数 6',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus6',
        controller: viewModel.bonus6Controller,
      ),
    );
    final statId7Input = FoxyFormItem(
      label: '属性类型 7',
      child: FoxyIntShadSelect(
        controller: viewModel.statId7Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID7'),
      ),
    );
    final bonus7Input = FoxyFormItem(
      label: '缩放系数 7',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus7',
        controller: viewModel.bonus7Controller,
      ),
    );
    final statId8Input = FoxyFormItem(
      label: '属性类型 8',
      child: FoxyIntShadSelect(
        controller: viewModel.statId8Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID8'),
      ),
    );
    final bonus8Input = FoxyFormItem(
      label: '缩放系数 8',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus8',
        controller: viewModel.bonus8Controller,
      ),
    );
    final statId9Input = FoxyFormItem(
      label: '属性类型 9',
      child: FoxyIntShadSelect(
        controller: viewModel.statId9Controller,
        options: kScalingStatDistributionStatOptions,
        placeholder: const Text('StatID9'),
      ),
    );
    final bonus9Input = FoxyFormItem(
      label: '缩放系数 9',
      child: FoxyNumberInput<int>(
        placeholder: 'Bonus9',
        controller: viewModel.bonus9Controller,
      ),
    );

    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: maxlevelInput),
          const Expanded(child: SizedBox.shrink()),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    ];
    final statRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId0Input),
          Expanded(child: bonus0Input),
          Expanded(child: statId1Input),
          Expanded(child: bonus1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId2Input),
          Expanded(child: bonus2Input),
          Expanded(child: statId3Input),
          Expanded(child: bonus3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId4Input),
          Expanded(child: bonus4Input),
          Expanded(child: statId5Input),
          Expanded(child: bonus5Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId6Input),
          Expanded(child: bonus6Input),
          Expanded(child: statId7Input),
          Expanded(child: bonus7Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: statId8Input),
          Expanded(child: bonus8Input),
          Expanded(child: statId9Input),
          Expanded(child: bonus9Input),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基本信息', children: basicRows),
          FoxyFormSection(title: '缩放属性', children: statRows),
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

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '属性缩放分布 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('属性缩放分布数据已保存')));
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
