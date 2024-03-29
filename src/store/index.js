import Vue from "vue";
import Vuex from "vuex";

import app from "./app";
import initiator from "./initiator";
import exporter from "./exporter";
import updater from "./updater";
import achievement from "./achievement";
import achievementCategory from "./achievementCategory";
import achievementCategorySelector from "./achievementCategorySelector";
import achievementCriteria from "./achievementCriteria";
import achievementCriteriaData from "./achievementCriteriaData";
import achievementReward from "./achievementReward";
import achievementRewardLocale from "./achievementRewardLocale";
import achievementSelector from "./achievementSelector";
import areaTable from "./areaTable";
import areaTableOrQuestSortSelector from "./areaTableOrQuestSortSelector";
import areaTableSelector from "./areaTableSelector";
import broadcastTextSelector from "./broadcastTextSelector";
import charTitleSelector from "./charTitleSelector";
import condition from "./condition";
import creatureTemplate from "./creatureTemplate";
import creatureTemplateLocale from "./creatureTemplateLocale";
import creatureTemplateAddon from "./creatureTemplateAddon";
import creatureTemplateResistance from "./creatureTemplateResistance";
import creatureTemplateSpell from "./creatureTemplateSpell";
import creatureOnKillReputation from "./creatureOnKillReputation";
import creatureEquipTemplate from "./creatureEquipTemplate";
import creatureQuestItem from "./creatureQuestItem";
import currencyCategory from "./currencyCategory";
import currencyCategorySelector from "./currencyCategorySelector";
import currencyType from "./currencyType";
import npcVendor from "./npcVendor";
import npcTrainer from "./npcTrainer";
import creatureLootTemplate from "./creatureLootTemplate";
import pickpocketingLootTemplate from "./pickpocketingLootTemplate";
import skinningLootTemplate from "./skinningLootTemplate";
import itemTemplate from "./itemTemplate";
import itemTemplateLocale from "./itemTemplateLocale";
import itemTemplateSelector from "./itemTemplateSelector";
import itemEnchantmentTemplate from "./itemEnchantmentTemplate";
import itemLootTemplate from "./itemLootTemplate";
import lockSelector from "./lockSelector";
import disenchantLootTemplate from "./disenchantLootTemplate";
import prospectingLootTemplate from "./prospectingLootTemplate";
import millingLootTemplate from "./millingLootTemplate";
import gameObjectDisplayInfoSelector from "./gameObjectDisplayInfoSelector";
import gameObjectTemplate from "./gameObjectTemplate";
import gameObjectTemplateLocale from "./gameObjectTemplateLocale";
import gameObjectTemplateAddon from "./gameObjectTemplateAddon";
import gameObjectQuestItem from "./gameObjectQuestItem";
import gameObjectLootTemplate from "./gameObjectLootTemplate";
import questRequestItemsLocale from "./questRequestItemsLocale";
import questTemplate from "./questTemplate";
import questTemplateLocale from "./questTemplateLocale";
import questTemplateAddon from "./questTemplateAddon";
import questOfferReward from "./questOfferReward";
import questOfferRewardLocale from "./questOfferRewardLocale";
import questRequestItems from "./questRequestItems";
import creatureQuestStarter from "./creatureQuestStarter";
import creatureQuestEnder from "./creatureQuestEnder";
import emoteSelector from "./emoteSelector";
import emoteText from "./emoteText";
import gameObjectQuestStarter from "./gameObjectQuestStarter";
import gameObjectQuestEnder from "./gameObjectQuestEnder";
import gemProperty from "./gemProperty";
import gossipMenu from "./gossipMenu";
import mapSelector from "./mapSelector";
import npcText from "./npcText";
import npcTextLocale from "./npcTextLocale";
import npcTextSelector from "./npcTextSelector";
import gossipMenuOption from "./gossipMenuOption";
import glyphProperty from "./glyphProperty";
import questFactionReward from "./questFactionReward";
import smartScript from "./smartScript";
import spell from "./spell";
import spellArea from "./spellArea";
import spellBonusData from "./spellBonusData";
import spellCustomAttr from "./spellCustomAttr";
import spellGroup from "./spellGroup";
import spellLinkedSpell from "./spellLinkedSpell";
import spellLootTemplate from "./spellLootTemplate";
import spellRank from "./spellRank";
import referenceLootTemplateCard from "./referenceLootTemplateCard";
import scalingStatDistribution from "./scalingStatDistribution";
import scalingStatValue from "./scalingStatValue";
import itemExtendedCost from "./itemExtendedCost";
import itemExtendedCostSelector from "./itemExtendedCostSelector";
import itemSet from "./itemSet";
import pageText from "./pageText";
import pageTextLocale from "./pageTextLocale";
import pageTextSelector from "./pageTextSelector";
import playerCreateInfo from "./playerCreateInfo";
import playerCreateInfoAction from "./playerCreateInfoAction";
import playerCreateInfoItem from "./playerCreateInfoItem";
import playerCreateInfoSpellCustom from "./playerCreateInfoSpellCustom";
import talent from "./talent";
import talentTab from "./talentTab";
import referenceLootTemplate from "./referenceLootTemplate";
import setting from "./setting";
import factionSelector from "./factionSelector";
import factionTemplateSelector from "./factionTemplateSelector";
import creatureSpellDataSelector from "./creatureSpellDataSelector";
import creatureModelInfoSelector from "./creatureModelInfoSelector";
import creatureTemplateSelector from "./creatureTemplateSelector";
import spellSelector from "./spellSelector";
import spellCastTimeSelector from "./spellCastTimeSelector";
import spellCategorySelector from "./spellCategorySelector";
import spellDescriptionVariableSelector from "./spellDescriptionVariableSelector";
import spellDifficultySelector from "./spellDifficultySelector";
import spellDurationSelector from "./spellDurationSelector";
import spellIconSelector from "./spellIconSelector";
import spellItemEnchantment from "./spellItemEnchantment";
import spellRangeSelector from "./spellRangeSelector";
import gossipMenuSelector from "./gossipMenuSelector";
import glyphPropertySelector from "./glyphPropertySelector";
import scalingStatDistributionSelector from "./scalingStatDistributionSelector";
import waypointDataSelector from "./waypointDataSelector";
import itemSetSelector from "./itemSetSelector";
import itemEnchantmentTemplateSelector from "./itemEnchantmentTemplateSelector";
import itemRandomPropertiesSelector from "./itemRandomPropertiesSelector";
import itemRandomSuffixSelector from "./itemRandomSuffixSelector";
import itemDisplayInfoSelector from "./itemDisplayInfoSelector";
import questInfo from "./questInfo";
import questSort from "./questSort";
import questInfoSelector from "./questInfoSelector";
import questTemplateSelector from "./questTemplateSelector";
import version from "./version";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    app,
    initiator,
    exporter,
    updater,
    achievement,
    achievementCategory,
    achievementCategorySelector,
    achievementCriteria,
    achievementCriteriaData,
    achievementReward,
    achievementRewardLocale,
    achievementSelector,
    areaTable,
    areaTableOrQuestSortSelector,
    areaTableSelector,
    broadcastTextSelector,
    charTitleSelector,
    condition,
    creatureTemplate,
    creatureTemplateLocale,
    creatureTemplateAddon,
    creatureTemplateResistance,
    creatureTemplateSpell,
    creatureOnKillReputation,
    creatureEquipTemplate,
    creatureQuestItem,
    currencyCategory,
    currencyCategorySelector,
    currencyType,
    emoteSelector,
    emoteText,
    npcVendor,
    npcTrainer,
    creatureLootTemplate,
    pickpocketingLootTemplate,
    skinningLootTemplate,
    itemTemplate,
    itemTemplateLocale,
    itemTemplateSelector,
    itemEnchantmentTemplate,
    itemLootTemplate,
    disenchantLootTemplate,
    prospectingLootTemplate,
    millingLootTemplate,
    gameObjectDisplayInfoSelector,
    gameObjectTemplate,
    gameObjectTemplateLocale,
    gameObjectTemplateAddon,
    gameObjectQuestItem,
    gameObjectLootTemplate,
    questRequestItemsLocale,
    questTemplate,
    questTemplateLocale,
    questTemplateAddon,
    questOfferReward,
    questOfferRewardLocale,
    questRequestItems,
    creatureQuestStarter,
    creatureQuestEnder,
    gameObjectQuestStarter,
    gameObjectQuestEnder,
    gemProperty,
    gossipMenu,
    mapSelector,
    npcText,
    npcTextLocale,
    npcTextSelector,
    gossipMenuOption,
    glyphProperty,
    questFactionReward,
    smartScript,
    spell,
    spellArea,
    spellBonusData,
    spellCustomAttr,
    spellGroup,
    spellItemEnchantment,
    spellLinkedSpell,
    spellLootTemplate,
    spellRank,
    referenceLootTemplateCard,
    scalingStatDistribution,
    scalingStatValue,
    itemExtendedCost,
    itemExtendedCostSelector,
    itemSet,
    pageText,
    pageTextLocale,
    pageTextSelector,
    playerCreateInfo,
    playerCreateInfoAction,
    playerCreateInfoItem,
    playerCreateInfoSpellCustom,
    lockSelector,
    talent,
    talentTab,
    referenceLootTemplate,
    setting,
    factionSelector,
    factionTemplateSelector,
    creatureSpellDataSelector,
    creatureModelInfoSelector,
    creatureTemplateSelector,
    spellSelector,
    spellCastTimeSelector,
    spellCategorySelector,
    spellDescriptionVariableSelector,
    spellDifficultySelector,
    spellDurationSelector,
    spellIconSelector,
    spellRangeSelector,
    gossipMenuSelector,
    glyphPropertySelector,
    scalingStatDistributionSelector,
    waypointDataSelector: waypointDataSelector,
    itemSetSelector: itemSetSelector,
    itemEnchantmentTemplateSelector: itemEnchantmentTemplateSelector,
    itemRandomPropertiesSelector: itemRandomPropertiesSelector,
    itemRandomSuffixSelector: itemRandomSuffixSelector,
    itemDisplayInfoSelector: itemDisplayInfoSelector,
    questInfo,
    questInfoSelector,
    questSort,
    questTemplateSelector: questTemplateSelector,
    version,
  },
});
