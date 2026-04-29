import 'package:foxy/page/area_table/area_table_detail_view_model.dart';
import 'package:foxy/page/area_table/area_table_list_view_model.dart';
import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:foxy/page/condition/condition_detail_view_model.dart';
import 'package:foxy/page/condition/condition_list_view_model.dart';
import 'package:foxy/page/creature_template/creature_equip_template_view_model.dart';
import 'package:foxy/page/creature_template/creature_loot_template_view_model.dart';
import 'package:foxy/page/creature_template/creature_on_kill_reputation_view_model.dart';
import 'package:foxy/page/creature_template/creature_quest_item_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_list_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_resistance_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_spell_view_model.dart';
import 'package:foxy/page/creature_template/npc_trainer_view_model.dart';
import 'package:foxy/page/creature_template/npc_vendor_view_model.dart';
import 'package:foxy/page/creature_template/pickpocketing_loot_template_view_model.dart';
import 'package:foxy/page/creature_template/skinning_loot_template_view_model.dart';
import 'package:foxy/page/dashboard/dashboard_view_model.dart';
import 'package:foxy/page/emote_text/emote_text_detail_view_model.dart';
import 'package:foxy/page/emote_text/emote_text_list_view_model.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/page/game_object/game_object_loot_template_view_model.dart';
import 'package:foxy/page/game_object/game_object_quest_item_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_addon_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_detail_view_model.dart';
import 'package:foxy/page/game_object/game_object_template_list_view_model.dart';
import 'package:foxy/page/gem_property/gem_property_detail_view_model.dart';
import 'package:foxy/page/gem_property/gem_property_list_view_model.dart';
import 'package:foxy/page/glyph_property/glyph_property_detail_view_model.dart';
import 'package:foxy/page/glyph_property/glyph_property_list_view_model.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_detail_view_model.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_list_view_model.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_view_model.dart';
import 'package:foxy/page/gossip_menu/npc_text_view_model.dart';
import 'package:foxy/page/item/disenchant_loot_template_view_model.dart';
import 'package:foxy/page/item/item_enchantment_template_view_model.dart';
import 'package:foxy/page/item/item_loot_template_view_model.dart';
import 'package:foxy/page/item/item_template_detail_view_model.dart';
import 'package:foxy/page/item/item_template_list_view_model.dart';
import 'package:foxy/page/item/milling_loot_template_view_model.dart';
import 'package:foxy/page/item/prospecting_loot_template_view_model.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_detail_view_model.dart';
import 'package:foxy/page/item_extended_cost/item_extended_cost_list_view_model.dart';
import 'package:foxy/page/more/more_view_model.dart';
import 'package:foxy/page/page_text/page_text_detail_view_model.dart';
import 'package:foxy/page/page_text/page_text_list_view_model.dart';
import 'package:foxy/page/page_text/page_text_locale_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_action_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_item_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_list_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_spell_custom_view_model.dart';
import 'package:foxy/page/quest/creature_quest_ender_view_model.dart';
import 'package:foxy/page/quest/creature_quest_starter_view_model.dart';
import 'package:foxy/page/quest/game_object_quest_ender_view_model.dart';
import 'package:foxy/page/quest/game_object_quest_starter_view_model.dart';
import 'package:foxy/page/quest/quest_offer_reward_view_model.dart';
import 'package:foxy/page/quest/quest_request_items_view_model.dart';
import 'package:foxy/page/quest/quest_template_addon_view_model.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_list_view_model.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/page/quest_faction_reward/quest_faction_reward_list_view_model.dart';
import 'package:foxy/page/quest_info/quest_info_detail_view_model.dart';
import 'package:foxy/page/quest_info/quest_info_list_view_model.dart';
import 'package:foxy/page/quest_sort/quest_sort_detail_view_model.dart';
import 'package:foxy/page/quest_sort/quest_sort_list_view_model.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_view_model.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_list_view_model.dart';
import 'package:foxy/page/scaffold/dbc_import_view_model.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/page/scaling_stat_distribution/scaling_stat_distribution_list_view_model.dart';
import 'package:foxy/page/setting/setting_view_model.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/page/smart_script/smart_script_list_view_model.dart';
import 'package:foxy/page/spell/spell_area_view_model.dart';
import 'package:foxy/page/spell/spell_bonus_data_view_model.dart';
import 'package:foxy/page/spell/spell_custom_attr_view_model.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/page/spell/spell_group_view_model.dart';
import 'package:foxy/page/spell/spell_linked_spell_view_model.dart';
import 'package:foxy/page/spell/spell_list_view_model.dart';
import 'package:foxy/page/spell/spell_loot_template_view_model.dart';
import 'package:foxy/page/spell/spell_rank_view_model.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_list_view_model.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/feature_view_model.dart';
import 'package:get_it/get_it.dart';

