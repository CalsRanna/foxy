import Vue from "vue";
import Vuex from "vuex";

import app from "./app";
import initiator from "./initiator";
import exporter from "./exporter";
import areaTable from "./areaTable";
import areaTableOrQuestSortSelector from "./areaTableOrQuestSortSelector";
import charTitleSelector from "./charTitleSelector";
import creatureTemplate from "./creatureTemplate";
import creatureTemplateLocale from "./creatureTemplateLocale";
import creatureTemplateAddon from "./creatureTemplateAddon";
import creatureTemplateResistance from "./creatureTemplateResistance";
import creatureTemplateSpell from "./creatureTemplateSpell";
import creatureOnKillReputation from "./creatureOnKillReputation";
import creatureEquipTemplate from "./creatureEquipTemplate";
import creatureQuestItem from "./creatureQuestItem";
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
import questTemplate from "./questTemplate";
import questTemplateLocale from "./questTemplateLocale";
import questTemplateAddon from "./questTemplateAddon";
import questOfferReward from "./questOfferReward";
import questRequestItems from "./questRequestItems";
import creatureQuestStarter from "./creatureQuestStarter";
import creatureQuestEnder from "./creatureQuestEnder";
import emoteSelector from "./emoteSelector";
import emoteText from "./emoteText";
import gameObjectQuestStarter from "./gameObjectQuestStarter";
import gameObjectQuestEnder from "./gameObjectQuestEnder";
import gossipMenu from "./gossipMenu";
import mapSelector from "./mapSelector";
import npcText from "./npcText";
import npcTextLocale from "./npcTextLocale";
import gossipMenuOption from "./gossipMenuOption";
import questFactionReward from "./questFactionReward";
import smartScript from "./smartScript";
import spell from "./spell";
import spellArea from "./spellArea";
import spellBonusData from "./spellBonusData";
import spellCustomAttr from "./spellCustomAttr";
import spellGroup from "./spellGroup";
import spellLinkedSpell from "./spellLinkedSpell";
import spellLootTemplate from "./spellLootTemplate";
import referenceLootTemplateCard from "./referenceLootTemplateCard";
import scalingStatDistribution from "./scalingStatDistribution";
import scalingStatValue from "./scalingStatValue";
import itemSet from "./itemSet";
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
import spellDurationSelector from "./spellDurationSelector";
import spellCastTimeSelector from "./spellCastTimeSelector";
import spellIconSelector from "./spellIconSelector";
import spellRangeSelector from "./spellRangeSelector";
import gossipMenuSelector from "./gossipMenuSelector";
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
    areaTable,
    areaTableOrQuestSortSelector,
    charTitleSelector,
    creatureTemplate,
    creatureTemplateLocale,
    creatureTemplateAddon,
    creatureTemplateResistance,
    creatureTemplateSpell,
    creatureOnKillReputation,
    creatureEquipTemplate,
    creatureQuestItem,
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
    questTemplate,
    questTemplateLocale,
    questTemplateAddon,
    questOfferReward,
    questRequestItems,
    creatureQuestStarter,
    creatureQuestEnder,
    gameObjectQuestStarter,
    gameObjectQuestEnder,
    gossipMenu,
    mapSelector,
    npcText,
    npcTextLocale,
    gossipMenuOption,
    questFactionReward,
    smartScript,
    spell,
    spellArea,
    spellBonusData,
    spellCustomAttr,
    spellGroup,
    spellLinkedSpell,
    spellLootTemplate,
    referenceLootTemplateCard,
    scalingStatDistribution,
    scalingStatValue,
    itemSet,
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
    spellDurationSelector,
    spellCastTimeSelector,
    spellIconSelector,
    spellRangeSelector,
    gossipMenuSelector,
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
