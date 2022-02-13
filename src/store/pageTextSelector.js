const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PAGE_TEXTS_FOR_SELECTOR,
  COUNT_PAGE_TEXTS_FOR_SELECTOR,
  PAGINATE_PAGE_TEXTS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      pagination: {
        page: 1,
        total: 0,
      },
      pageTexts: [],
    };
  },
  actions: {
    searchPageTextsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PAGE_TEXTS_FOR_SELECTOR, payload);
        ipcRenderer.once(SEARCH_PAGE_TEXTS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_PAGE_TEXTS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_PAGE_TEXTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countPageTextsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_PAGE_TEXTS_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_PAGE_TEXTS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_PAGE_TEXTS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_PAGE_TEXTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginatePageTextsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_PAGE_TEXTS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_PAGE_TEXTS_FOR_SELECTOR](state, pageTexts) {
      state.pageTexts = pageTexts;
    },
    [COUNT_PAGE_TEXTS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_PAGE_TEXTS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
