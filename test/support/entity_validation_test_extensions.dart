import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/achievement_category_entity_validation_mixin.dart';
import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/widget/form/validation/achievement_criteria_entity_validation_mixin.dart';
import 'package:foxy/entity/achievement_criteria_entity.dart';
import 'package:foxy/widget/form/validation/achievement_entity_validation_mixin.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/widget/form/validation/condition_entity_validation_mixin.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/widget/form/validation/creature_template_addon_entity_validation_mixin.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/widget/form/validation/currency_category_entity_validation_mixin.dart';
import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/widget/form/validation/currency_type_entity_validation_mixin.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/widget/form/validation/game_object_quest_item_entity_validation_mixin.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/widget/form/validation/game_object_template_addon_entity_validation_mixin.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/widget/form/validation/game_object_template_entity_validation_mixin.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/widget/form/validation/gem_property_entity_validation_mixin.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/widget/form/validation/glyph_property_entity_validation_mixin.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/widget/form/validation/item_enchantment_template_entity_validation_mixin.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/widget/form/validation/item_extended_cost_entity_validation_mixin.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/widget/form/validation/item_purchase_group_entity_validation_mixin.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'package:foxy/widget/form/validation/item_set_entity_validation_mixin.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/widget/form/validation/item_template_entity_validation_mixin.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/widget/form/validation/item_visual_effect_entity_validation_mixin.dart';
import 'package:foxy/entity/item_visual_effect_entity.dart';
import 'package:foxy/widget/form/validation/item_visuals_entity_validation_mixin.dart';
import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/widget/form/validation/creature_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/disenchant_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/disenchant_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/game_object_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/game_object_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/item_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/item_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/milling_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/milling_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/pickpocketing_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/pickpocketing_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/prospecting_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/prospecting_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/reference_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/skinning_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/skinning_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/page_text_entity_validation_mixin.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/widget/form/validation/page_text_locale_entity_validation_mixin.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/widget/form/validation/quest_faction_reward_entity_validation_mixin.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/widget/form/validation/quest_info_entity_validation_mixin.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/widget/form/validation/quest_sort_entity_validation_mixin.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/widget/form/validation/quest_template_addon_entity_validation_mixin.dart';
import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/widget/form/validation/quest_template_entity_validation_mixin.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/widget/form/validation/scaling_stat_distribution_entity_validation_mixin.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/widget/form/validation/scaling_stat_value_entity_validation_mixin.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/widget/form/validation/spell_area_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/widget/form/validation/spell_custom_attr_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/widget/form/validation/spell_group_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/widget/form/validation/spell_item_enchantment_condition_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/widget/form/validation/spell_item_enchantment_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/widget/form/validation/spell_linked_spell_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/widget/form/validation/spell_loot_template_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/widget/form/validation/spell_rank_entity_validation_mixin.dart';
import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/widget/form/validation/talent_entity_validation_mixin.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/widget/form/validation/talent_tab_entity_validation_mixin.dart';
import 'package:foxy/entity/talent_tab_entity.dart';

class _ValidationViewModel
    with
        ViewModelValidationMixin,
        AchievementCategoryValidationMixin,
        AchievementCriteriaValidationMixin,
        AchievementValidationMixin,
        ConditionValidationMixin,
        CreatureTemplateAddonValidationMixin,
        CurrencyCategoryValidationMixin,
        CurrencyTypeValidationMixin,
        GameObjectQuestItemValidationMixin,
        GameObjectTemplateAddonValidationMixin,
        GameObjectTemplateValidationMixin,
        GemPropertyValidationMixin,
        GlyphPropertyValidationMixin,
        ItemEnchantmentTemplateValidationMixin,
        ItemExtendedCostValidationMixin,
        ItemPurchaseGroupValidationMixin,
        ItemSetValidationMixin,
        ItemTemplateValidationMixin,
        ItemVisualEffectValidationMixin,
        ItemVisualsValidationMixin,
        CreatureLootTemplateValidationMixin,
        DisenchantLootTemplateValidationMixin,
        GameObjectLootTemplateValidationMixin,
        ItemLootTemplateValidationMixin,
        MillingLootTemplateValidationMixin,
        PickpocketingLootTemplateValidationMixin,
        ProspectingLootTemplateValidationMixin,
        ReferenceLootTemplateValidationMixin,
        SkinningLootTemplateValidationMixin,
        PageTextValidationMixin,
        PageTextLocaleValidationMixin,
        PlayerCreateInfoValidationMixin,
        PlayerCreateInfoActionValidationMixin,
        PlayerCreateInfoItemValidationMixin,
        PlayerCreateInfoSpellCustomValidationMixin,
        PlayerCreateInfoSkillValidationMixin,
        PlayerCreateInfoCastSpellValidationMixin,
        QuestFactionRewardValidationMixin,
        QuestInfoValidationMixin,
        QuestSortValidationMixin,
        QuestTemplateAddonValidationMixin,
        QuestTemplateValidationMixin,
        ScalingStatDistributionValidationMixin,
        ScalingStatValueValidationMixin,
        SpellAreaValidationMixin,
        SpellCustomAttrValidationMixin,
        SpellGroupValidationMixin,
        SpellItemEnchantmentConditionValidationMixin,
        SpellItemEnchantmentValidationMixin,
        SpellLinkedSpellValidationMixin,
        SpellLootTemplateValidationMixin,
        SpellRankValidationMixin,
        TalentValidationMixin,
        TalentTabValidationMixin {}

