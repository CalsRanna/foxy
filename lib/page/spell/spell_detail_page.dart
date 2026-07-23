import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/page/spell/spell_area_view.dart';
import 'package:foxy/page/spell/spell_bonus_data_view.dart';
import 'package:foxy/page/spell/spell_custom_attr_view.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/page/spell/spell_group_view.dart';
import 'package:foxy/page/spell/spell_linked_spell_view.dart';
import 'package:foxy/page/spell/spell_loot_template_view.dart';
import 'package:foxy/page/spell/spell_rank_view.dart';
import 'package:foxy/page/spell/spell_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class SpellDetailPage extends StatefulWidget {
  final int? spellKey;

  const SpellDetailPage({super.key, this.spellKey});

  @override
  State<SpellDetailPage> createState() => _SpellDetailPageState();
}

class _SpellDetailPageState extends State<SpellDetailPage> {
  final viewModel = GetIt.instance.get<SpellDetailViewModel>();

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
      final spell = viewModel.entity.value;
      final spellId = key ?? 0;
      final name = spell?.nameLangZhCN.isNotEmpty == true
          ? spell?.nameLangZhCN ?? ''
          : spell?.nameLangEnUS.isNotEmpty == true
          ? spell?.nameLangEnUS ?? ''
          : key == null
          ? '新建法术'
          : '法术 #$key';
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
              Text('基本信息'),
              Text('奖励系数'),
              Text('自定义属性'),
              Text('区域技能'),
              Text('技能组'),
              Text('链接技能'),
              Text('技能排行'),
              Text('技能掉落'),
            ],
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
            disabledIndexes: key == null
                ? const {1, 2, 3, 4, 5, 6, 7}
                : const {},
          ),
        ],
      );
    });
  }
}
