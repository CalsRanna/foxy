import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest_sort/quest_sort_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class QuestSortDetailPage extends StatefulWidget {
  final int? id;
  final String? name;

  const QuestSortDetailPage({super.key, this.id, this.name});

  @override
  State<QuestSortDetailPage> createState() => _QuestSortDetailPageState();
}

class _QuestSortDetailPageState extends State<QuestSortDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('任务排序')];

    var tabContents = [QuestSortView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true
        ? widget.name!
        : (widget.id != null ? '任务排序 #${widget.id}' : '新建任务排序');
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
