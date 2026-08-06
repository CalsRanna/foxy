import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:foxy/repository/achievement_category_repository.dart';
import 'package:foxy/repository/achievement_criteria_repository.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/broadcast_text_repository.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/repository/cinematic_sequence_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/repository/creature_default_trainer_repository.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/repository/creature_immunity_repository.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/repository/creature_model_data_repository.dart';
import 'package:foxy/repository/creature_model_info_repository.dart';
import 'package:foxy/repository/creature_movement_info_repository.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/repository/creature_quest_ender_repository.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/repository/creature_quest_starter_repository.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/repository/creature_template_locale_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/repository/currency_category_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/repository/dbc_emote_repository.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/repository/dbc_faction_template_repository.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/destructible_model_data_repository.dart';
import 'package:foxy/repository/disenchant_loot_template_repository.dart';
import 'package:foxy/repository/emote_text_data_repository.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/repository/game_object_art_kit_repository.dart';
import 'package:foxy/repository/game_object_display_info_repository.dart';
import 'package:foxy/repository/game_object_loot_template_repository.dart';
import 'package:foxy/repository/game_object_quest_ender_repository.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/repository/game_object_quest_starter_repository.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/repository/game_object_template_locale_repository.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/holiday_repository.dart';
import 'package:foxy/repository/item_bag_family_repository.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/repository/item_limit_category_repository.dart';
import 'package:foxy/repository/item_loot_template_repository.dart';
import 'package:foxy/repository/item_purchase_group_repository.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/repository/item_template_locale_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/repository/item_visual_effect_repository.dart';
import 'package:foxy/repository/item_visuals_repository.dart';
import 'package:foxy/repository/light_repository.dart';
import 'package:foxy/repository/liquid_type_repository.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:foxy/repository/mail_template_repository.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/repository/milling_loot_template_repository.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/repository/page_text_locale_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/repository/pickpocketing_loot_template_repository.dart';
import 'package:foxy/repository/player_create_info_action_repository.dart';
import 'package:foxy/repository/player_create_info_cast_spell_repository.dart';
import 'package:foxy/repository/player_create_info_item_repository.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/repository/player_create_info_skill_repository.dart';
import 'package:foxy/repository/player_create_info_spell_custom_repository.dart';
import 'package:foxy/repository/point_of_interest_repository.dart';
import 'package:foxy/repository/prospecting_loot_template_repository.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_offer_reward_locale_repository.dart';
import 'package:foxy/repository/quest_offer_reward_repository.dart';
import 'package:foxy/repository/quest_request_items_locale_repository.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/repository/quest_template_locale_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/repository/setting_repository.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/repository/skinning_loot_template_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/repository/sound_ambience_repository.dart';
import 'package:foxy/repository/sound_provider_preferences_repository.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:foxy/repository/spell_focus_object_repository.dart';
import 'package:foxy/repository/spell_group_repository.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_condition_repository.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/repository/spell_linked_spell_repository.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/repository/talent_tab_repository.dart';
import 'package:foxy/repository/taxi_path_repository.dart';
import 'package:foxy/repository/totem_category_repository.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:foxy/repository/waypoint_data_repository.dart';
import 'package:foxy/repository/zone_intro_music_repository.dart';
import 'package:foxy/repository/zone_music_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/use_case/bootstrap/bootstrap_application_use_case.dart';
import 'package:foxy/use_case/creature_template/resolve_npc_trainer_parent_use_case.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/use_case/gossip_menu/copy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/create_gossip_menu_use_case.dart';
import 'package:foxy/use_case/gossip_menu/destroy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/destroy_npc_text_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_npc_text_use_case.dart';
import 'package:foxy/view_model/achievement_detail_view_model.dart';
import 'package:foxy/view_model/achievement_list_view_model.dart';
import 'package:foxy/view_model/area_table_detail_view_model.dart';
import 'package:foxy/view_model/area_table_list_view_model.dart';
import 'package:foxy/view_model/bootstrap_workflow_view_model.dart';
import 'package:foxy/view_model/condition_detail_view_model.dart';
import 'package:foxy/view_model/condition_list_view_model.dart';
import 'package:foxy/view_model/creature_equip_template_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_on_kill_reputation_linked_detail_view_model.dart';
import 'package:foxy/view_model/creature_quest_ender_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_quest_item_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_quest_starter_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_template_addon_linked_detail_view_model.dart';
import 'package:foxy/view_model/creature_template_detail_view_model.dart';
import 'package:foxy/view_model/creature_template_list_view_model.dart';
import 'package:foxy/view_model/creature_template_resistance_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_template_spell_linked_list_view_model.dart';
import 'package:foxy/view_model/currency_type_detail_view_model.dart';
import 'package:foxy/view_model/currency_type_list_view_model.dart';
import 'package:foxy/view_model/dashboard_read_view_model.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/disenchant_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/emote_text_detail_view_model.dart';
import 'package:foxy/view_model/emote_text_list_view_model.dart';
import 'package:foxy/view_model/feature_state_view_model.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/view_model/game_object_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/game_object_quest_ender_linked_list_view_model.dart';
import 'package:foxy/view_model/game_object_quest_item_linked_list_view_model.dart';
import 'package:foxy/view_model/game_object_quest_starter_linked_list_view_model.dart';
import 'package:foxy/view_model/game_object_template_addon_linked_detail_view_model.dart';
import 'package:foxy/view_model/game_object_template_detail_view_model.dart';
import 'package:foxy/view_model/game_object_template_list_view_model.dart';
import 'package:foxy/view_model/gem_property_detail_view_model.dart';
import 'package:foxy/view_model/gem_property_list_view_model.dart';
import 'package:foxy/view_model/glyph_property_detail_view_model.dart';
import 'package:foxy/view_model/glyph_property_list_view_model.dart';
import 'package:foxy/view_model/gossip_menu_detail_view_model.dart';
import 'package:foxy/view_model/gossip_menu_list_view_model.dart';
import 'package:foxy/view_model/gossip_menu_option_linked_list_view_model.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/item_enchantment_template_linked_list_view_model.dart';
import 'package:foxy/view_model/item_extended_cost_detail_view_model.dart';
import 'package:foxy/view_model/item_extended_cost_list_view_model.dart';
import 'package:foxy/view_model/item_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/item_set_detail_view_model.dart';
import 'package:foxy/view_model/item_set_list_view_model.dart';
import 'package:foxy/view_model/item_template_detail_view_model.dart';
import 'package:foxy/view_model/item_template_list_view_model.dart';
import 'package:foxy/view_model/milling_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/more_read_view_model.dart';
import 'package:foxy/view_model/npc_text_linked_detail_view_model.dart';
import 'package:foxy/view_model/npc_trainer_linked_list_view_model.dart';
import 'package:foxy/view_model/npc_vendor_linked_list_view_model.dart';
import 'package:foxy/view_model/page_text_detail_view_model.dart';
import 'package:foxy/view_model/page_text_list_view_model.dart';
import 'package:foxy/view_model/page_text_locale_linked_list_view_model.dart';
import 'package:foxy/view_model/pickpocketing_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/player_create_info_action_linked_list_view_model.dart';
import 'package:foxy/view_model/player_create_info_cast_spell_linked_list_view_model.dart';
import 'package:foxy/view_model/player_create_info_detail_view_model.dart';
import 'package:foxy/view_model/player_create_info_item_linked_list_view_model.dart';
import 'package:foxy/view_model/player_create_info_list_view_model.dart';
import 'package:foxy/view_model/player_create_info_skill_linked_list_view_model.dart';
import 'package:foxy/view_model/player_create_info_spell_custom_linked_list_view_model.dart';
import 'package:foxy/view_model/prospecting_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/quest_faction_reward_detail_view_model.dart';
import 'package:foxy/view_model/quest_faction_reward_list_view_model.dart';
import 'package:foxy/view_model/quest_info_detail_view_model.dart';
import 'package:foxy/view_model/quest_info_list_view_model.dart';
import 'package:foxy/view_model/quest_offer_reward_linked_detail_view_model.dart';
import 'package:foxy/view_model/quest_request_items_linked_detail_view_model.dart';
import 'package:foxy/view_model/quest_sort_detail_view_model.dart';
import 'package:foxy/view_model/quest_sort_list_view_model.dart';
import 'package:foxy/view_model/quest_template_addon_linked_detail_view_model.dart';
import 'package:foxy/view_model/quest_template_detail_view_model.dart';
import 'package:foxy/view_model/quest_template_list_view_model.dart';
import 'package:foxy/view_model/reference_loot_template_detail_view_model.dart';
import 'package:foxy/view_model/reference_loot_template_list_view_model.dart';
import 'package:foxy/view_model/scaling_stat_distribution_detail_view_model.dart';
import 'package:foxy/view_model/scaling_stat_distribution_list_view_model.dart';
import 'package:foxy/view_model/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/view_model/scaling_stat_value_list_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/skinning_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/view_model/smart_script_detail_view_model.dart';
import 'package:foxy/view_model/smart_script_list_view_model.dart';
import 'package:foxy/view_model/spell_area_linked_list_view_model.dart';
import 'package:foxy/view_model/spell_bonus_data_linked_detail_view_model.dart';
import 'package:foxy/view_model/spell_custom_attr_linked_detail_view_model.dart';
import 'package:foxy/view_model/spell_detail_view_model.dart';
import 'package:foxy/view_model/spell_group_linked_list_view_model.dart';
import 'package:foxy/view_model/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/view_model/spell_item_enchantment_list_view_model.dart';
import 'package:foxy/view_model/spell_linked_spell_linked_list_view_model.dart';
import 'package:foxy/view_model/spell_list_view_model.dart';
import 'package:foxy/view_model/spell_loot_template_linked_list_view_model.dart';
import 'package:foxy/view_model/spell_rank_linked_list_view_model.dart';
import 'package:foxy/view_model/talent_detail_view_model.dart';
import 'package:foxy/view_model/talent_list_view_model.dart';
import 'package:get_it/get_it.dart';

