import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_node.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Top-level menu enum
enum RouterMenu {
  dashboard(label: '工作台', icon: LucideIcons.layoutDashboard),
  creatureTemplate(label: '生物列表', icon: LucideIcons.pawPrint),
  itemTemplate(label: '物品列表', icon: LucideIcons.swords),
  questTemplate(label: '任务列表', icon: LucideIcons.badgeQuestionMark),
  gameObjectTemplate(label: '游戏对象列表', icon: LucideIcons.mapPin),
  gossipMenu(label: '对话列表', icon: LucideIcons.messageCircle),
  smartScript(label: '内建脚本列表', icon: LucideIcons.code),
  spell(label: '法术列表', icon: LucideIcons.shell),
  more(label: '更多', icon: LucideIcons.ellipsis),
  setting(label: '设置', icon: LucideIcons.settings),
  referenceLootTemplate(label: '关联掉落列表', icon: LucideIcons.list),
  pageText(label: '页面文本列表', icon: LucideIcons.bookOpen),
  condition(label: '条件列表', icon: LucideIcons.listFilter),
  playerCreateInfo(label: '出生信息列表', icon: LucideIcons.userPlus),
  areaTable(label: '区域列表', icon: LucideIcons.map),
  emoteText(label: '表情文本列表', icon: LucideIcons.laugh),
  questFactionReward(label: '任务声望列表', icon: LucideIcons.trophy),
  questSort(label: '任务排序列表', icon: LucideIcons.arrowUpDown),
  questInfo(label: '任务信息列表', icon: LucideIcons.info),
  itemExtendedCost(label: '扩展价格列表', icon: LucideIcons.coins),
  scalingStatDistribution(label: '属性缩放分布列表', icon: LucideIcons.arrowUpDown),
  spellItemEnchantment(label: '法术附魔列表', icon: LucideIcons.wand),
  gemProperty(label: '宝石属性列表', icon: LucideIcons.gem),
  glyphProperty(label: '雕文属性列表', icon: LucideIcons.triangle),
  talent(label: '天赋列表', icon: LucideIcons.sparkles),
  skillLine(label: '专业技能列表', icon: LucideIcons.hammer),
  currencyType(label: '货币列表', icon: LucideIcons.banknote),
  scalingStatValue(label: '缩放属性值列表', icon: LucideIcons.ruler),
  itemSet(label: '套装列表', icon: LucideIcons.layers),
  achievement(label: '成就列表', icon: LucideIcons.award);

  final String label;
  final IconData icon;

  const RouterMenu({required this.label, required this.icon});

  /// Returns the route for this menu
  PageRouteInfo get route {
    return switch (this) {
      RouterMenu.dashboard => const DashboardRoute(),
      RouterMenu.creatureTemplate => const CreatureTemplateListRoute(),
      RouterMenu.itemTemplate => const ItemTemplateListRoute(),
      RouterMenu.questTemplate => const QuestTemplateListRoute(),
      RouterMenu.gameObjectTemplate => const GameObjectTemplateListRoute(),
      RouterMenu.gossipMenu => const GossipMenuListRoute(),
      RouterMenu.smartScript => const SmartScriptListRoute(),
      RouterMenu.setting => const SettingRoute(),
      // These menus have no route implemented yet
      RouterMenu.spell => const SpellListRoute(),
      RouterMenu.more => const MoreRoute(),
      RouterMenu.referenceLootTemplate =>
        const ReferenceLootTemplateListRoute(),
      RouterMenu.pageText => const RouteTextListRoute(),
      RouterMenu.condition => const ConditionListRoute(),
      RouterMenu.playerCreateInfo => const PlayerCreateInfoListRoute(),
      RouterMenu.areaTable => const AreaTableListRoute(),
      RouterMenu.emoteText => const EmoteTextListRoute(),
      RouterMenu.questFactionReward => const QuestFactionRewardListRoute(),
      RouterMenu.questSort => const QuestSortListRoute(),
      RouterMenu.questInfo => const QuestInfoListRoute(),
      RouterMenu.itemExtendedCost => const ItemExtendedCostListRoute(),
      RouterMenu.scalingStatDistribution =>
        const ScalingStatDistributionListRoute(),
      RouterMenu.spellItemEnchantment => const SpellItemEnchantmentListRoute(),
      RouterMenu.gemProperty => const GemPropertyListRoute(),
      RouterMenu.glyphProperty => const GlyphPropertyListRoute(),
      RouterMenu.talent => const TalentListRoute(),
      RouterMenu.skillLine => const SkillLineListRoute(),
      RouterMenu.currencyType => const CurrencyTypeListRoute(),
      RouterMenu.scalingStatValue => const ScalingStatValueListRoute(),
      RouterMenu.itemSet => const ItemSetListRoute(),
      RouterMenu.achievement => const AchievementListRoute(),
    };
  }

  /// Creates a navigation node
  RouterNode toNode() {
    return RouterNode(menu: this, label: label, route: route);
  }
}
