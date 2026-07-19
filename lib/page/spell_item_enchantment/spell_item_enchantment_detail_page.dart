import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/spell_item_enchantment_key.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class SpellItemEnchantmentDetailPage extends StatefulWidget {
  final SpellItemEnchantmentKey? spellItemEnchantmentKey;

  const SpellItemEnchantmentDetailPage({
    super.key,
    this.spellItemEnchantmentKey,
  });

  @override
  State<SpellItemEnchantmentDetailPage> createState() =>
      _SpellItemEnchantmentDetailPageState();
}

class _SpellItemEnchantmentDetailPageState
    extends State<SpellItemEnchantmentDetailPage> {
  final viewModel = GetIt.instance.get<SpellItemEnchantmentDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.spellItemEnchantmentKey);
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
      final entity = viewModel.enchantment.value;
      final name = key == null
          ? '新建法术附魔'
          : entity.nameLangZhCN.isNotEmpty
          ? entity.nameLangZhCN
          : '法术附魔 #${key.id}';
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
            tabs: const [Text('法术附魔')],
            contents: [SpellItemEnchantmentView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
