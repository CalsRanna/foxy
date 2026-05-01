import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/achievement/achievement_detail_view_model.dart';
import 'package:foxy/page/achievement/achievement_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class AchievementDetailPage extends StatefulWidget {
  final int? id;

  const AchievementDetailPage({super.key, this.id});

  @override
  State<AchievementDetailPage> createState() => _AchievementDetailPageState();
}

class _AchievementDetailPageState extends State<AchievementDetailPage> {
  final viewModel = GetIt.instance.get<AchievementDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('成就'),
    ];

    var tabContents = [
      AchievementView(entry: widget.id),
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
    var name = widget.id != null ? '成就 #${widget.id}' : '新建成就';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
