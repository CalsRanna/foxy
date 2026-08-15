import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_link_key.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/item/disenchant_loot_template_view.dart';
import 'package:foxy/page/item/item_enchantment_template_view.dart';
import 'package:foxy/page/item/item_loot_template_view.dart';
import 'package:foxy/page/item/item_template_view.dart';
import 'package:foxy/page/item/milling_loot_template_view.dart';
import 'package:foxy/page/item/prospecting_loot_template_view.dart';
import 'package:foxy/view_model/item_template_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
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
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '物品详情',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Watch((_) {
          final key = viewModel.persistedKey.value;
          final template = viewModel.entity.value;
          final entry = key ?? 0;
          final enchantmentParentKey = template == null
              ? null
              : template.randomProperty != 0
              ? ItemEnchantmentTemplateLinkKey(
                  entry: template.randomProperty,
                  kind: ItemEnchantmentKind.randomProperty,
                )
              : template.randomSuffix != 0
              ? ItemEnchantmentTemplateLinkKey(
                  entry: template.randomSuffix,
                  kind: ItemEnchantmentKind.randomSuffix,
                )
              : null;
          return FoxyTab(
            tabs: const [
              Text('物品模板'),
              Text('随机附魔组'),
              Text('物品掉落'),
              Text('分解掉落'),
              Text('选矿掉落'),
              Text('研磨掉落'),
            ],
            contents: [
              ItemTemplateView(
                key: ValueKey('main-$key'),
                viewModel: viewModel,
              ),
              ItemEnchantmentTemplateView(
                key: ValueKey('enchantment-$enchantmentParentKey'),
                linkKey: enchantmentParentKey,
              ),
              ItemLootTemplateView(
                key: ValueKey('loot-$entry'),
                linkKey: entry,
              ),
              DisenchantLootTemplateView(
                key: ValueKey('disenchant-${template?.disenchantId ?? 0}'),
                linkKey: template?.disenchantId ?? 0,
              ),
              ProspectingLootTemplateView(
                key: ValueKey('prospecting-$entry'),
                linkKey: entry,
              ),
              MillingLootTemplateView(
                key: ValueKey('milling-$entry'),
                linkKey: entry,
              ),
            ],
            disabledIndexes: key == null ? const {1, 2, 3, 4, 5} : const {},
          );
        }),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

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
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
