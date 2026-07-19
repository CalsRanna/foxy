import 'package:flutter/material.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestFactionRewardView extends StatelessWidget {
  final QuestFactionRewardDetailViewModel viewModel;

  const QuestFactionRewardView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    /// Basic
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );

    final difficulty0Input = FoxyFormItem(
      label: '索引 0 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty0',
        controller: viewModel.difficulty0Controller,
      ),
    );
    final difficulty1Input = FoxyFormItem(
      label: '索引 1 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty1',
        controller: viewModel.difficulty1Controller,
      ),
    );
    final difficulty2Input = FoxyFormItem(
      label: '索引 2 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty2',
        controller: viewModel.difficulty2Controller,
      ),
    );
    final difficulty3Input = FoxyFormItem(
      label: '索引 3 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty3',
        controller: viewModel.difficulty3Controller,
      ),
    );
    final difficulty4Input = FoxyFormItem(
      label: '索引 4 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty4',
        controller: viewModel.difficulty4Controller,
      ),
    );
    final difficulty5Input = FoxyFormItem(
      label: '索引 5 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty5',
        controller: viewModel.difficulty5Controller,
      ),
    );
    final difficulty6Input = FoxyFormItem(
      label: '索引 6 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty6',
        controller: viewModel.difficulty6Controller,
      ),
    );
    final difficulty7Input = FoxyFormItem(
      label: '索引 7 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty7',
        controller: viewModel.difficulty7Controller,
      ),
    );
    final difficulty8Input = FoxyFormItem(
      label: '索引 8 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty8',
        controller: viewModel.difficulty8Controller,
      ),
    );
    final difficulty9Input = FoxyFormItem(
      label: '索引 9 声望值',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty9',
        controller: viewModel.difficulty9Controller,
      ),
    );

    /// 1. 基本信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// 2. 声望奖励值
    final difficultyRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: difficulty0Input),
          Expanded(child: difficulty1Input),
          Expanded(child: difficulty2Input),
          Expanded(child: difficulty3Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: difficulty4Input),
          Expanded(child: difficulty5Input),
          Expanded(child: difficulty6Input),
          Expanded(child: difficulty7Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: difficulty8Input),
          Expanded(child: difficulty9Input),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
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
          FoxyFormSection(title: '声望奖励值', children: difficultyRows),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: const Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: viewModel.pop,
                child: const Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
