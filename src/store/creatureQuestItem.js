const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_QUEST_ITEMS,
  STORE_CREATURE_QUEST_ITEM,
  FIND_CREATURE_QUEST_ITEM,
  UPDATE_CREATURE_QUEST_ITEM,
  DESTROY_CREATURE_QUEST_ITEM,
  CREATE_CREATURE_QUEST_ITEM,
  COPY_CREATURE_QUEST_ITEM,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureQuestItems: [],
    creatureQuestItem: {},
  }),
  actions: {
    searchCreatureQuestItems({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_ITEMS, payload);
        ipcRenderer.on(SEARCH_CREATURE_QUEST_ITEMS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_ITEMS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_CREATURE_QUEST_ITEMS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureQuestItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(STORE_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_CREATURE_QUEST_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureQuestItem({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(FIND_CREATURE_QUEST_ITEM, (event, response) => {
          commit(FIND_CREATURE_QUEST_ITEM, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_CREATURE_QUEST_ITEM}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateCreatureQuestItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(UPDATE_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_CREATURE_QUEST_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureQuestItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(DESTROY_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_CREATURE_QUEST_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureQuestItem({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(CREATE_CREATURE_QUEST_ITEM, (event, response) => {
          commit(CREATE_CREATURE_QUEST_ITEM, response);
          resolve();
        });
        ipcRenderer.on(
          `${CREATE_CREATURE_QUEST_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyCreatureQuestItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_QUEST_ITEM, payload);
        ipcRenderer.on(COPY_CREATURE_QUEST_ITEM, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_CREATURE_QUEST_ITEM}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
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
    },
  },
};
