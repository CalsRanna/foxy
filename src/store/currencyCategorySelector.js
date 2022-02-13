const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CURRENCY_CATEGORIES_FOR_SELECTOR,
  COUNT_CURRENCY_CATEGORIES_FOR_SELECTOR,
  PAGINATE_CURRENCY_CATEGORIES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    currencyCategories: [],
  }),
  actions: {
    searchCurrencyCategoriesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CURRENCY_CATEGORIES_FOR_SELECTOR, payload);
        ipcRenderer.once(
          SEARCH_CURRENCY_CATEGORIES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_CURRENCY_CATEGORIES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_CURRENCY_CATEGORIES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countCurrencyCategoriesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_CURRENCY_CATEGORIES_FOR_SELECTOR, payload);
        ipcRenderer.once(
          COUNT_CURRENCY_CATEGORIES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_CURRENCY_CATEGORIES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${COUNT_CURRENCY_CATEGORIES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateCurrencyCategoriesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_CURRENCY_CATEGORIES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_CURRENCY_CATEGORIES_FOR_SELECTOR](state, currencyCategories) {
      state.currencyCategories = currencyCategories;
    },
    [COUNT_CURRENCY_CATEGORIES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CURRENCY_CATEGORIES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
