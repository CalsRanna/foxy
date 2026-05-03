import 'package:flutter/material.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );

    /// Difficulty
    final difficulty0Input = FormItem(
      label: '难度0',
      placeholder: 'Difficulty0',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty0.value,
        onChanged: (v) => viewModel.difficulty0.value = v,
      ),
    );
    final difficulty1Input = FormItem(
      label: '难度1',
      placeholder: 'Difficulty1',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty1.value,
        onChanged: (v) => viewModel.difficulty1.value = v,
      ),
    );
    final difficulty2Input = FormItem(
      label: '难度2',
      placeholder: 'Difficulty2',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty2.value,
        onChanged: (v) => viewModel.difficulty2.value = v,
      ),
    );
    final difficulty3Input = FormItem(
      label: '难度3',
      placeholder: 'Difficulty3',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty3.value,
        onChanged: (v) => viewModel.difficulty3.value = v,
      ),
    );
    final difficulty4Input = FormItem(
      label: '难度4',
      placeholder: 'Difficulty4',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty4.value,
        onChanged: (v) => viewModel.difficulty4.value = v,
      ),
    );
    final difficulty5Input = FormItem(
      label: '难度5',
      placeholder: 'Difficulty5',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty5.value,
        onChanged: (v) => viewModel.difficulty5.value = v,
      ),
    );
    final difficulty6Input = FormItem(
      label: '难度6',
      placeholder: 'Difficulty6',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty6.value,
        onChanged: (v) => viewModel.difficulty6.value = v,
      ),
    );
    final difficulty7Input = FormItem(
      label: '难度7',
      placeholder: 'Difficulty7',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty7.value,
        onChanged: (v) => viewModel.difficulty7.value = v,
      ),
    );
    final difficulty8Input = FormItem(
      label: '难度8',
      placeholder: 'Difficulty8',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty8.value,
        onChanged: (v) => viewModel.difficulty8.value = v,
      ),
    );
    final difficulty9Input = FormItem(
      label: '难度9',
      placeholder: 'Difficulty9',
      child: FoxyNumberInput<int>(
        value: viewModel.difficulty9.value,
        onChanged: (v) => viewModel.difficulty9.value = v,
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
