import 'package:auto_route/auto_route.dart';
import 'package:foxy/router/router.gr.dart';

@AutoRouterConfig()
class FoxyRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType {
    return RouteType.custom(
      duration: Duration.zero,
      reverseDuration: Duration.zero,
    );
  }

  @override
  List<AutoRoute> get routes {
    final settingChildren = [
      AutoRoute(page: BasicSettingRoute.page, initial: true),
      AutoRoute(page: DatabaseSettingRoute.page),
    ];
    final children = [
      /// Scaffold
      AutoRoute(page: DashboardRoute.page),
      AutoRoute(page: CreatureTemplateListRoute.page),
      AutoRoute(page: ItemTemplateListRoute.page),
      AutoRoute(page: GameObjectTemplateListRoute.page),
      AutoRoute(page: QuestTemplateListRoute.page),
      AutoRoute(page: QuestTemplateDetailRoute.page),
      AutoRoute(page: GossipMenuListRoute.page),
      AutoRoute(page: SmartScriptListRoute.page),
      AutoRoute(page: SettingRoute.page, children: settingChildren),

      /// Creature Template
      AutoRoute(page: CreatureTemplateDetailRoute.page),

      /// Smart Script
      AutoRoute(page: SmartScriptDetailRoute.page),

      /// Spell
      AutoRoute(page: SpellListRoute.page),
      AutoRoute(page: SpellDetailRoute.page),

      /// GameObject Template
      AutoRoute(page: GameObjectTemplateDetailRoute.page),

      /// Gossip Menu
      AutoRoute(page: GossipMenuDetailRoute.page),

      /// Item Template
      AutoRoute(page: ItemTemplateDetailRoute.page),

      /// Reference Loot Template
      AutoRoute(page: ReferenceLootTemplateListRoute.page),
      AutoRoute(page: ReferenceLootTemplateDetailRoute.page),

      /// Page Text
      AutoRoute(page: TextContentListRoute.page),
      AutoRoute(page: TextContentDetailRoute.page),

      /// Condition
      AutoRoute(page: ConditionListRoute.page),
      AutoRoute(page: ConditionDetailRoute.page),

      /// AreaTable
      AutoRoute(page: AreaTableListRoute.page),
      AutoRoute(page: AreaTableDetailRoute.page),

      /// EmoteText
      AutoRoute(page: EmoteTextListRoute.page),
      AutoRoute(page: EmoteTextDetailRoute.page),

      /// QuestFactionReward
      AutoRoute(page: QuestFactionRewardListRoute.page),
      AutoRoute(page: QuestFactionRewardDetailRoute.page),

      /// QuestSort
      AutoRoute(page: QuestSortListRoute.page),
      AutoRoute(page: QuestSortDetailRoute.page),

      /// QuestInfo
      AutoRoute(page: QuestInfoListRoute.page),
      AutoRoute(page: QuestInfoDetailRoute.page),

      /// Player Create Info
      AutoRoute(page: PlayerCreateInfoListRoute.page),
      AutoRoute(page: PlayerCreateInfoDetailRoute.page),

      /// More
      AutoRoute(page: MoreRoute.page),
    ];
    return [
      AutoRoute(page: BootstrapRoute.page, initial: true),
      AutoRoute(page: ScaffoldRoute.page, children: children),
    ];
  }
}

final router = FoxyRouter();
