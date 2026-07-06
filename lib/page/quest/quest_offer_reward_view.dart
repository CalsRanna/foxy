import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/page/quest/quest_offer_reward_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
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
            child: FoxyFormItem(
              label: '编号',
              child: FoxyNumberInput<int>(
                controller: vm.idController,
                readOnly: true,
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情1',
              placeholder: 'Emote1',
              child: FoxyNumberInput<int>(controller: vm.emote1Controller),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情2',
              placeholder: 'Emote2',
              child: FoxyNumberInput<int>(controller: vm.emote2Controller),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情3',
              placeholder: 'Emote3',
              child: FoxyNumberInput<int>(controller: vm.emote3Controller),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '表情4',
              placeholder: 'Emote4',
              child: FoxyNumberInput<int>(controller: vm.emote4Controller),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟1',
              placeholder: 'EmoteDelay1',
              child: FoxyNumberInput<int>(controller: vm.emoteDelay1Controller),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟2',
              placeholder: 'EmoteDelay2',
              child: FoxyNumberInput<int>(controller: vm.emoteDelay2Controller),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟3',
              placeholder: 'EmoteDelay3',
              child: FoxyNumberInput<int>(controller: vm.emoteDelay3Controller),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟4',
              placeholder: 'EmoteDelay4',
              child: FoxyNumberInput<int>(controller: vm.emoteDelay4Controller),
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
            child: FoxyFormItem(
              label: '奖励文本',
              child: FoxyLocalePicker(
                entry: widget.questId,
                controller: vm.rewardTextController,
                delegate: FoxyLocalePickerDelegates.questOfferReward,
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
          FoxyFormSection(title: '基本信息', children: rows),
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
