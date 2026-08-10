import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/area_table/area_table_view.dart';
import 'package:foxy/view_model/area_table_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AreaTableDetailPage extends StatefulWidget {
  final int? areaTableKey;

  const AreaTableDetailPage({super.key, this.areaTableKey});

  @override
  State<AreaTableDetailPage> createState() => _AreaTableDetailPageState();
}

class _AreaTableDetailPageState extends State<AreaTableDetailPage> {
  final viewModel = GetIt.instance.get<AreaTableDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '区域详情',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: const [Text('区域')],
          contents: [AreaTableView(viewModel: viewModel)],
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
      await viewModel.initSignals(key: widget.areaTableKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyError.message(error)}');
    }
  }
}
