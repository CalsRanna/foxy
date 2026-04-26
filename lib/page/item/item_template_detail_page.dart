import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/item/item_template_view.dart';
import 'package:foxy/page/item/item_enchantment_template_view.dart';
import 'package:foxy/page/item/item_loot_template_view.dart';
import 'package:foxy/page/item/disenchant_loot_template_view.dart';
import 'package:foxy/page/item/prospecting_loot_template_view.dart';
import 'package:foxy/page/item/milling_loot_template_view.dart';
import 'package:foxy/widget/tab.dart';

@RoutePage()
class ItemTemplateDetailPage extends StatefulWidget {
  final int? entry;
  final String? name;

  const ItemTemplateDetailPage({super.key, this.entry, this.name});

  @override
  State<ItemTemplateDetailPage> createState() => _ItemTemplateDetailPageState();
}

class _ItemTemplateDetailPageState extends State<ItemTemplateDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('物品模板'),
      Text('附魔模板'),
      Text('物品掉落'),
      Text('分解掉落'),
      Text('选矿掉落'),
      Text('研磨掉落'),
    ];

    var tabContents = [
      ItemTemplateView(entry: widget.entry),
      ItemEnchantmentTemplateView(entry: widget.entry ?? 0),
      ItemLootTemplateView(entry: widget.entry ?? 0),
      DisenchantLootTemplateView(entry: widget.entry ?? 0),
      ProspectingLootTemplateView(entry: widget.entry ?? 0),
      MillingLootTemplateView(entry: widget.entry ?? 0),
    ];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true ? widget.name! : '新建物品';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
