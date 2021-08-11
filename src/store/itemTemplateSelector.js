const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ITEM_TEMPLATES_FOR_SELECTOR,
  COUNT_ITEM_TEMPLATES_FOR_SELECTOR,
  PAGINATE_ITEM_TEMPLATES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      pagination: {
        page: 1,
        total: 0,
      },
      itemTemplates: [],
    };
  },
  actions: {
    searchItemTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_TEMPLATES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_ITEM_TEMPLATES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_ITEM_TEMPLATES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_ITEM_TEMPLATES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countItemTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ITEM_TEMPLATES_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_ITEM_TEMPLATES_FOR_SELECTOR, (event, response) => {
          commit(COUNT_ITEM_TEMPLATES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${COUNT_ITEM_TEMPLATES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateItemTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ITEM_TEMPLATES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_TEMPLATES_FOR_SELECTOR](state, itemTemplates) {
      state.itemTemplates = itemTemplates;
    },
    [COUNT_ITEM_TEMPLATES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ITEM_TEMPLATES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
