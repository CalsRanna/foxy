import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/item_template_key.dart';
import 'package:foxy/page/item/disenchant_loot_template_view.dart';
import 'package:foxy/page/item/item_enchantment_template_view.dart';
import 'package:foxy/page/item/item_loot_template_view.dart';
import 'package:foxy/page/item/item_template_detail_view_model.dart';
import 'package:foxy/page/item/item_template_view.dart';
import 'package:foxy/page/item/milling_loot_template_view.dart';
import 'package:foxy/page/item/prospecting_loot_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class ItemTemplateDetailPage extends StatefulWidget {
  final ItemTemplateKey? itemTemplateKey;

  const ItemTemplateDetailPage({super.key, this.itemTemplateKey});

  @override
  State<ItemTemplateDetailPage> createState() => _ItemTemplateDetailPageState();
}

class _ItemTemplateDetailPageState extends State<ItemTemplateDetailPage> {
  final viewModel = GetIt.instance.get<ItemTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.itemTemplateKey);
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
      final template = viewModel.template.value;
      final entry = key?.entry ?? 0;
      final name = key == null
          ? '新建物品'
          : template.name.isNotEmpty
          ? template.name
          : '物品 #${key.entry}';
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
            tabs: const [
              Text('物品模板'),
              Text('随机附魔组'),
              Text('物品掉落'),
              Text('分解掉落'),
              Text('选矿掉落'),
              Text('研磨掉落'),
            ],
            contents: [
              ItemTemplateView(viewModel: viewModel),
              ItemEnchantmentTemplateView(
                key: ValueKey('enchantment-$entry'),
                entry: entry,
              ),
              ItemLootTemplateView(key: ValueKey('loot-$entry'), entry: entry),
              DisenchantLootTemplateView(
                key: ValueKey('disenchant-$entry'),
                entry: entry,
              ),
              ProspectingLootTemplateView(
                key: ValueKey('prospecting-$entry'),
                entry: entry,
              ),
              MillingLootTemplateView(
                key: ValueKey('milling-$entry'),
                entry: entry,
              ),
            ],
            disabledIndexes: key == null ? const {1, 2, 3, 4, 5} : const {},
          ),
        ],
      );
    });
  }
}
