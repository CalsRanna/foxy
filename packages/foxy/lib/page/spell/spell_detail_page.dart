import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/spell/spell_area_view.dart';
import 'package:foxy/page/spell/spell_bonus_data_view.dart';
import 'package:foxy/page/spell/spell_custom_attr_view.dart';
import 'package:foxy/page/spell/spell_group_view.dart';
import 'package:foxy/page/spell/spell_linked_spell_view.dart';
import 'package:foxy/page/spell/spell_loot_template_view.dart';
import 'package:foxy/page/spell/spell_rank_view.dart';
import 'package:foxy/page/spell/spell_view.dart';
import 'package:foxy/view_model/spell_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class SpellDetailPage extends StatefulWidget {
  static Set<int> disabledTabIndexes(int? entry, int tabCount) {
    if (entry != null && entry > 0) return const {};
    return {for (var index = 1; index < tabCount; index++) index};
  }

  final int? spellKey;

  const SpellDetailPage({super.key, this.spellKey});

  @override
  State<SpellDetailPage> createState() => _SpellDetailPageState();
}

class _SpellDetailPageState extends State<SpellDetailPage> {
  final viewModel = GetIt.instance.get<SpellDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoxyHeader('法术详情'),
        ),
        Watch((_) {
          final key = viewModel.persistedKey.value;
          final spellId = key ?? 0;
          const tabs = [
            Text('基本信息'),
            Text('奖励系数'),
            Text('自定义属性'),
            Text('区域技能'),
            Text('技能组'),
            Text('链接技能'),
            Text('技能排行'),
            Text('技能掉落'),
          ];
          return FoxyTab(
            tabs: tabs,
            contents: [
              SpellView(viewModel: viewModel),
              SpellBonusDataView(
                key: ValueKey('bonus-$spellId'),
                spellId: spellId,
              ),
              SpellCustomAttrView(
                key: ValueKey('custom-$spellId'),
                spellId: spellId,
              ),
              SpellAreaView(key: ValueKey('area-$spellId'), spellId: spellId),
              SpellGroupView(key: ValueKey('group-$spellId'), spellId: spellId),
              SpellLinkedSpellView(
                key: ValueKey('linked-$spellId'),
                spellId: spellId,
              ),
              SpellRankView(key: ValueKey('rank-$spellId'), spellId: spellId),
              SpellLootTemplateView(
                key: ValueKey('loot-$spellId'),
                spellId: spellId,
              ),
            ],
            disabledIndexes: SpellDetailPage.disabledTabIndexes(
              key,
              tabs.length,
            ),
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
      await viewModel.initSignals(key: widget.spellKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
