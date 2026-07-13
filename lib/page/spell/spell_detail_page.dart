import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_area_view.dart';
import 'package:foxy/page/spell/spell_bonus_data_view.dart';
import 'package:foxy/page/spell/spell_custom_attr_view.dart';
import 'package:foxy/page/spell/spell_group_view.dart';
import 'package:foxy/page/spell/spell_linked_spell_view.dart';
import 'package:foxy/page/spell/spell_loot_template_view.dart';
import 'package:foxy/page/spell/spell_rank_view.dart';
import 'package:foxy/page/spell/spell_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

@RoutePage()
class SpellDetailPage extends StatefulWidget {
  final int? id;
  final String? name;

  const SpellDetailPage({super.key, this.id, this.name});

  @override
  State<SpellDetailPage> createState() => _SpellDetailPageState();
}

class _SpellDetailPageState extends State<SpellDetailPage> {
  late int? spellId = (widget.id ?? 0) > 0 ? widget.id : null;

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('基本信息'),
      Text('奖励系数'),
      Text('自定义属性'),
      Text('区域技能'),
      Text('技能组'),
      Text('链接技能'),
      Text('技能排行'),
      Text('技能掉落'),
    ];

    var tabContents = [
      SpellView(
        id: spellId,
        onSaved: (value) => setState(() => spellId = value),
      ),
      SpellBonusDataView(spellId: spellId ?? 0),
      SpellCustomAttrView(spellId: spellId ?? 0),
      SpellAreaView(spellId: spellId ?? 0),
      SpellGroupView(spellId: spellId ?? 0),
      SpellLinkedSpellView(spellId: spellId ?? 0),
      SpellRankView(spellId: spellId ?? 0),
      SpellLootTemplateView(spellId: spellId ?? 0),
    ];

    var tabBar = FoxyTab(
      tabs: tabs,
      contents: tabContents,
      disabledIndexes: spellId == null ? const {1, 2, 3, 4, 5, 6, 7} : const {},
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var label = widget.name?.isNotEmpty == true
        ? widget.name!
        : (widget.id != null ? '法术 ${widget.id}' : '新建法术');
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(label, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
