import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_area_view.dart';
import 'package:foxy/page/spell/spell_bonus_data_view.dart';
import 'package:foxy/page/spell/spell_custom_attr_view.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/page/spell/spell_group_view.dart';
import 'package:foxy/page/spell/spell_linked_spell_view.dart';
import 'package:foxy/page/spell/spell_loot_template_view.dart';
import 'package:foxy/page/spell/spell_rank_view.dart';
import 'package:foxy/page/spell/spell_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class SpellDetailPage extends StatefulWidget {
  final int? id;
  final String? name;

  const SpellDetailPage({super.key, this.id, this.name});

  @override
  State<SpellDetailPage> createState() => _SpellDetailPageState();
}

class _SpellDetailPageState extends State<SpellDetailPage> {
  final viewModel = GetIt.instance.get<SpellDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var spellId = widget.id ?? 0;

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
      SpellView(id: widget.id),
      SpellBonusDataView(spellId: spellId),
      SpellCustomAttrView(spellId: spellId),
      SpellAreaView(spellId: spellId),
      SpellGroupView(spellId: spellId),
      SpellLinkedSpellView(spellId: spellId),
      SpellRankView(spellId: spellId),
      SpellLootTemplateView(spellId: spellId),
    ];

    var tabBar = Watch((_) {
      return FoxyTab(tabs: tabs, contents: tabContents);
    });

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
