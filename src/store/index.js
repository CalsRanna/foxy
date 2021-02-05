import Vue from "vue";
import Vuex from "vuex";

import global from "./global";
import dbc from "./dbc";
import creatureTemplate from "./creatureTemplate";
import creatureTemplateLocale from "./creatureTemplateLocale";
import creatureTemplateAddon from "./creatureTemplateAddon";
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
import setting from "./setting";
import factionTemplateSelector from "./factionTemplateSelector";
import spellSelector from "./spellSelector";
import gossipMenuSelector from "./gossipMenuSelector";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    global,
    dbc,
    creatureTemplate,
    creatureTemplateLocale,
    creatureTemplateAddon,
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
    setting,
    factionTemplateSelector,
    spellSelector,
    gossipMenuSelector,
  },
});
