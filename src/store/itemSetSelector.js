const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_ITEM_SETS_FOR_SELECTOR,
  COUNT_ITEM_SETS_FOR_SELECTOR,
  PAGINATE_ITEM_SETS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    itemSets: [],
  }),
  actions: {
    searchItemSetsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_SETS_FOR_SELECTOR, payload);
        ipcRenderer.on(SEARCH_ITEM_SETS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_ITEM_SETS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_ITEM_SETS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countItemSetsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ITEM_SETS_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_ITEM_SETS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_ITEM_SETS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${COUNT_ITEM_SETS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateItemSetsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ITEM_SETS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_SETS_FOR_SELECTOR](state, itemSets) {
      state.itemSets = itemSets;
    },
    [COUNT_ITEM_SETS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ITEM_SETS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
