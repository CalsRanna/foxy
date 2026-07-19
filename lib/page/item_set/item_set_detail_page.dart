import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/page/item_set/item_set_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class ItemSetDetailPage extends StatefulWidget {
  final int? itemSetKey;

  const ItemSetDetailPage({super.key, this.itemSetKey});

  @override
  State<ItemSetDetailPage> createState() => _ItemSetDetailPageState();
}

class _ItemSetDetailPageState extends State<ItemSetDetailPage> {
  final viewModel = GetIt.instance.get<ItemSetDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.itemSetKey);
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
      final entity = viewModel.itemSet.value;
      final name = key == null
          ? '新建套装'
          : entity.nameLangZhCN.isNotEmpty
          ? entity.nameLangZhCN
          : '套装 #$key';
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
            tabs: const [Text('套装')],
            contents: [ItemSetView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
