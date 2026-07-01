import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_view.dart';
import 'package:foxy/widget/tab.dart';

@RoutePage()
class QuestFactionRewardDetailPage extends StatefulWidget {
  final int? id;

  const QuestFactionRewardDetailPage({super.key, this.id});

  @override
  State<QuestFactionRewardDetailPage> createState() =>
      _QuestFactionRewardDetailPageState();
}

class _QuestFactionRewardDetailPageState
    extends State<QuestFactionRewardDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('任务声望')];

    var tabContents = [QuestFactionRewardView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id != null ? '任务声望 #${widget.id}' : '新建任务声望';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
