const ipcRenderer = window.require("electron").ipcRenderer;

import {
  STORE_QUEST_REQUEST_ITEMS,
  FIND_QUEST_REQUEST_ITEMS,
  UPDATE_QUEST_REQUEST_ITEMS,
  CREATE_QUEST_REQUEST_ITEMS,
} from "./../constants";

export default {
  namespaced: true,
  state() {
    return {
      questRequestItems: {},
    };
  },
  actions: {
    storeQuestRequestItems(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_QUEST_REQUEST_ITEMS, payload);
        ipcRenderer.on(STORE_QUEST_REQUEST_ITEMS, () => {
          resolve();
        });
      });
    },
    findQuestRequestItems({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_QUEST_REQUEST_ITEMS, payload);
        ipcRenderer.on(FIND_QUEST_REQUEST_ITEMS, (event, response) => {
          commit(FIND_QUEST_REQUEST_ITEMS, response);
          resolve();
        });
      });
    },
    updateQuestRequestItems(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_QUEST_REQUEST_ITEMS, payload);
        ipcRenderer.on(UPDATE_QUEST_REQUEST_ITEMS, () => {
          resolve();
        });
      });
    },
    createQuestRequestItems({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_QUEST_REQUEST_ITEMS, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_QUEST_REQUEST_ITEMS](state, questRequestItems) {
      state.questRequestItems = questRequestItems;
    },
    [CREATE_QUEST_REQUEST_ITEMS](state, questRequestItems) {
      state.questRequestItems = questRequestItems;
    },
  },
};
