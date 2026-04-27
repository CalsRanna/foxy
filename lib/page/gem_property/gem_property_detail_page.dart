import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/gem_property/gem_property_detail_view_model.dart';
import 'package:foxy/page/gem_property/gem_property_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class GemPropertyDetailPage extends StatefulWidget {
  final int? id;

  const GemPropertyDetailPage({super.key, this.id});

  @override
  State<GemPropertyDetailPage> createState() => _GemPropertyDetailPageState();
}

class _GemPropertyDetailPageState extends State<GemPropertyDetailPage> {
  final viewModel = GetIt.instance.get<GemPropertyDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('宝石属性'),
    ];

    var tabContents = [
      GemPropertyView(entry: widget.id),
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
    var name = widget.id != null ? '宝石属性 #${widget.id}' : '新建宝石属性';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
