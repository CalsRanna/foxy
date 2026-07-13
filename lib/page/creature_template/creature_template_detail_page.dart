import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_view.dart';
import 'package:foxy/page/creature_template/creature_equip_template_view.dart';
import 'package:foxy/page/creature_template/creature_loot_template_view.dart';
import 'package:foxy/page/creature_template/creature_on_kill_reputation_view.dart';
import 'package:foxy/page/creature_template/creature_quest_item_view.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view.dart';
import 'package:foxy/page/creature_template/creature_template_resistance_view.dart';
import 'package:foxy/page/creature_template/creature_template_spell_view.dart';
import 'package:foxy/page/creature_template/npc_trainer_view.dart';
import 'package:foxy/page/creature_template/npc_vendor_view.dart';
import 'package:foxy/page/creature_template/pickpocketing_loot_template_view.dart';
import 'package:foxy/page/creature_template/skinning_loot_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';

Set<int> creatureTemplateDisabledTabIndexes(int? entry, int tabCount) {
  if (entry != null && entry > 0) return const {};
  return {for (var index = 1; index < tabCount; index++) index};
}

@RoutePage()
class CreatureTemplateDetailPage extends StatefulWidget {
  final int? entry;
  final String? name;

  const CreatureTemplateDetailPage({super.key, this.entry, this.name});

  @override
  State<CreatureTemplateDetailPage> createState() =>
      _CreatureTemplateDetailPageState();
}

class _CreatureTemplateDetailPageState
    extends State<CreatureTemplateDetailPage> {
  @override
  Widget build(BuildContext context) {
    final creatureId = widget.entry ?? 0;
    var tabs = [
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

    // Tab内容列表
    var tabContents = [
      // 生物模板（主内容）；新建时 entry 为 null，勿写成 0
      CreatureTemplateView(entry: widget.entry),
      // 模板补充 Tab
      CreatureTemplateAddonView(creatureId: creatureId),
      // 击杀声望 Tab
      CreatureOnKillReputationView(creatureId: creatureId),
      // 抗性 Tab
      CreatureTemplateResistanceView(creatureId: creatureId),
      // 技能 Tab
      CreatureTemplateSpellView(creatureId: creatureId),
      // 装备模板 Tab
      CreatureEquipTemplateView(creatureId: creatureId),
      // 任务物品 Tab
      CreatureQuestItemView(creatureId: creatureId),
      // 商人 Tab
      NpcVendorView(creatureId: creatureId),
      // 训练师 Tab
      NpcTrainerView(creatureId: creatureId),
      // 击杀掉落 Tab
      CreatureLootTemplateView(creatureId: creatureId),
      // 偷窃掉落 Tab
      PickpocketingLootTemplateView(creatureId: creatureId),
      // 剥皮掉落 Tab
      SkinningLootTemplateView(creatureId: creatureId),
    ];

    // Tab容器
    var tabBar = FoxyTab(
      tabs: tabs,
      contents: tabContents,
      disabledIndexes: creatureTemplateDisabledTabIndexes(
        widget.entry,
        tabs.length,
      ),
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.name?.isNotEmpty == true ? widget.name! : '新建生物';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
