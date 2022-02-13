const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ITEM_TEMPLATE_LOCALES,
  STORE_ITEM_TEMPLATE_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    itemTemplateLocales: [],
  }),
  actions: {
    searchItemTemplateLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_TEMPLATE_LOCALES, payload);
        ipcRenderer.once(SEARCH_ITEM_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_ITEM_TEMPLATE_LOCALES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_ITEM_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeItemTemplateLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ITEM_TEMPLATE_LOCALES, payload);
        ipcRenderer.once(STORE_ITEM_TEMPLATE_LOCALES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_ITEM_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_TEMPLATE_LOCALES](state, itemTemplateLocales) {
      state.itemTemplateLocales = itemTemplateLocales;
    },
  },
};
