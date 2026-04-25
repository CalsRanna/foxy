import 'package:flutter/material.dart';
import 'package:foxy/page/quest/quest_offer_reward_view_model.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class QuestOfferRewardView extends StatefulWidget {
  final QuestTemplateDetailViewModel parentViewModel;

  const QuestOfferRewardView({super.key, required this.parentViewModel});

  @override
  State<QuestOfferRewardView> createState() => _QuestOfferRewardViewState();
}

class _QuestOfferRewardViewState extends State<QuestOfferRewardView> {
  final viewModel = GetIt.instance.get<QuestOfferRewardViewModel>();
  late final VoidCallback _disposer;

  @override
  void initState() {
    super.initState();
    final initialId = widget.parentViewModel.id.value;
    if (initialId != 0) {
      viewModel.search(initialId);
    }
    _disposer = effect(() {
      final questId = widget.parentViewModel.id.value;
      if (questId != 0) {
        viewModel.search(questId);
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      if (viewModel.loading.value) {
        return const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        );
      }

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
            ShadButton(
              onPressed: viewModel.onSave,
              child: Text('保存'),
            ),
          ],
        ),
      );
    });
  }
}