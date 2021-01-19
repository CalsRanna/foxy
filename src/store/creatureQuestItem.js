const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_QUEST_ITEMS,
  STORE_CREATURE_QUEST_ITEM,
  FIND_CREATURE_QUEST_ITEM,
  UPDATE_CREATURE_QUEST_ITEM,
  DESTROY_CREATURE_QUEST_ITEM,
  CREATE_CREATURE_QUEST_ITEM,
  COPY_CREATUREEQUIP__TEMPLATE
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureQuestItems: [],
    creatureQuestItem: {}
  }),
  actions: {
    searchCreatureEquipTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_ITEMS, payload);
        ipcRenderer.on(SEARCH_CREATURE_QUEST_ITEMS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_ITEMS, response);
          resolve();
        });
      });
    },
    storeCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(STORE_CREATURE_QUEST_ITEM, (event, response) => {
          resolve();
        });
      });
    },
    findCreatureEquipTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(FIND_CREATURE_QUEST_ITEM, (event, response) => {
          commit(FIND_CREATURE_QUEST_ITEM, response);
          resolve();
        });
      });
    },
    updateCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(UPDATE_CREATURE_QUEST_ITEM, (event, response) => {
          resolve();
        });
      });
    },
    destroyCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(DESTROY_CREATURE_QUEST_ITEM, (event, response) => {
          resolve();
        });
      });
    },
    createCreatureEquipTemplate({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_CREATURE_QUEST_ITEM, payload);
        resolve();
      });
    },
    copyCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_CREATUREEQUIP__TEMPLATE, payload);
        ipcRenderer.on(COPY_CREATUREEQUIP__TEMPLATE, (event, response) => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_CREATURE_QUEST_ITEMS](state, creatureQuestItems) {
      state.creatureEquipTemplates = creatureQuestItems;
    },
    [FIND_CREATURE_QUEST_ITEM](state, creatureQuestItem) {
      state.creatureEquipTemplate = creatureQuestItem;
    },
    [CREATE_CREATURE_QUEST_ITEM](state, creatureQuestItem) {
      state.creatureEquipTemplate = creatureQuestItem;
    }
  }
};
