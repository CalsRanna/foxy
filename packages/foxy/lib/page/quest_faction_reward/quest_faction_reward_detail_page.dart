import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_view.dart';
import 'package:foxy/view_model/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class QuestFactionRewardDetailPage extends StatefulWidget {
  final int? questFactionRewardKey;

  const QuestFactionRewardDetailPage({super.key, this.questFactionRewardKey});

  @override
  State<QuestFactionRewardDetailPage> createState() =>
      _QuestFactionRewardDetailPageState();
}

class _QuestFactionRewardDetailPageState
    extends State<QuestFactionRewardDetailPage> {
  final viewModel = GetIt.instance.get<QuestFactionRewardDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoxyHeader('任务声望详情'),
        ),
        FoxyTab(
          tabs: const [Text('任务声望')],
          contents: [QuestFactionRewardView(viewModel: viewModel)],
        ),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.questFactionRewardKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
