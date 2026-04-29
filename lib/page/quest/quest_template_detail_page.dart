import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest/creature_quest_ender_view.dart';
import 'package:foxy/page/quest/creature_quest_starter_view.dart';
import 'package:foxy/page/quest/game_object_quest_ender_view.dart';
import 'package:foxy/page/quest/game_object_quest_starter_view.dart';
import 'package:foxy/page/quest/quest_offer_reward_view.dart';
import 'package:foxy/page/quest/quest_request_items_view.dart';
import 'package:foxy/page/quest/quest_template_addon_view.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class QuestTemplateDetailPage extends StatefulWidget {
  final int? entry;
  final String? name;

  const QuestTemplateDetailPage({super.key, this.entry, this.name});

  @override
  State<QuestTemplateDetailPage> createState() =>
      _QuestTemplateDetailPageState();
}

class _QuestTemplateDetailPageState extends State<QuestTemplateDetailPage> {
  final viewModel = GetIt.instance.get<QuestTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(questId: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('任务模板'),
      Text('模版补充'),
      Text('提交物品'),
      Text('发放奖励'),
      Text('开始生物'),
      Text('结束生物'),
      Text('开始物体'),
      Text('结束物体'),
    ];

    var tabContents = [
      QuestTemplateView(questId: widget.entry ?? 0),
      QuestTemplateAddonView(questId: widget.entry ?? 0),
      QuestRequestItemsView(questId: widget.entry ?? 0),
      QuestOfferRewardView(questId: widget.entry ?? 0),
      CreatureQueststarterView(questId: widget.entry ?? 0),
      CreatureQuestEnderView(questId: widget.entry ?? 0),
      GameObjectQuestStarterView(questId: widget.entry ?? 0),
      GameObjectQuestEnderView(questId: widget.entry ?? 0),
    ];

    var tabBar = Watch((_) {
      return FoxyTab(tabs: tabs, contents: tabContents);
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true ? widget.name! : '新建任务';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
