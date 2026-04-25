import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_offer_reward_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuestOfferRewardView extends StatefulWidget {
  final int questId;
  const QuestOfferRewardView({super.key, required this.questId});

  @override
  State<QuestOfferRewardView> createState() => _QuestOfferRewardViewState();
}

class _QuestOfferRewardViewState extends State<QuestOfferRewardView> {
  final viewModel = GetIt.instance.get<QuestOfferRewardViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(questId: widget.questId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          FormItem(
            controller: viewModel.idController,
            label: '编号',
            readOnly: true,
          ),
          FormItem(
            controller: viewModel.emote1Controller,
            label: '表情1',
          ),
          FormItem(
            controller: viewModel.emote2Controller,
            label: '表情2',
          ),
          FormItem(
            controller: viewModel.emote3Controller,
            label: '表情3',
          ),
          FormItem(
            controller: viewModel.emote4Controller,
            label: '表情4',
          ),
          FormItem(
            controller: viewModel.emoteDelay1Controller,
            label: '表情延迟1',
          ),
          FormItem(
            controller: viewModel.emoteDelay2Controller,
            label: '表情延迟2',
          ),
          FormItem(
            controller: viewModel.emoteDelay3Controller,
            label: '表情延迟3',
          ),
          FormItem(
            controller: viewModel.emoteDelay4Controller,
            label: '表情延迟4',
          ),
          FormItem(
            controller: viewModel.rewardTextController,
            label: '奖励文本',
          ),
          FormItem(
            controller: viewModel.localeControllerOf('RewardText'),
            label: '奖励文本(中文)',
          ),
          Row(
            spacing: 8,
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
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