const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_TEMPLATE_LOCALES,
  STORE_CREATURE_TEMPLATE_LOCALES
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureTemplateLocales: []
  }),
  actions: {
    searchCreatureTemplateLocales({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(SEARCH_CREATURE_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_CREATURE_TEMPLATE_LOCALES, response);
          resolve();
        });
      });
    },
    storeCreatureTemplateLocales(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE_LOCALES, () => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATE_LOCALES](state, creatureTemplateLocales) {
      state.creatureTemplateLocales = creatureTemplateLocales;
    }
  }
};
