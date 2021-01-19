const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_QUEST_ITEMS,
  STORE_CREATURE_QUEST_ITEM,
  FIND_CREATURE_QUEST_ITEM,
  UPDATE_CREATURE_QUEST_ITEM,
  DESTROY_CREATURE_QUEST_ITEM,
  CREATE_CREATURE_QUEST_ITEM,
  COPY_CREATURE_QUEST_ITEM
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureQuestItems: [],
    creatureQuestItem: {}
  }),
  actions: {
    searchCreatureQuestItems({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_ITEMS, payload);
        ipcRenderer.on(SEARCH_CREATURE_QUEST_ITEMS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_ITEMS, response);
          resolve();
        });
      });
    },
    storeCreatureQuestItem(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(STORE_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
    findCreatureQuestItem({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(FIND_CREATURE_QUEST_ITEM, (event, response) => {
          commit(FIND_CREATURE_QUEST_ITEM, response);
          resolve();
        });
      });
    },
    updateCreatureQuestItem(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(UPDATE_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
    destroyCreatureQuestItem(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(DESTROY_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
    createCreatureQuestItem({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(CREATE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(CREATE_CREATURE_QUEST_ITEM, (event, response) => {
          commit(CREATE_CREATURE_QUEST_ITEM, response);
          resolve();
        });
      });
    },
    copyCreatureQuestItem(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(COPY_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_CREATURE_QUEST_ITEMS](state, creatureQuestItems) {
      state.creatureQuestItems = creatureQuestItems;
    },
    [FIND_CREATURE_QUEST_ITEM](state, creatureQuestItem) {
      state.creatureQuestItem = creatureQuestItem;
    },
    [CREATE_CREATURE_QUEST_ITEM](state, creatureQuestItem) {
      state.creatureQuestItem = creatureQuestItem;
    }
  }
};
