import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_view.dart';
import 'package:foxy/view_model/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ScalingStatDistributionDetailPage extends StatefulWidget {
  final int? scalingStatDistributionKey;

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
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoxyHeader('属性缩放分布详情'),
        ),
        FoxyTab(
          tabs: const [Text('属性缩放分布')],
          contents: [ScalingStatDistributionView(viewModel: viewModel)],
        ),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.scalingStatDistributionKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
