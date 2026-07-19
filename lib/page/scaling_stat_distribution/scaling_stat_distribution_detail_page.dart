import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/scaling_stat_distribution_key.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class ScalingStatDistributionDetailPage extends StatefulWidget {
  final ScalingStatDistributionKey? scalingStatDistributionKey;

  const ScalingStatDistributionDetailPage({
    super.key,
    this.scalingStatDistributionKey,
  });

  @override
  State<ScalingStatDistributionDetailPage> createState() =>
      _ScalingStatDistributionDetailPageState();
}

class _ScalingStatDistributionDetailPageState
    extends State<ScalingStatDistributionDetailPage> {
  final viewModel = GetIt.instance
      .get<ScalingStatDistributionDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.scalingStatDistributionKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final key = viewModel.persistedKey.value;
      final name = key == null ? '新建属性缩放分布' : '属性缩放分布 #${key.id}';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [Text('属性缩放分布')],
            contents: [ScalingStatDistributionView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