class DI {
  static final _instance = GetIt.instance;

  static void ensureInitialized() {
    _registerInfrastructure();
    _registerRepositories();
    _registerUseCases();
    _registerGlobalStateViewModels();
    _registerInteractionViewModels();
  }

  static void _registerGlobalStateViewModels() {
    _instance.registerSingleton(FoxyStateViewModel());
    _instance.registerSingleton(FeatureStateViewModel());
    _instance.registerSingleton(DbcImportWorkflowViewModel());
    _instance.registerSingleton(IconExtractWorkflowViewModel());
    _instance.registerSingleton(SetupStatusViewModel());
    _instance.registerSingleton(UpdateViewModel());
  }

  static void _registerInfrastructure() {
    _instance.registerSingleton(RouterFacade());
    _instance.registerSingleton(EventBus());
    _instance.registerSingleton(LocaleQuerySettings());
    _instance.registerLazySingleton(() => ConfigUtil());
    _instance.registerLazySingleton(() => const DatabaseTransaction());
    _instance.registerLazySingleton(() => DbcSyncUtil());
    _instance.registerLazySingleton(() => DbcExportRegistry());
    _instance.registerLazySingleton(
      () => ActivityLogService(_instance.get<ActivityLogRepository>()),
    );
  }

  static void _registerInteractionViewModels() {
    _instance.registerFactory(() => BootstrapWorkflowViewModel());
    _instance.registerFactory(() => DbcExportWorkflowViewModel());
    _instance.registerFactory(() => DashboardReadViewModel());
    _instance.registerFactory(() => MoreReadViewModel());
    _instance.registerFactory(() => CreatureTemplateListViewModel());
    _instance.registerFactory(() => CreatureTemplateDetailViewModel());
    _instance.registerFactory(
      () => CreatureTemplateAddonLinkedDetailViewModel(),
    );
    _instance.registerFactory(
      () => CreatureOnKillReputationLinkedDetailViewModel(),
    );
    _instance.registerFactory(
      () => CreatureEquipTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => CreatureQuestItemLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => CreatureTemplateResistanceLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => CreatureTemplateSpellLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => CreatureLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(() => NpcTrainerLinkedListViewModel());
    _instance.registerFactory(() => NpcVendorLinkedListViewModel());
    _instance.registerFactory(
      () => PickpocketingLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => SkinningLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(() => GameObjectTemplateListViewModel());
    _instance.registerFactory(() => GameObjectTemplateDetailViewModel());
    _instance.registerFactory(
      () => GameObjectTemplateAddonLinkedDetailViewModel(),
    );
    _instance.registerFactory(
      () => GameObjectQuestItemLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => GameObjectLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(() => ItemTemplateListViewModel());
    _instance.registerFactory(() => ItemTemplateDetailViewModel());
    _instance.registerFactory(
      () => ItemLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => DisenchantLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => ProspectingLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => MillingLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => ItemEnchantmentTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(() => GossipMenuListViewModel());
    _instance.registerFactory(() => QuestTemplateListViewModel());
    _instance.registerFactory(() => QuestTemplateDetailViewModel());
    _instance.registerFactory(() => QuestTemplateAddonLinkedDetailViewModel());
    _instance.registerFactory(() => QuestRequestItemsLinkedDetailViewModel());
    _instance.registerFactory(() => QuestOfferRewardLinkedDetailViewModel());
    _instance.registerFactory(
      () => CreatureQuestStarterLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => CreatureQuestEnderLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => GameObjectQuestStarterLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => GameObjectQuestEnderLinkedListViewModel(),
    );
    _instance.registerFactory(() => GossipMenuDetailViewModel());
    _instance.registerFactory(() => NpcTextLinkedDetailViewModel());
    _instance.registerFactory(
      () => GossipMenuOptionLinkedListViewModel(),
    );
    _instance.registerFactory(() => SmartScriptListViewModel());
    _instance.registerFactory(() => SmartScriptDetailViewModel());
    _instance.registerFactory(() => SpellListViewModel());
    _instance.registerFactory(() => SpellDetailViewModel());
    _instance.registerFactory(() => SpellBonusDataLinkedDetailViewModel());
    _instance.registerFactory(() => SpellCustomAttrLinkedDetailViewModel());
    _instance.registerFactory(() => SpellAreaLinkedListViewModel());
    _instance.registerFactory(() => SpellGroupLinkedListViewModel());
    _instance.registerFactory(
      () => SpellLinkedSpellLinkedListViewModel(),
    );
    _instance.registerFactory(() => SpellRankLinkedListViewModel());
    _instance.registerFactory(
      () => SpellLootTemplateLinkedListViewModel(),
    );
    _instance.registerFactory(() => ReferenceLootTemplateListViewModel());
    _instance.registerFactory(() => ReferenceLootTemplateDetailViewModel());
    _instance.registerFactory(() => PageTextListViewModel());
    _instance.registerFactory(() => PageTextDetailViewModel());
    _instance.registerFactory(() => PageTextLocaleLinkedListViewModel());
    _instance.registerFactory(() => ConditionListViewModel());
    _instance.registerFactory(() => ConditionDetailViewModel());
    _instance.registerFactory(() => PlayerCreateInfoListViewModel());
    _instance.registerFactory(() => PlayerCreateInfoDetailViewModel());
    _instance.registerFactory(
      () => PlayerCreateInfoActionLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => PlayerCreateInfoCastSpellLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => PlayerCreateInfoItemLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => PlayerCreateInfoSpellCustomLinkedListViewModel(),
    );
    _instance.registerFactory(
      () => PlayerCreateInfoSkillLinkedListViewModel(),
    );
    _instance.registerFactory(() => AreaTableListViewModel());
    _instance.registerFactory(() => AreaTableDetailViewModel());
    _instance.registerFactory(() => EmoteTextListViewModel());
    _instance.registerFactory(() => EmoteTextDetailViewModel());
    _instance.registerFactory(() => QuestFactionRewardListViewModel());
    _instance.registerFactory(() => QuestFactionRewardDetailViewModel());
    _instance.registerFactory(() => QuestSortListViewModel());
    _instance.registerFactory(() => QuestSortDetailViewModel());
    _instance.registerFactory(() => QuestInfoListViewModel());
    _instance.registerFactory(() => QuestInfoDetailViewModel());
    _instance.registerFactory(() => ItemExtendedCostListViewModel());
    _instance.registerFactory(() => ItemExtendedCostDetailViewModel());
    _instance.registerFactory(() => ScalingStatDistributionListViewModel());
    _instance.registerFactory(() => ScalingStatDistributionDetailViewModel());
    _instance.registerFactory(() => SpellItemEnchantmentListViewModel());
    _instance.registerFactory(() => SpellItemEnchantmentDetailViewModel());
    _instance.registerFactory(() => GemPropertyListViewModel());
    _instance.registerFactory(() => GemPropertyDetailViewModel());
    _instance.registerFactory(() => GlyphPropertyListViewModel());
    _instance.registerFactory(() => GlyphPropertyDetailViewModel());
    _instance.registerFactory(() => TalentListViewModel());
    _instance.registerFactory(() => TalentDetailViewModel());
    _instance.registerFactory(() => CurrencyTypeListViewModel());
    _instance.registerFactory(() => CurrencyTypeDetailViewModel());
    _instance.registerFactory(() => ScalingStatValueListViewModel());
    _instance.registerFactory(() => ScalingStatValueDetailViewModel());
    _instance.registerFactory(() => ItemSetListViewModel());
    _instance.registerFactory(() => ItemSetDetailViewModel());
    _instance.registerFactory(() => AchievementListViewModel());
    _instance.registerFactory(() => AchievementDetailViewModel());
  }

  static void _registerRepositories() {
    _instance.registerLazySingleton(() => AchievementRepository());
    _instance.registerLazySingleton(() => AchievementCategoryRepository());
    _instance.registerLazySingleton(() => AchievementCriteriaRepository());
    _instance.registerLazySingleton(() => ActivityLogRepository());
    _instance.registerLazySingleton(() => AreaTableRepository());
    _instance.registerLazySingleton(() => BroadcastTextRepository());
    _instance.registerLazySingleton(() => CharTitleRepository());
    _instance.registerLazySingleton(() => CinematicSequenceRepository());
    _instance.registerLazySingleton(() => ConditionRepository());
    _instance.registerLazySingleton(() => CreatureDisplayInfoRepository());
    _instance.registerLazySingleton(() => CreatureModelDataRepository());
    _instance.registerLazySingleton(() => CreatureEquipTemplateRepository());
    _instance.registerLazySingleton(() => CreatureModelInfoRepository());
    _instance.registerLazySingleton(() => CreatureMovementInfoRepository());
    _instance.registerLazySingleton(() => CreatureImmunityRepository());
    _instance.registerLazySingleton(() => CreatureOnKillReputationRepository());
    _instance.registerLazySingleton(() => CreatureQuestEnderRepository());
    _instance.registerLazySingleton(() => CreatureQuestItemRepository());
    _instance.registerLazySingleton(() => CreatureQuestStarterRepository());
    _instance.registerLazySingleton(() => CreatureSpellDataRepository());
    _instance.registerLazySingleton(() => CreatureTemplateAddonRepository());
    _instance.registerLazySingleton(() => CreatureTemplateLocaleRepository());
    _instance.registerLazySingleton(() => CreatureTemplateRepository());
    _instance.registerLazySingleton(
      () => CreatureTemplateResistanceRepository(),
    );
    _instance.registerLazySingleton(() => CreatureTemplateSpellRepository());
    _instance.registerLazySingleton(() => CreatureDefaultTrainerRepository());
    _instance.registerLazySingleton(() => CurrencyTypeRepository());
    _instance.registerLazySingleton(() => CurrencyCategoryRepository());
    _instance.registerLazySingleton(() => DestructibleModelDataRepository());
    _instance.registerLazySingleton(() => DbcFactionRepository());
    _instance.registerLazySingleton(() => DbcFactionTemplateRepository());
    _instance.registerLazySingleton(() => DbcEmoteRepository());
    _instance.registerLazySingleton(() => DbcItemRepository());
    _instance.registerLazySingleton(() => EmoteTextDataRepository());
    _instance.registerLazySingleton(() => EmoteTextRepository());
    _instance.registerLazySingleton(() => FeatureRepository());
    _instance.registerLazySingleton(() => GameObjectArtKitRepository());
    _instance.registerLazySingleton(() => GameObjectDisplayInfoRepository());
    _instance.registerLazySingleton(() => GameObjectQuestEnderRepository());
    _instance.registerLazySingleton(() => GameObjectQuestItemRepository());
    _instance.registerLazySingleton(() => GameObjectQuestStarterRepository());
    _instance.registerLazySingleton(() => GameObjectTemplateAddonRepository());
    _instance.registerLazySingleton(() => GameObjectTemplateLocaleRepository());
    _instance.registerLazySingleton(() => GameObjectTemplateRepository());
    _instance.registerLazySingleton(() => GemPropertyRepository());
    _instance.registerLazySingleton(() => GlyphPropertyRepository());
    _instance.registerLazySingleton(() => GossipMenuOptionLocaleRepository());
    _instance.registerLazySingleton(() => GossipMenuOptionRepository());
    _instance.registerLazySingleton(() => GossipMenuRepository());
    _instance.registerLazySingleton(() => HolidayRepository());
    _instance.registerLazySingleton(() => ItemDisplayInfoRepository());
    _instance.registerLazySingleton(() => ItemBagFamilyRepository());
    _instance.registerLazySingleton(() => ItemEnchantmentTemplateRepository());
    _instance.registerLazySingleton(() => ItemExtendedCostRepository());
    _instance.registerLazySingleton(() => ItemPurchaseGroupRepository());
    _instance.registerLazySingleton(() => ItemLimitCategoryRepository());
    _instance.registerLazySingleton(() => ItemRandomPropertiesRepository());
    _instance.registerLazySingleton(() => ItemRandomSuffixRepository());
    _instance.registerLazySingleton(() => ItemSetRepository());
    _instance.registerLazySingleton(() => ItemVisualEffectRepository());
    _instance.registerLazySingleton(() => ItemVisualsRepository());
    _instance.registerLazySingleton(() => ItemTemplateLocaleRepository());
    _instance.registerLazySingleton(() => ItemTemplateRepository());
    _instance.registerLazySingleton(() => LockRepository());
    _instance.registerLazySingleton(() => LightRepository());
    _instance.registerLazySingleton(() => LiquidTypeRepository());
    _instance.registerLazySingleton(() => MapInfoRepository());
    _instance.registerLazySingleton(() => MailTemplateRepository());
    _instance.registerLazySingleton(() => NpcTextLocaleRepository());
    _instance.registerLazySingleton(() => NpcTextRepository());
    _instance.registerLazySingleton(() => NpcTrainerRepository());
    _instance.registerLazySingleton(() => NpcVendorRepository());
    _instance.registerLazySingleton(() => PageTextLocaleRepository());
    _instance.registerLazySingleton(() => PageTextRepository());
    _instance.registerLazySingleton(() => PointOfInterestRepository());
    _instance.registerLazySingleton(() => PlayerCreateInfoRepository());
    _instance.registerLazySingleton(() => PlayerCreateInfoActionRepository());
    _instance.registerLazySingleton(
      () => PlayerCreateInfoCastSpellRepository(),
    );
    _instance.registerLazySingleton(() => PlayerCreateInfoItemRepository());
    _instance.registerLazySingleton(
      () => PlayerCreateInfoSpellCustomRepository(),
    );
    _instance.registerLazySingleton(() => PlayerCreateInfoSkillRepository());
    _instance.registerLazySingleton(() => QuestFactionRewardRepository());
    _instance.registerLazySingleton(() => QuestInfoRepository());
    _instance.registerLazySingleton(() => QuestOfferRewardLocaleRepository());
    _instance.registerLazySingleton(() => QuestOfferRewardRepository());
    _instance.registerLazySingleton(() => QuestRequestItemsLocaleRepository());
    _instance.registerLazySingleton(() => QuestRequestItemsRepository());
    _instance.registerLazySingleton(() => QuestSortRepository());
    _instance.registerLazySingleton(() => QuestTemplateAddonRepository());
    _instance.registerLazySingleton(() => QuestTemplateLocaleRepository());
    _instance.registerLazySingleton(() => QuestTemplateRepository());
    _instance.registerLazySingleton(() => ScalingStatDistributionRepository());
    _instance.registerLazySingleton(() => ScalingStatValueRepository());
    _instance.registerLazySingleton(() => SettingRepository());
    _instance.registerLazySingleton(() => SmartScriptRepository());
    _instance.registerLazySingleton(() => SpellAreaRepository());
    _instance.registerLazySingleton(() => SpellBonusDataRepository());
    _instance.registerLazySingleton(() => SpellCustomAttrRepository());
    _instance.registerLazySingleton(() => SpellDurationRepository());
    _instance.registerLazySingleton(() => SpellFocusObjectRepository());
    _instance.registerLazySingleton(() => SpellGroupRepository());
    _instance.registerLazySingleton(() => SpellIconRepository());
    _instance.registerLazySingleton(
      () => SpellItemEnchantmentConditionRepository(),
    );
    _instance.registerLazySingleton(() => SpellItemEnchantmentRepository());
    _instance.registerLazySingleton(() => SpellLinkedSpellRepository());
    _instance.registerLazySingleton(() => SpellLootTemplateRepository());
    _instance.registerLazySingleton(() => CreatureLootTemplateRepository());
    _instance.registerLazySingleton(
      () => PickpocketingLootTemplateRepository(),
    );
    _instance.registerLazySingleton(() => SkinningLootTemplateRepository());
    _instance.registerLazySingleton(() => ItemLootTemplateRepository());
    _instance.registerLazySingleton(() => DisenchantLootTemplateRepository());
    _instance.registerLazySingleton(() => ProspectingLootTemplateRepository());
    _instance.registerLazySingleton(() => MillingLootTemplateRepository());
    _instance.registerLazySingleton(() => ReferenceLootTemplateRepository());
    _instance.registerLazySingleton(() => GameObjectLootTemplateRepository());
    _instance.registerLazySingleton(() => SpellRangeRepository());
    _instance.registerLazySingleton(() => SpellRankRepository());
    _instance.registerLazySingleton(() => SpellRepository());
    _instance.registerLazySingleton(() => SkillLineRepository());
    _instance.registerLazySingleton(() => SoundAmbienceRepository());
    _instance.registerLazySingleton(() => SoundProviderPreferencesRepository());
    _instance.registerLazySingleton(() => TotemCategoryRepository());
    _instance.registerLazySingleton(() => TalentRepository());
    _instance.registerLazySingleton(() => TalentTabRepository());
    _instance.registerLazySingleton(() => TaxiPathRepository());
    _instance.registerLazySingleton(() => VehicleRepository());
    _instance.registerLazySingleton(() => ZoneIntroMusicRepository());
    _instance.registerLazySingleton(() => ZoneMusicRepository());
    _instance.registerLazySingleton(() => VersionRepository());
    _instance.registerLazySingleton(() => WaypointDataRepository());
  }

  // Keep explicit concrete registrations here. Generic UseCase adapters and
  // service locators inside UseCases are intentionally not used.
  static void _registerUseCases() {
    _instance.registerFactory(
      () => ResolveNpcTrainerParentUseCase(
        repository: _instance.get<CreatureDefaultTrainerRepository>(),
      ),
    );
    _instance.registerLazySingleton(
      () => ImportDbcUseCase(
        configUtil: _instance.get<ConfigUtil>(),
        dbcSyncUtil: _instance.get<DbcSyncUtil>(),
      ),
    );
    _instance.registerLazySingleton(
      () => ExtractGameIconsUseCase(
        configUtil: _instance.get<ConfigUtil>(),
      ),
    );
    _instance.registerFactory(
      () => ExportDbcUseCase(
        registry: _instance.get<DbcExportRegistry>(),
        dbcSyncUtil: _instance.get<DbcSyncUtil>(),
      ),
    );
    _instance.registerFactory(
      () => BootstrapApplicationUseCase(
        configUtil: _instance.get<ConfigUtil>(),
        featureRepository: _instance.get<FeatureRepository>(),
        settingRepository: _instance.get<SettingRepository>(),
        versionRepository: _instance.get<VersionRepository>(),
      ),
    );
    _instance.registerFactory(
      () => CreateGossipMenuUseCase(
        transaction: _instance.get<DatabaseTransaction>(),
        gossipMenuRepository: _instance.get<GossipMenuRepository>(),
        npcTextRepository: _instance.get<NpcTextRepository>(),
        activityLogService: _instance.get<ActivityLogService>(),
      ),
    );
    _instance.registerFactory(
      () => SaveGossipMenuOptionUseCase(
        transaction: _instance.get<DatabaseTransaction>(),
        optionRepository: _instance.get<GossipMenuOptionRepository>(),
        localeRepository: _instance.get<GossipMenuOptionLocaleRepository>(),
        activityLogService: _instance.get<ActivityLogService>(),
      ),
    );
    _instance.registerFactory(
      () => CopyGossipMenuOptionUseCase(
        transaction: _instance.get<DatabaseTransaction>(),
        optionRepository: _instance.get<GossipMenuOptionRepository>(),
        localeRepository: _instance.get<GossipMenuOptionLocaleRepository>(),
        activityLogService: _instance.get<ActivityLogService>(),
      ),
    );
    _instance.registerFactory(
      () => DestroyGossipMenuOptionUseCase(
        transaction: _instance.get<DatabaseTransaction>(),
        optionRepository: _instance.get<GossipMenuOptionRepository>(),
        localeRepository: _instance.get<GossipMenuOptionLocaleRepository>(),
        activityLogService: _instance.get<ActivityLogService>(),
      ),
    );
    _instance.registerFactory(
      () => SaveNpcTextUseCase(
        transaction: _instance.get<DatabaseTransaction>(),
        npcTextRepository: _instance.get<NpcTextRepository>(),
        localeRepository: _instance.get<NpcTextLocaleRepository>(),
        activityLogService: _instance.get<ActivityLogService>(),
      ),
    );
    _instance.registerFactory(
      () => DestroyNpcTextUseCase(
        transaction: _instance.get<DatabaseTransaction>(),
        npcTextRepository: _instance.get<NpcTextRepository>(),
        localeRepository: _instance.get<NpcTextLocaleRepository>(),
        activityLogService: _instance.get<ActivityLogService>(),
      ),
    );
  }
}
