import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_offer_reward_locale_selector.dart';
import 'package:foxy/page/quest/quest_offer_reward_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
              label: '编号',
              child: FoxyNumberInput<int>(
                value: vm.id.value,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '表情1',
              placeholder: 'Emote1',
              child: FoxyNumberInput<int>(
                value: vm.emote1.value,
                onChanged: (v) => vm.emote1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '表情2',
              placeholder: 'Emote2',
              child: FoxyNumberInput<int>(
                value: vm.emote2.value,
                onChanged: (v) => vm.emote2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '表情3',
              placeholder: 'Emote3',
              child: FoxyNumberInput<int>(
                value: vm.emote3.value,
                onChanged: (v) => vm.emote3.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '表情4',
              placeholder: 'Emote4',
              child: FoxyNumberInput<int>(
                value: vm.emote4.value,
                onChanged: (v) => vm.emote4.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '表情延迟1',
              placeholder: 'EmoteDelay1',
              child: FoxyNumberInput<int>(
                value: vm.emoteDelay1.value,
                onChanged: (v) => vm.emoteDelay1.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '表情延迟2',
              placeholder: 'EmoteDelay2',
              child: FoxyNumberInput<int>(
                value: vm.emoteDelay2.value,
                onChanged: (v) => vm.emoteDelay2.value = v,
              ),
            ),
          ),
          Expanded(
            child: FormItem(
              label: '表情延迟3',
              placeholder: 'EmoteDelay3',
              child: FoxyNumberInput<int>(
                value: vm.emoteDelay3.value,
                onChanged: (v) => vm.emoteDelay3.value = v,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FormItem(
              label: '表情延迟4',
              placeholder: 'EmoteDelay4',
              child: FoxyNumberInput<int>(
                value: vm.emoteDelay4.value,
                onChanged: (v) => vm.emoteDelay4.value = v,
              ),
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
