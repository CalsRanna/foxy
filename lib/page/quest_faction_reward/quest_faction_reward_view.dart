import 'package:flutter/material.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );

    /// Difficulty
    final difficulty0Input = FormItem(
      controller: viewModel.difficulty0Controller,
      label: '难度0',
      placeholder: 'Difficulty0',
    );
    final difficulty1Input = FormItem(
      controller: viewModel.difficulty1Controller,
      label: '难度1',
      placeholder: 'Difficulty1',
    );
    final difficulty2Input = FormItem(
      controller: viewModel.difficulty2Controller,
      label: '难度2',
      placeholder: 'Difficulty2',
    );
    final difficulty3Input = FormItem(
      controller: viewModel.difficulty3Controller,
      label: '难度3',
      placeholder: 'Difficulty3',
    );
    final difficulty4Input = FormItem(
      controller: viewModel.difficulty4Controller,
      label: '难度4',
      placeholder: 'Difficulty4',
    );
    final difficulty5Input = FormItem(
      controller: viewModel.difficulty5Controller,
      label: '难度5',
      placeholder: 'Difficulty5',
    );
    final difficulty6Input = FormItem(
      controller: viewModel.difficulty6Controller,
      label: '难度6',
      placeholder: 'Difficulty6',
    );
    final difficulty7Input = FormItem(
      controller: viewModel.difficulty7Controller,
      label: '难度7',
      placeholder: 'Difficulty7',
    );
    final difficulty8Input = FormItem(
      controller: viewModel.difficulty8Controller,
      label: '难度8',
      placeholder: 'Difficulty8',
    );
    final difficulty9Input = FormItem(
      controller: viewModel.difficulty9Controller,
      label: '难度9',
      placeholder: 'Difficulty9',
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
          // 基本信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // 难度
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('难度(Difficulty)'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: difficultyRows),
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
