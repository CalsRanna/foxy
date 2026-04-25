import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest/creature_questender_view.dart';
import 'package:foxy/page/quest/creature_queststarter_view.dart';
import 'package:foxy/page/quest/gameobject_questender_view.dart';
import 'package:foxy/page/quest/gameobject_queststarter_view.dart';
import 'package:foxy/page/quest/quest_offer_reward_view.dart';
import 'package:foxy/page/quest/quest_request_items_view.dart';
import 'package:foxy/page/quest/quest_template_addon_view.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_locale_view.dart';
import 'package:foxy/page/quest/quest_template_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class QuestTemplateDetailPage extends StatefulWidget {
  final int? questId;
  final String? name;

  const QuestTemplateDetailPage({super.key, this.questId, this.name});

  @override
  State<QuestTemplateDetailPage> createState() =>
      _QuestTemplateDetailPageState();
}

class _QuestTemplateDetailPageState extends State<QuestTemplateDetailPage> {
  final viewModel = GetIt.instance.get<QuestTemplateDetailViewModel>();

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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), _buildTabs()],
    );
  }

  Widget _buildHeader() {
    return Watch((_) {
      final label = viewModel.creating.value
          ? '新建任务'
          : '任务 ${viewModel.id.value}';
      final displayName = widget.name?.isNotEmpty == true
          ? '$label - ${widget.name}'
          : label;
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          displayName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    });
  }

  Widget _buildTabs() {
    final tabs = [
      Text('任务模板'),
      Text('模版补充'),
      Text('提交物品'),
      Text('发放奖励'),
      Text('本地化'),
      Text('开始生物'),
      Text('结束生物'),
      Text('开始物体'),
      Text('结束物体'),
    ];
    final contents = [
      QuestTemplateView(viewModel: viewModel),
      QuestTemplateAddonView(parentViewModel: viewModel),
      QuestRequestItemsView(parentViewModel: viewModel),
      QuestOfferRewardView(parentViewModel: viewModel),
      QuestTemplateLocaleView(parentViewModel: viewModel),
      CreatureQueststarterView(parentViewModel: viewModel),
      CreatureQuestenderView(parentViewModel: viewModel),
      GameobjectQueststarterView(parentViewModel: viewModel),
      GameobjectQuestenderView(parentViewModel: viewModel),
    ];
    return FoxyTab(tabs: tabs, contents: contents);
  }
}