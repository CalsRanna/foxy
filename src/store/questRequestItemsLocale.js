const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_REQUEST_ITEMS_LOCALES,
  STORE_QUEST_REQUEST_ITEMS_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    questRequestItemsLocales: [],
  }),
  actions: {
    searchQuestRequestItemsLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_REQUEST_ITEMS_LOCALES, payload);
        ipcRenderer.on(SEARCH_QUEST_REQUEST_ITEMS_LOCALES, (event, response) => {
          commit(SEARCH_QUEST_REQUEST_ITEMS_LOCALES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_QUEST_REQUEST_ITEMS_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeQuestRequestItemsLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_REQUEST_ITEMS_LOCALES, payload);
        ipcRenderer.on(STORE_QUEST_REQUEST_ITEMS_LOCALES, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_QUEST_REQUEST_ITEMS_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_REQUEST_ITEMS_LOCALES](state, questRequestItemsLocales) {
      state.questRequestItemsLocales = questRequestItemsLocales;
    },
  },
};
