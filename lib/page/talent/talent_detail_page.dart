import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/talent/talent_detail_view_model.dart';
import 'package:foxy/page/talent/talent_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class TalentDetailPage extends StatefulWidget {
  final int? id;

  const TalentDetailPage({super.key, this.id});

  @override
  State<TalentDetailPage> createState() => _TalentDetailPageState();
}

class _TalentDetailPageState extends State<TalentDetailPage> {
  final viewModel = GetIt.instance.get<TalentDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('天赋'),
    ];

    var tabContents = [
      TalentView(entry: widget.id),
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
    var name = widget.id != null ? '天赋 #${widget.id}' : '新建天赋';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
