import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_parent_key.dart';
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
  final int? itemTemplateKey;

  const ItemTemplateDetailPage({super.key, this.itemTemplateKey});

  @override
  State<ItemTemplateDetailPage> createState() => _ItemTemplateDetailPageState();
}

class _ItemTemplateDetailPageState extends State<ItemTemplateDetailPage> {
  final viewModel = GetIt.instance.get<ItemTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.itemTemplateKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：$error');
    }
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
      final template = viewModel.entity.value;
      final entry = key ?? 0;
      final enchantmentParentKey = template == null
          ? null
          : template.randomProperty != 0
          ? ItemEnchantmentTemplateParentKey(
              entry: template.randomProperty,
              kind: ItemEnchantmentKind.randomProperty,
            )
          : template.randomSuffix != 0
          ? ItemEnchantmentTemplateParentKey(
              entry: template.randomSuffix,
              kind: ItemEnchantmentKind.randomSuffix,
            )
          : null;
      final name = key == null
          ? '新建物品'
          : template?.name.isNotEmpty == true
          ? template?.name ?? ''
          : '物品 #$key';
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
                key: ValueKey('enchantment-$enchantmentParentKey'),
                parentKey: enchantmentParentKey,
              ),
              ItemLootTemplateView(
                key: ValueKey('loot-$entry'),
                parentKey: entry,
              ),
              DisenchantLootTemplateView(
                key: ValueKey('disenchant-${template?.disenchantId ?? 0}'),
                parentKey: template?.disenchantId ?? 0,
              ),
              ProspectingLootTemplateView(
                key: ValueKey('prospecting-$entry'),
                parentKey: entry,
              ),
              MillingLootTemplateView(
                key: ValueKey('milling-$entry'),
                parentKey: entry,
              ),
            ],
            disabledIndexes: key == null ? const {1, 2, 3, 4, 5} : const {},
          ),
        ],
      );
    });
  }
}