final _validationViewModel = _ValidationViewModel();

extension AchievementCategoryEntityTestValidation on AchievementCategoryEntity {
  void validate() =>
      _validationViewModel.validateAchievementCategoryFields(this);
}

extension AchievementCriteriaEntityTestValidation on AchievementCriteriaEntity {
  void validate() =>
      _validationViewModel.validateAchievementCriteriaFields(this);
}

extension AchievementEntityTestValidation on AchievementEntity {
  void validate() => _validationViewModel.validateAchievementFields(this);
}

extension ConditionEntityTestValidation on ConditionEntity {
  void validate() => _validationViewModel.validateConditionFields(this);
}

extension CreatureTemplateAddonEntityTestValidation
    on CreatureTemplateAddonEntity {
  void validate() =>
      _validationViewModel.validateCreatureTemplateAddonFields(this);
}

extension CurrencyCategoryEntityTestValidation on CurrencyCategoryEntity {
  void validate() => _validationViewModel.validateCurrencyCategoryFields(this);
}

extension CurrencyTypeEntityTestValidation on CurrencyTypeEntity {
  void validate() => _validationViewModel.validateCurrencyTypeFields(this);
}

extension GameObjectQuestItemEntityTestValidation on GameObjectQuestItemEntity {
  void validate() =>
      _validationViewModel.validateGameObjectQuestItemFields(this);
}

extension GameObjectTemplateAddonEntityTestValidation
    on GameObjectTemplateAddonEntity {
  void validate() =>
      _validationViewModel.validateGameObjectTemplateAddonFields(this);
}

extension GameObjectTemplateEntityTestValidation on GameObjectTemplateEntity {
  void validate() =>
      _validationViewModel.validateGameObjectTemplateFields(this);
}

extension GemPropertyEntityTestValidation on GemPropertyEntity {
  void validate() => _validationViewModel.validateGemPropertyFields(this);
}

extension GlyphPropertyEntityTestValidation on GlyphPropertyEntity {
  void validate() => _validationViewModel.validateGlyphPropertyFields(this);
}

extension ItemEnchantmentTemplateEntityTestValidation
    on ItemEnchantmentTemplateEntity {
  void validate() =>
      _validationViewModel.validateItemEnchantmentTemplateFields(this);
}

extension ItemExtendedCostEntityTestValidation on ItemExtendedCostEntity {
  void validate() => _validationViewModel.validateItemExtendedCostFields(this);
}

extension ItemPurchaseGroupEntityTestValidation on ItemPurchaseGroupEntity {
  void validate() => _validationViewModel.validateItemPurchaseGroupFields(this);
}

extension ItemSetEntityTestValidation on ItemSetEntity {
  void validate() => _validationViewModel.validateItemSetFields(this);
}

extension ItemTemplateEntityTestValidation on ItemTemplateEntity {
  void validate() => _validationViewModel.validateItemTemplateFields(this);
}

extension ItemVisualEffectEntityTestValidation on ItemVisualEffectEntity {
  void validate() => _validationViewModel.validateItemVisualEffectFields(this);
}

extension ItemVisualsEntityTestValidation on ItemVisualsEntity {
  void validate() => _validationViewModel.validateItemVisualsFields(this);
}

extension CreatureLootTemplateEntityTestValidation
    on CreatureLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateCreatureLootTemplateFields(this);
}

extension DisenchantLootTemplateEntityTestValidation
    on DisenchantLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateDisenchantLootTemplateFields(this);
}

extension GameObjectLootTemplateEntityTestValidation
    on GameObjectLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateGameObjectLootTemplateFields(this);
}

extension ItemLootTemplateEntityTestValidation on ItemLootTemplateEntity {
  void validate() => _validationViewModel.validateItemLootTemplateFields(this);
}

extension MillingLootTemplateEntityTestValidation on MillingLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateMillingLootTemplateFields(this);
}

extension PickpocketingLootTemplateEntityTestValidation
    on PickpocketingLootTemplateEntity {
  void validate() =>
      _validationViewModel.validatePickpocketingLootTemplateFields(this);
}

