import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_view_model.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ItemExtendedCostDetailPage extends StatefulWidget {
  final int? id;

  const ItemExtendedCostDetailPage({super.key, this.id});

  @override
  State<ItemExtendedCostDetailPage> createState() => _ItemExtendedCostDetailPageState();
}

class _ItemExtendedCostDetailPageState extends State<ItemExtendedCostDetailPage> {
  final viewModel = GetIt.instance.get<ItemExtendedCostDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('扩展价格'),
    ];

    var tabContents = [
      ItemExtendedCostView(entry: widget.id),
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
    var name = widget.id != null ? '扩展价格 #${widget.id}' : '新建扩展价格';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
