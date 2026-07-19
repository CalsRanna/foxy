import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/gem_property/gem_property_detail_view_model.dart';
import 'package:foxy/page/gem_property/gem_property_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class GemPropertyDetailPage extends StatefulWidget {
  final int? gemPropertyKey;

  const GemPropertyDetailPage({super.key, this.gemPropertyKey});

  @override
  State<GemPropertyDetailPage> createState() => _GemPropertyDetailPageState();
}

class _GemPropertyDetailPageState extends State<GemPropertyDetailPage> {
  final viewModel = GetIt.instance.get<GemPropertyDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.gemPropertyKey);
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
      final name = key == null ? '新建宝石属性' : '宝石属性 #$key';
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
            tabs: const [Text('宝石属性')],
            contents: [GemPropertyView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
