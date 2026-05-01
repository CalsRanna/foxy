import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ScalingStatValueDetailPage extends StatefulWidget {
  final int? id;

  const ScalingStatValueDetailPage({super.key, this.id});

  @override
  State<ScalingStatValueDetailPage> createState() =>
      _ScalingStatValueDetailPageState();
}

class _ScalingStatValueDetailPageState
    extends State<ScalingStatValueDetailPage> {
  final viewModel = GetIt.instance.get<ScalingStatValueDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('缩放属性值'),
    ];

    var tabContents = [
      ScalingStatValueView(entry: widget.id),
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
    var name = widget.id != null ? '缩放属性值 #${widget.id}' : '新建缩放属性值';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
