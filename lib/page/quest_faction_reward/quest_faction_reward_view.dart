import 'package:flutter/material.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestFactionRewardView extends StatefulWidget {
  final int? entry;
  const QuestFactionRewardView({super.key, this.entry});

  @override
  State<QuestFactionRewardView> createState() => _QuestFactionRewardViewState();
}

class _QuestFactionRewardViewState extends State<QuestFactionRewardView> {
  final viewModel = GetIt.instance.get<QuestFactionRewardDetailViewModel>();

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

    /// Difficulty
    final difficulty0Input = FormItem(
      label: '难度0',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty0',
        controller: viewModel.difficulty0Controller,
      ),
    );
    final difficulty1Input = FormItem(
      label: '难度1',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty1',
        controller: viewModel.difficulty1Controller,
      ),
    );
    final difficulty2Input = FormItem(
      label: '难度2',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty2',
        controller: viewModel.difficulty2Controller,
      ),
    );
    final difficulty3Input = FormItem(
      label: '难度3',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty3',
        controller: viewModel.difficulty3Controller,
      ),
    );
    final difficulty4Input = FormItem(
      label: '难度4',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty4',
        controller: viewModel.difficulty4Controller,
      ),
    );
    final difficulty5Input = FormItem(
      label: '难度5',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty5',
        controller: viewModel.difficulty5Controller,
      ),
    );
    final difficulty6Input = FormItem(
      label: '难度6',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty6',
        controller: viewModel.difficulty6Controller,
      ),
    );
    final difficulty7Input = FormItem(
      label: '难度7',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty7',
        controller: viewModel.difficulty7Controller,
      ),
    );
    final difficulty8Input = FormItem(
      label: '难度8',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty8',
        controller: viewModel.difficulty8Controller,
      ),
    );
    final difficulty9Input = FormItem(
      label: '难度9',
      child: FoxyNumberInput<int>(
        placeholder: 'Difficulty9',
        controller: viewModel.difficulty9Controller,
      ),
    );

    /// 1. 基本信息
    final basicRows = [
      Row(spacing: 8, children: [Expanded(child: idInput)]),
    ];

    /// 2. 难度 (4+4+2)
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
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FormSection(title: '基本信息', children: basicRows),
          FormSection(title: '难度(Difficulty)', children: difficultyRows),
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