class DI {
  static void ensureInitialized() {
    GetIt.instance.registerSingleton(RouterFacade());
    GetIt.instance.registerSingleton(FoxyViewModel());
    GetIt.instance.registerLazySingleton(() => ActivityLogRepository());
    GetIt.instance.registerLazySingleton(() => FeatureViewModel());
    GetIt.instance.registerFactory(() => BootstrapViewModel());
    GetIt.instance.registerLazySingleton(() => ScaffoldViewModel());
    GetIt.instance.registerSingleton(DbcImportViewModel());
    GetIt.instance.registerFactory(() => DashboardViewModel());
    GetIt.instance.registerLazySingleton(() => MoreViewModel());
    GetIt.instance.registerLazySingleton(() => CreatureTemplateListViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateDetailViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateAddonViewModel());
    GetIt.instance.registerFactory(() => CreatureOnKillReputationViewModel());
    GetIt.instance.registerFactory(() => CreatureEquipTemplateViewModel());
    GetIt.instance.registerFactory(() => CreatureQuestItemViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateResistanceViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateSpellViewModel());
    GetIt.instance.registerFactory(() => CreatureLootTemplateViewModel());
    GetIt.instance.registerFactory(() => NpcTrainerViewModel());
    GetIt.instance.registerFactory(() => NpcVendorViewModel());
    GetIt.instance.registerFactory(() => PickpocketingLootTemplateViewModel());
    GetIt.instance.registerFactory(() => SkinningLootTemplateViewModel());
    GetIt.instance.registerLazySingleton(
      () => GameObjectTemplateListViewModel(),
    );
    GetIt.instance.registerFactory(() => GameObjectTemplateDetailViewModel());
    GetIt.instance.registerFactory(() => GameObjectTemplateAddonViewModel());
    GetIt.instance.registerFactory(() => GameObjectQuestItemViewModel());
    GetIt.instance.registerFactory(() => GameObjectLootTemplateViewModel());
    GetIt.instance.registerLazySingleton(() => ItemTemplateListViewModel());
    GetIt.instance.registerFactory(() => ItemTemplateDetailViewModel());
    GetIt.instance.registerFactory(() => ItemLootTemplateViewModel());
    GetIt.instance.registerFactory(() => DisenchantLootTemplateViewModel());
    GetIt.instance.registerFactory(() => ProspectingLootTemplateViewModel());
    GetIt.instance.registerFactory(() => MillingLootTemplateViewModel());
    GetIt.instance.registerFactory(() => ItemEnchantmentTemplateViewModel());
    GetIt.instance.registerLazySingleton(() => GossipMenuListViewModel());
    GetIt.instance.registerLazySingleton(() => QuestTemplateListViewModel());
    GetIt.instance.registerFactory(() => QuestTemplateDetailViewModel());
    GetIt.instance.registerFactory(() => QuestTemplateAddonViewModel());
    GetIt.instance.registerFactory(() => QuestRequestItemsViewModel());
    GetIt.instance.registerFactory(() => QuestOfferRewardViewModel());
    GetIt.instance.registerFactory(() => CreatureQuestStarterViewModel());
    GetIt.instance.registerFactory(() => CreatureQuestEnderViewModel());
    GetIt.instance.registerFactory(() => GameObjectQuestStarterViewModel());
    GetIt.instance.registerFactory(() => GameObjectQuestEnderViewModel());
    GetIt.instance.registerFactory(() => GossipMenuDetailViewModel());
    GetIt.instance.registerFactory(() => NpcTextViewModel());
    GetIt.instance.registerFactory(() => GossipMenuOptionViewModel());
    GetIt.instance.registerFactory(() => SettingViewModel());
    GetIt.instance.registerLazySingleton(() => SmartScriptListViewModel());
    GetIt.instance.registerFactory(() => SmartScriptDetailViewModel());
    GetIt.instance.registerLazySingleton(() => SpellListViewModel());
    GetIt.instance.registerFactory(() => SpellDetailViewModel());
    GetIt.instance.registerFactory(() => SpellBonusDataViewModel());
    GetIt.instance.registerFactory(() => SpellCustomAttrViewModel());
    GetIt.instance.registerFactory(() => SpellAreaViewModel());
    GetIt.instance.registerFactory(() => SpellGroupViewModel());
    GetIt.instance.registerFactory(() => SpellLinkedSpellViewModel());
    GetIt.instance.registerFactory(() => SpellRankViewModel());
    GetIt.instance.registerFactory(() => SpellLootTemplateViewModel());
    GetIt.instance.registerLazySingleton(
      () => ReferenceLootTemplateListViewModel(),
    );
    GetIt.instance.registerFactory(
      () => ReferenceLootTemplateDetailViewModel(),
    );
    GetIt.instance.registerLazySingleton(() => PageTextListViewModel());
    GetIt.instance.registerFactory(() => PageTextDetailViewModel());
    GetIt.instance.registerFactory(() => PageTextLocaleViewModel());
    GetIt.instance.registerLazySingleton(() => ConditionListViewModel());
    GetIt.instance.registerFactory(() => ConditionDetailViewModel());
    GetIt.instance.registerLazySingleton(() => PlayerCreateInfoListViewModel());
    GetIt.instance.registerFactory(() => PlayerCreateInfoDetailViewModel());
    GetIt.instance.registerFactory(() => PlayerCreateInfoActionViewModel());
    GetIt.instance.registerFactory(() => PlayerCreateInfoItemViewModel());
    GetIt.instance.registerFactory(
      () => PlayerCreateInfoSpellCustomViewModel(),
    );
    GetIt.instance.registerLazySingleton(() => AreaTableListViewModel());
    GetIt.instance.registerFactory(() => AreaTableDetailViewModel());
    GetIt.instance.registerLazySingleton(() => EmoteTextListViewModel());
    GetIt.instance.registerFactory(() => EmoteTextDetailViewModel());
    GetIt.instance.registerLazySingleton(
      () => QuestFactionRewardListViewModel(),
    );
    GetIt.instance.registerFactory(() => QuestFactionRewardDetailViewModel());
    GetIt.instance.registerLazySingleton(() => QuestSortListViewModel());
    GetIt.instance.registerFactory(() => QuestSortDetailViewModel());
    GetIt.instance.registerLazySingleton(() => QuestInfoListViewModel());
    GetIt.instance.registerFactory(() => QuestInfoDetailViewModel());
    GetIt.instance.registerLazySingleton(() => ItemExtendedCostListViewModel());
    GetIt.instance.registerFactory(() => ItemExtendedCostDetailViewModel());
    GetIt.instance.registerLazySingleton(
      () => ScalingStatDistributionListViewModel(),
    );
    GetIt.instance.registerFactory(
      () => ScalingStatDistributionDetailViewModel(),
    );
    GetIt.instance.registerLazySingleton(
      () => SpellItemEnchantmentListViewModel(),
    );
    GetIt.instance.registerFactory(() => SpellItemEnchantmentDetailViewModel());
    GetIt.instance.registerLazySingleton(() => GemPropertyListViewModel());
    GetIt.instance.registerFactory(() => GemPropertyDetailViewModel());
    GetIt.instance.registerLazySingleton(() => GlyphPropertyListViewModel());
    GetIt.instance.registerFactory(() => GlyphPropertyDetailViewModel());
  }
}
