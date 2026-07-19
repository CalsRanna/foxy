import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/page/quest/quest_offer_reward_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

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
              child: FoxyNumberInput<int>(controller: vm.idController),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '验证版本',
              child: FoxyNumberInput<int>(
                controller: vm.verifiedBuildController,
                placeholder: 'VerifiedBuild',
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '表情1',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcEmote,
                controller: vm.emote1Controller,
                placeholder: 'Emote1',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟1',
              child: FoxyNumberInput<int>(
                controller: vm.emoteDelay1Controller,
                placeholder: 'EmoteDelay1',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情2',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcEmote,
                controller: vm.emote2Controller,
                placeholder: 'Emote2',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟2',
              child: FoxyNumberInput<int>(
                controller: vm.emoteDelay2Controller,
                placeholder: 'EmoteDelay2',
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '表情3',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcEmote,
                controller: vm.emote3Controller,
                placeholder: 'Emote3',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟3',
              child: FoxyNumberInput<int>(
                controller: vm.emoteDelay3Controller,
                placeholder: 'EmoteDelay3',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情4',
              child: FoxyEntityPicker(
                delegate: FoxyEntityPickerDelegates.dbcEmote,
                controller: vm.emote4Controller,
                placeholder: 'Emote4',
              ),
            ),
          ),
          Expanded(
            child: FoxyFormItem(
              label: '表情延迟4',
              child: FoxyNumberInput<int>(
                controller: vm.emoteDelay4Controller,
                placeholder: 'EmoteDelay4',
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(
            child: FoxyFormItem(
              label: '奖励文本',
              child: Watch(
                (_) => FoxyLocalePicker(
                  entry: vm.editingKey.value,
                  controller: vm.rewardTextController,
                  delegate: FoxyLocalePickerDelegates.questOfferReward,
                  placeholder: 'RewardText',
                  title: '奖励文本',
                ),
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
