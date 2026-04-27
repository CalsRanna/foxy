import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ScalingStatDistributionDetailPage extends StatefulWidget {
  final int? id;

  const ScalingStatDistributionDetailPage({super.key, this.id});

  @override
  State<ScalingStatDistributionDetailPage> createState() => _ScalingStatDistributionDetailPageState();
}

class _ScalingStatDistributionDetailPageState extends State<ScalingStatDistributionDetailPage> {
  final viewModel = GetIt.instance.get<ScalingStatDistributionDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('属性缩放分布'),
    ];

    var tabContents = [
      ScalingStatDistributionView(entry: widget.id),
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
    var name = widget.id != null ? '属性缩放分布 #${widget.id}' : '新建属性缩放分布';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
