import Vue from "vue";
import Vuex from "vuex";

import global from "./global";
import initiator from "./initiator";
import exporter from "./exporter";
import dbc from "./dbc";
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
import disenchantLootTemplate from "./disenchantLootTemplate";
import prospectingLootTemplate from "./prospectingLootTemplate";
import millingLootTemplate from "./millingLootTemplate";
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
import gameObjectQuestStarter from "./gameObjectQuestStarter";
import gameObjectQuestEnder from "./gameObjectQuestEnder";
import gossipMenu from "./gossipMenu";
import npcText from "./npcText";
import npcTextLocale from "./npcTextLocale";
import gossipMenuOption from "./gossipMenuOption";
import smartScript from "./smartScript";
import spell from "./spell";
import spellArea from "./spellArea";
import spellBonusData from "./spellBonusData";
import spellCustomAttr from "./spellCustomAttr";
import spellGroup from "./spellGroup";
import spellLinkedSpell from "./spellLinkedSpell";
import spellLootTemplate from "./spellLootTemplate";
import referenceLootTemplate from "./referenceLootTemplate";
import scalingStatDistribution from "./scalingStatDistribution";
import itemSet from "./itemSet";
import talent from "./talent";
import talentTab from "./talentTab";
import setting from "./setting";
import factionTemplateSelector from "./factionTemplateSelector";
import creatureSpellDataSelector from "./creatureSpellDataSelector";
import creatureModelInfoSelector from "./creatureModelInfoSelector";
import creatureTemplateSelector from "./creatureTemplateSelector";
import spellSelector from "./spellSelector";
import spellDurationSelector from "./spellDurationSelector";
import spellCastTimeSelector from "./spellCastTimeSelector";
import spellRangeSelector from "./spellRangeSelector";
import gossipMenuSelector from "./gossipMenuSelector";
import scalingStatDistributionSelector from "./scalingStatDistributionSelector";
import waypointDataSelector from "./waypointDataSelector";
import itemSetSelector from "./itemSetSelector";
import itemEnchantmentTemplateSelector from "./itemEnchantmentTemplateSelector";
import itemRandomPropertiesSelector from "./itemRandomPropertiesSelector";
import itemRandomSuffixSelector from "./itemRandomSuffixSelector";
import itemDisplayInfoSelector from "./itemDisplayInfoSelector";
import questTemplateSelector from "./questTemplateSelector";
import version from "./version";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    global,
    initiator,
    exporter,
    dbc,
    creatureTemplate,
    creatureTemplateLocale,
    creatureTemplateAddon,
    creatureTemplateResistance,
    creatureTemplateSpell,
    creatureOnKillReputation,
    creatureEquipTemplate,
    creatureQuestItem,
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
    npcText,
    npcTextLocale,
    gossipMenuOption,
    smartScript,
    spell,
    spellArea,
    spellBonusData,
    spellCustomAttr,
    spellGroup,
    spellLinkedSpell,
    spellLootTemplate,
    referenceLootTemplate,
    scalingStatDistribution,
    itemSet,
    talent,
    talentTab,
    setting,
    factionTemplateSelector,
    creatureSpellDataSelector,
    creatureModelInfoSelector,
    creatureTemplateSelector,
    spellSelector,
    spellDurationSelector,
    spellCastTimeSelector,
    spellRangeSelector,
    gossipMenuSelector,
    scalingStatDistributionSelector,
    waypointDataSelector: waypointDataSelector,
    itemSetSelector: itemSetSelector,
    itemEnchantmentTemplateSelector: itemEnchantmentTemplateSelector,
    itemRandomPropertiesSelector: itemRandomPropertiesSelector,
    itemRandomSuffixSelector: itemRandomSuffixSelector,
    itemDisplayInfoSelector: itemDisplayInfoSelector,
    questTemplateSelector: questTemplateSelector,
    version,
  },
});
