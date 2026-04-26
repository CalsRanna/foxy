import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_offer_reward_locale_selector.dart';
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
    final vm = viewModel;

    final rows = [
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.idController,
              label: '编号',
              readOnly: true,
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.emote1Controller,
              label: '表情1',
              placeholder: 'Emote1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.emote2Controller,
              label: '表情2',
              placeholder: 'Emote2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.emote3Controller,
              label: '表情3',
              placeholder: 'Emote3',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.emote4Controller,
              label: '表情4',
              placeholder: 'Emote4',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.emoteDelay1Controller,
              label: '表情延迟1',
              placeholder: 'EmoteDelay1',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.emoteDelay2Controller,
              label: '表情延迟2',
              placeholder: 'EmoteDelay2',
            ),
          ),
          Expanded(
            child: FormItem(
              controller: vm.emoteDelay3Controller,
              label: '表情延迟3',
              placeholder: 'EmoteDelay3',
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              controller: vm.emoteDelay4Controller,
              label: '表情延迟4',
              placeholder: 'EmoteDelay4',
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '奖励文本',
              child: QuestOfferRewardLocaleSelector(
                questId: widget.questId,
                controller: vm.rewardTextController,
                placeholder: 'RewardText',
                title: '奖励文本',
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: rows),
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
