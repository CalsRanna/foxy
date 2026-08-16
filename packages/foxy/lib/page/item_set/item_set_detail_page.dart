import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/item_set/item_set_view.dart';
import 'package:foxy/view_model/item_set_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';

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
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoxyHeader('套装详情'),
        ),
        FoxyTab(
          tabs: const [Text('套装')],
          contents: [ItemSetView(viewModel: viewModel)],
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
      await viewModel.initSignals(key: widget.itemSetKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