extension ProspectingLootTemplateEntityTestValidation
    on ProspectingLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateProspectingLootTemplateFields(this);
}

extension ReferenceLootTemplateEntityTestValidation
    on ReferenceLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateReferenceLootTemplateFields(this);
}

extension SkinningLootTemplateEntityTestValidation
    on SkinningLootTemplateEntity {
  void validate() =>
      _validationViewModel.validateSkinningLootTemplateFields(this);
}

extension PageTextEntityTestValidation on PageTextEntity {
  void validate() => _validationViewModel.validatePageTextFields(this);
}

extension PageTextLocaleEntityTestValidation on PageTextLocaleEntity {
  void validate() => _validationViewModel.validatePageTextLocaleFields(this);
}

extension PlayerCreateInfoEntityTestValidation on PlayerCreateInfoEntity {
  void validate() => _validationViewModel.validatePlayerCreateInfoFields(this);
}

extension PlayerCreateInfoActionEntityTestValidation
    on PlayerCreateInfoActionEntity {
  void validate() =>
      _validationViewModel.validatePlayerCreateInfoActionFields(this);
}

extension PlayerCreateInfoItemEntityTestValidation
    on PlayerCreateInfoItemEntity {
  void validate() =>
      _validationViewModel.validatePlayerCreateInfoItemFields(this);
}

extension PlayerCreateInfoSpellCustomEntityTestValidation
    on PlayerCreateInfoSpellCustomEntity {
  void validate() =>
      _validationViewModel.validatePlayerCreateInfoSpellCustomFields(this);
}

extension PlayerCreateInfoSkillEntityTestValidation
    on PlayerCreateInfoSkillEntity {
  void validate() =>
      _validationViewModel.validatePlayerCreateInfoSkillFields(this);
}

extension PlayerCreateInfoCastSpellEntityTestValidation
    on PlayerCreateInfoCastSpellEntity {
  void validate() =>
      _validationViewModel.validatePlayerCreateInfoCastSpellFields(this);
}

extension QuestFactionRewardEntityTestValidation on QuestFactionRewardEntity {
  void validate() =>
      _validationViewModel.validateQuestFactionRewardFields(this);
}

extension QuestInfoEntityTestValidation on QuestInfoEntity {
  void validate() => _validationViewModel.validateQuestInfoFields(this);
}

extension QuestSortEntityTestValidation on QuestSortEntity {
  void validate() => _validationViewModel.validateQuestSortFields(this);
}

extension QuestTemplateAddonEntityTestValidation on QuestTemplateAddonEntity {
  void validate() =>
      _validationViewModel.validateQuestTemplateAddonFields(this);
}

extension QuestTemplateEntityTestValidation on QuestTemplateEntity {
  void validate() => _validationViewModel.validateQuestTemplateFields(this);
}

extension ScalingStatDistributionEntityTestValidation
    on ScalingStatDistributionEntity {
  void validate() =>
      _validationViewModel.validateScalingStatDistributionFields(this);
}

extension ScalingStatValueEntityTestValidation on ScalingStatValueEntity {
  void validate() => _validationViewModel.validateScalingStatValueFields(this);
}

extension SpellAreaEntityTestValidation on SpellAreaEntity {
  void validate() => _validationViewModel.validateSpellAreaFields(this);
}

extension SpellCustomAttrEntityTestValidation on SpellCustomAttrEntity {
  void validate() => _validationViewModel.validateSpellCustomAttrFields(this);
}

extension SpellGroupEntityTestValidation on SpellGroupEntity {
  void validate() => _validationViewModel.validateSpellGroupFields(this);
}

extension SpellItemEnchantmentConditionEntityTestValidation
    on SpellItemEnchantmentConditionEntity {
  void validate() =>
      _validationViewModel.validateSpellItemEnchantmentConditionFields(this);
}

extension SpellItemEnchantmentEntityTestValidation
    on SpellItemEnchantmentEntity {
  void validate() =>
      _validationViewModel.validateSpellItemEnchantmentFields(this);
}

extension SpellLinkedSpellEntityTestValidation on SpellLinkedSpellEntity {
  void validate() => _validationViewModel.validateSpellLinkedSpellFields(this);
}

extension SpellLootTemplateEntityTestValidation on SpellLootTemplateEntity {
  void validate() => _validationViewModel.validateSpellLootTemplateFields(this);
}

extension SpellRankEntityTestValidation on SpellRankEntity {
  void validate() => _validationViewModel.validateSpellRankFields(this);
}

extension TalentEntityTestValidation on TalentEntity {
  void validate() => _validationViewModel.validateTalentFields(this);
}

extension TalentTabEntityTestValidation on TalentTabEntity {
  void validate() => _validationViewModel.validateTalentTabFields(this);
}
