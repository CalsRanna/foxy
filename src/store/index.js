import Vue from "vue";
import Vuex from "vuex";

import global from "./global";
import dbc from "./dbc";
// import creature from "./creature";
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
import gameObject from "./gameObject";
import item from "./item";
import quest from "./quest";
import spell from "./spell";
import smartScript from "./smartScript";
import setting from "./setting";
import gossipMenu from "./gossipMenu";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    global,
    dbc,
    // creature,
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
    gameObject,
    item,
    quest,
    spell,
    smartScript,
    setting,
    gossipMenu
  }
});
