import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/currency_type/currency_type_view.dart';
import 'package:foxy/widget/tab.dart';

@RoutePage()
class CurrencyTypeDetailPage extends StatefulWidget {
  final int? id;

  const CurrencyTypeDetailPage({super.key, this.id});

  @override
  State<CurrencyTypeDetailPage> createState() => _CurrencyTypeDetailPageState();
}

class _CurrencyTypeDetailPageState extends State<CurrencyTypeDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('货币')];

    var tabContents = [CurrencyTypeView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id != null ? '货币 #${widget.id}' : '新建货币';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
