import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/item_set/item_set_detail_view_model.dart';
import 'package:foxy/page/item_set/item_set_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ItemSetDetailPage extends StatefulWidget {
  final int? id;

  const ItemSetDetailPage({super.key, this.id});

  @override
  State<ItemSetDetailPage> createState() => _ItemSetDetailPageState();
}

class _ItemSetDetailPageState extends State<ItemSetDetailPage> {
  final viewModel = GetIt.instance.get<ItemSetDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('套装'),
    ];

    var tabContents = [
      ItemSetView(entry: widget.id),
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
    var name = widget.id != null ? '套装 #${widget.id}' : '新建套装';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
