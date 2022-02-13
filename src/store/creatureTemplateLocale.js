const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_TEMPLATE_LOCALES,
  STORE_CREATURE_TEMPLATE_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureTemplateLocales: [],
  }),
  actions: {
    searchCreatureTemplateLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATE_LOCALES, payload);
        ipcRenderer.once(
          SEARCH_CREATURE_TEMPLATE_LOCALES,
          (event, response) => {
            commit(SEARCH_CREATURE_TEMPLATE_LOCALES, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_CREATURE_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureTemplateLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_LOCALES, payload);
        ipcRenderer.once(STORE_CREATURE_TEMPLATE_LOCALES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CREATURE_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATE_LOCALES](state, creatureTemplateLocales) {
      state.creatureTemplateLocales = creatureTemplateLocales;
    },
  },
};
