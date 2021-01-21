const ipcRenderer = window.require("electron").ipcRenderer;

import { SEARCH_NPC_TEXT_LOCALES, STORE_NPC_TEXT_LOCALES } from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      npcTextLocales: [],
    };
  },
  actions: {
    searchNpcTextLocales({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_NPC_TEXT_LOCALES, payload);
        ipcRenderer.on(SEARCH_NPC_TEXT_LOCALES, (event, response) => {
          commit(SEARCH_NPC_TEXT_LOCALES, response);
          resolve();
        });
      });
    },
    storeNpcTextLocales(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_NPC_TEXT_LOCALES, payload);
        ipcRenderer.on(STORE_NPC_TEXT_LOCALES, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_NPC_TEXT_LOCALES](state, npcTextLocales) {
      state.npcTextLocales = npcTextLocales;
    },
  },
};
