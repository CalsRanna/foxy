const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PAGE_TEXT_LOCALES,
  STORE_PAGE_TEXT_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pageTextLocales: [],
  }),
  actions: {
    searchPageTextLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PAGE_TEXT_LOCALES, payload);
        ipcRenderer.once(SEARCH_PAGE_TEXT_LOCALES, (event, response) => {
          commit(SEARCH_PAGE_TEXT_LOCALES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_PAGE_TEXT_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storePageTextLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PAGE_TEXT_LOCALES, payload);
        ipcRenderer.once(STORE_PAGE_TEXT_LOCALES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_PAGE_TEXT_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_PAGE_TEXT_LOCALES](state, pageTextLocales) {
      state.pageTextLocales = pageTextLocales;
    },
  },
};
