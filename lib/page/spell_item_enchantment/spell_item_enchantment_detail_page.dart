import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class SpellItemEnchantmentDetailPage extends StatefulWidget {
  final int? id;
  final String? name;

  const SpellItemEnchantmentDetailPage({super.key, this.id, this.name});

  @override
  State<SpellItemEnchantmentDetailPage> createState() =>
      _SpellItemEnchantmentDetailPageState();
}

class _SpellItemEnchantmentDetailPageState
    extends State<SpellItemEnchantmentDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [Text('法术附魔')];

    var tabContents = [SpellItemEnchantmentView(entry: widget.id)];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true
        ? widget.name!
        : (widget.id != null ? '法术附魔 #${widget.id}' : '新建法术附魔');
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
