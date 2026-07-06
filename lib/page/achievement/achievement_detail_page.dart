import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/achievement/achievement_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class AchievementDetailPage extends StatefulWidget {
  final int? id;

  const AchievementDetailPage({super.key, this.id});

  @override
  State<AchievementDetailPage> createState() => _AchievementDetailPageState();
}

class _AchievementDetailPageState extends State<AchievementDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('成就')];

    var tabContents = [AchievementView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id != null ? '成就 #${widget.id}' : '新建成就';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
