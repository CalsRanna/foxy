import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class ReferenceLootTemplateDetailPage extends StatefulWidget {
  final int? entry;
  final int? item;
  final String? label;

  const ReferenceLootTemplateDetailPage({
    super.key,
    this.entry,
    this.item,
    this.label,
  });

  @override
  State<ReferenceLootTemplateDetailPage> createState() =>
      _ReferenceLootTemplateDetailPageState();
}

class _ReferenceLootTemplateDetailPageState
    extends State<ReferenceLootTemplateDetailPage> {
  @override
  Widget build(BuildContext context) {
    var label = widget.label?.isNotEmpty == true ? widget.label! : '新建关联掉落';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: [Text('关联掉落')],
          contents: [
            ReferenceLootTemplateView(entry: widget.entry, item: widget.item),
          ],
        ),
      ],
    );
  }
}
