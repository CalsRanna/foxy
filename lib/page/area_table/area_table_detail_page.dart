import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/page/area_table/area_table_detail_view_model.dart';
import 'package:foxy/page/area_table/area_table_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

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
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.areaTableKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：$error');
    }
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
      final entity = viewModel.entity.value;
      final name = key == null
          ? '新建区域'
          : entity?.areaNameLangZhCN.isNotEmpty == true
          ? entity?.areaNameLangZhCN ?? ''
          : '区域 #$key';
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
            tabs: const [Text('区域')],
            contents: [AreaTableView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
