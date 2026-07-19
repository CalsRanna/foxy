import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

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
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.scalingStatValueKey);
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
      final name = key == null ? '新建缩放属性值' : '缩放属性值 #$key';
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
            tabs: const [Text('缩放属性值')],
            contents: [ScalingStatValueView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
