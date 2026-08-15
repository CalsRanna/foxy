import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/creature_template/creature_equip_template_view.dart';
import 'package:foxy/page/creature_template/creature_loot_template_view.dart';
import 'package:foxy/page/creature_template/creature_on_kill_reputation_view.dart';
import 'package:foxy/page/creature_template/creature_quest_item_view.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view.dart';
import 'package:foxy/page/creature_template/creature_template_resistance_view.dart';
import 'package:foxy/page/creature_template/creature_template_spell_view.dart';
import 'package:foxy/page/creature_template/creature_template_view.dart';
import 'package:foxy/page/creature_template/npc_trainer_view.dart';
import 'package:foxy/page/creature_template/npc_vendor_view.dart';
import 'package:foxy/page/creature_template/pickpocketing_loot_template_view.dart';
import 'package:foxy/page/creature_template/skinning_loot_template_view.dart';
import 'package:foxy/view_model/creature_template_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';



@RoutePage()
class CreatureTemplateDetailPage extends StatefulWidget {

  static Set<int> disabledTabIndexes(int? entry, int tabCount) {
  if (entry != null && entry > 0) return const {};
  return {for (var index = 1; index < tabCount; index++) index};
}

  final int? creatureTemplateKey;

  const CreatureTemplateDetailPage({super.key, this.creatureTemplateKey});

  @override
  State<CreatureTemplateDetailPage> createState() =>
      _CreatureTemplateDetailPageState();
}

class _CreatureTemplateDetailPageState
    extends State<CreatureTemplateDetailPage> {
  final viewModel = GetIt.instance.get<CreatureTemplateDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    const tabs = [
      Text('生物模板'),
      Text('模板补充'),
      Text('击杀声望'),
      Text('抗性'),
      Text('技能'),
      Text('装备模板'),
      Text('任务物品'),
      Text('商人'),
      Text('训练师'),
      Text('击杀掉落'),
      Text('偷窃掉落'),
      Text('剥皮掉落'),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '生物详情',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Watch((_) {
          final key = viewModel.persistedKey.value;
          final template = viewModel.entity.value;
          final creatureId = key ?? 0;
          return FoxyTab(
            tabs: tabs,
            contents: [
              CreatureTemplateView(
                key: ValueKey('main-$key'),
                viewModel: viewModel,
              ),
              CreatureTemplateAddonView(
                key: ValueKey('addon-$creatureId'),
                creatureId: creatureId,
              ),
              CreatureOnKillReputationView(
                key: ValueKey('reputation-$creatureId'),
                creatureId: creatureId,
              ),
              CreatureTemplateResistanceView(
                key: ValueKey('resistance-$creatureId'),
                creatureId: creatureId,
              ),
              CreatureTemplateSpellView(
                key: ValueKey('spell-$creatureId'),
                creatureId: creatureId,
              ),
              CreatureEquipTemplateView(
                key: ValueKey('equip-$creatureId'),
                creatureId: creatureId,
              ),
              CreatureQuestItemView(
                key: ValueKey('quest-item-$creatureId'),
                creatureId: creatureId,
              ),
              NpcVendorView(
                key: ValueKey('vendor-$creatureId'),
                creatureId: creatureId,
              ),
              NpcTrainerView(
                key: ValueKey('trainer-$creatureId'),
                creatureId: creatureId,
              ),
              CreatureLootTemplateView(
                key: ValueKey('loot-${template?.lootId ?? 0}'),
                linkKey: template?.lootId ?? 0,
              ),
              PickpocketingLootTemplateView(
                key: ValueKey('pickpocket-${template?.pickpocketLoot ?? 0}'),
                linkKey: template?.pickpocketLoot ?? 0,
              ),
              SkinningLootTemplateView(
                key: ValueKey('skinning-${template?.skinLoot ?? 0}'),
                linkKey: template?.skinLoot ?? 0,
              ),
            ],
            disabledIndexes: CreatureTemplateDetailPage.disabledTabIndexes(
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
      await viewModel.initSignals(key: widget.creatureTemplateKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
