import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/quest_sort/quest_sort_detail_view_model.dart';
import 'package:foxy/page/quest_sort/quest_sort_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class QuestSortDetailPage extends StatefulWidget {
  final int? id;

  const QuestSortDetailPage({super.key, this.id});

  @override
  State<QuestSortDetailPage> createState() => _QuestSortDetailPageState();
}

class _QuestSortDetailPageState extends State<QuestSortDetailPage> {
  final viewModel = GetIt.instance.get<QuestSortDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('任务排序'),
    ];

    var tabContents = [
      QuestSortView(entry: widget.id),
    ];

    var tabBar = Watch((_) {
      return FoxyTab(
        tabs: tabs,
        contents: tabContents,
      );
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id != null ? '任务排序 #${widget.id}' : '新建任务排序';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
