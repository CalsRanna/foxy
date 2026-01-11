import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_view.dart';
import 'package:foxy/page/creature_template/tab/creature_equip_template_tab.dart';
import 'package:foxy/page/creature_template/tab/creature_loot_template_tab.dart';
import 'package:foxy/page/creature_template/tab/creature_onkill_reputation_tab.dart';
import 'package:foxy/page/creature_template/tab/creature_questitem_tab.dart';
import 'package:foxy/page/creature_template/tab/creature_template_addon_tab.dart';
import 'package:foxy/page/creature_template/tab/creature_template_resistance_tab.dart';
import 'package:foxy/page/creature_template/tab/creature_template_spell_tab.dart';
import 'package:foxy/page/creature_template/tab/npc_trainer_tab.dart';
import 'package:foxy/page/creature_template/tab/npc_vendor_tab.dart';
import 'package:foxy/page/creature_template/tab/pickpocketing_loot_template_tab.dart';
import 'package:foxy/page/creature_template/tab/skinning_loot_template_tab.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class CreatureTemplateDetailPage extends StatefulWidget {
  final int? entry;
  const CreatureTemplateDetailPage({super.key, this.entry});

  @override
  State<CreatureTemplateDetailPage> createState() =>
      _CreatureTemplateDetailPageState();
}

class _CreatureTemplateDetailPageState
    extends State<CreatureTemplateDetailPage> {
  final viewModel = GetIt.instance.get<CreatureTemplateDetailViewModel>();

  @override
  Widget build(BuildContext context) {
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
      // 生物模板（主内容）
      CreatureTemplateView(entry: widget.entry ?? 0),
      // 模板补充 Tab
      CreatureTemplateAddonTab(entry: widget.entry ?? 0),
      // 击杀声望 Tab
      CreatureOnkillReputationTab(creatureID: widget.entry ?? 0),
      // 抗性 Tab
      CreatureTemplateResistanceTab(creatureID: widget.entry ?? 0),
      // 技能 Tab
      CreatureTemplateSpellTab(creatureID: widget.entry ?? 0),
      // 装备模板 Tab
      CreatureEquipTemplateTab(creatureID: widget.entry ?? 0),
      // 任务物品 Tab
      CreatureQuestitemTab(creatureEntry: widget.entry ?? 0),
      // 商人 Tab
      NpcVendorTab(entry: widget.entry ?? 0),
      // 训练师 Tab
      NpcTrainerTab(id: widget.entry ?? 0),
      // 击杀掉落 Tab
      CreatureLootTemplateTab(lootId: viewModel.template.value.lootId),
      // 偷窃掉落 Tab
      PickpocketingLootTemplateTab(
        lootId: viewModel.template.value.pickpocketLoot,
      ),
      // 剥皮掉落 Tab
      SkinningLootTemplateTab(lootId: viewModel.template.value.skinLoot),
    ];

    // Tab容器
    var tabBar = Watch((_) {
      final t = viewModel.template.value;
      final disabledIndexes = <int>{};
      if ((t.npcFlag & 3968) == 0) disabledIndexes.add(7); // 商人
      if ((t.npcFlag & 4194416) == 0) disabledIndexes.add(8); // 训练师
      if (t.lootId == 0) disabledIndexes.add(9); // 击杀掉落
      if (t.pickpocketLoot == 0) disabledIndexes.add(10); // 偷窃掉落
      if (t.skinLoot == 0) disabledIndexes.add(11); // 剥皮掉落
      return FoxyTab(
        tabs: tabs,
        disabledIndexes: disabledIndexes,
        contents: tabContents,
      );
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    return Watch((_) {
      var creatureTemplate = viewModel.template.value.name;
      var name = creatureTemplate.isNotEmpty ? creatureTemplate : '新建生物';
      var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
      var text = Text(name, style: textStyle);
      var edgeInsets = EdgeInsets.only(bottom: 12);
      return Padding(padding: edgeInsets, child: text);
    });
  }
}
