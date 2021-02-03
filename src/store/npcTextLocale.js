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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_NPC_TEXT_LOCALES, payload);
        ipcRenderer.on(SEARCH_NPC_TEXT_LOCALES, (event, response) => {
          commit(SEARCH_NPC_TEXT_LOCALES, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_NPC_TEXT_LOCALES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    storeNpcTextLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_NPC_TEXT_LOCALES, payload);
        ipcRenderer.on(STORE_NPC_TEXT_LOCALES, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_NPC_TEXT_LOCALES}_REJECT`, (event, error) => {
          reject(error);
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
