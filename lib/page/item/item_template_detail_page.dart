import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/item/item_template_view.dart';
import 'package:foxy/page/item/item_enchantment_template_view.dart';
import 'package:foxy/page/item/item_loot_template_view.dart';
import 'package:foxy/page/item/disenchant_loot_template_view.dart';
import 'package:foxy/page/item/prospecting_loot_template_view.dart';
import 'package:foxy/page/item/milling_loot_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class ItemTemplateDetailPage extends StatefulWidget {
  final int? entry;
  final String? name;

  const ItemTemplateDetailPage({super.key, this.entry, this.name});

  @override
  State<ItemTemplateDetailPage> createState() => _ItemTemplateDetailPageState();
}

class _ItemTemplateDetailPageState extends State<ItemTemplateDetailPage> {
  late int? entry = widget.entry;

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('物品模板'),
      Text('随机附魔组'),
      Text('物品掉落'),
      Text('分解掉落'),
      Text('选矿掉落'),
      Text('研磨掉落'),
    ];

    var tabContents = [
      ItemTemplateView(
        entry: entry,
        onSaved: (value) => setState(() => entry = value),
      ),
      ItemEnchantmentTemplateView(entry: entry ?? 0),
      ItemLootTemplateView(entry: entry ?? 0),
      DisenchantLootTemplateView(entry: entry ?? 0),
      ProspectingLootTemplateView(entry: entry ?? 0),
      MillingLootTemplateView(entry: entry ?? 0),
    ];

    var tabBar = FoxyTab(
      tabs: tabs,
      contents: tabContents,
      disabledIndexes: entry == null ? const {1, 2, 3, 4, 5} : const {},
    );

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
