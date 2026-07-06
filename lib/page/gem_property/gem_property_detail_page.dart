import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/gem_property/gem_property_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class GemPropertyDetailPage extends StatefulWidget {
  final int? id;

  const GemPropertyDetailPage({super.key, this.id});

  @override
  State<GemPropertyDetailPage> createState() => _GemPropertyDetailPageState();
}

class _GemPropertyDetailPageState extends State<GemPropertyDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('宝石属性')];

    var tabContents = [GemPropertyView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

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
