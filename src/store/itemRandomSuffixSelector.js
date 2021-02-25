const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR,
  COUNT_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR,
  PAGINATE_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    itemRandomSuffixes: [],
  }),
  actions: {
    searchItemRandomSuffixesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countItemRandomSuffixesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateItemRandomSuffixesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR](state, itemRandomSuffixes) {
      state.itemRandomSuffixes = itemRandomSuffixes;
    },
    [COUNT_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ITEM_RANDOM_SUFFIXES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
