const ipcRenderer = window.require("electron").ipcRenderer;

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
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_ITEM_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(SEARCH_ITEM_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_ITEM_TEMPLATE_LOCALES, response);
          resolve();
        });
      });
    },
    storeItemTemplateLocales(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_ITEM_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(STORE_ITEM_TEMPLATE_LOCALES, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_TEMPLATE_LOCALES](state, itemTemplateLocales) {
      state.itemTemplateLocales = itemTemplateLocales;
    },
  },
};
