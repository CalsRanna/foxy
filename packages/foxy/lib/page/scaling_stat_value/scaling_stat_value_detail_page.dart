import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_view.dart';
import 'package:foxy/view_model/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ScalingStatValueDetailPage extends StatefulWidget {
  final int? scalingStatValueKey;

  const ScalingStatValueDetailPage({super.key, this.scalingStatValueKey});

  @override
  State<ScalingStatValueDetailPage> createState() =>
      _ScalingStatValueDetailPageState();
}

class _ScalingStatValueDetailPageState
    extends State<ScalingStatValueDetailPage> {
  final viewModel = GetIt.instance.get<ScalingStatValueDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '缩放属性值详情',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: const [Text('缩放属性值')],
          contents: [ScalingStatValueView(viewModel: viewModel)],
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
      await viewModel.initSignals(key: widget.scalingStatValueKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
