import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest/creature_questender_view.dart';
import 'package:foxy/page/quest/creature_queststarter_view.dart';
import 'package:foxy/page/quest/gameobject_questender_view.dart';
import 'package:foxy/page/quest/gameobject_queststarter_view.dart';
import 'package:foxy/page/quest/quest_offer_reward_view.dart';
import 'package:foxy/page/quest/quest_request_items_view.dart';
import 'package:foxy/page/quest/quest_template_addon_view.dart';
import 'package:foxy/page/quest/quest_template_view.dart';
import 'package:foxy/widget/tab.dart';

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
      CreatureQuestenderView(questId: widget.entry ?? 0),
      GameobjectQueststarterView(questId: widget.entry ?? 0),
      GameobjectQuestenderView(questId: widget.entry ?? 0),
    ];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

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