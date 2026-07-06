import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class ScalingStatDistributionDetailPage extends StatefulWidget {
  final int? id;

  const ScalingStatDistributionDetailPage({super.key, this.id});

  @override
  State<ScalingStatDistributionDetailPage> createState() =>
      _ScalingStatDistributionDetailPageState();
}

class _ScalingStatDistributionDetailPageState
    extends State<ScalingStatDistributionDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('属性缩放分布')];

    var tabContents = [ScalingStatDistributionView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id != null ? '属性缩放分布 #${widget.id}' : '新建属性缩放分布';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
