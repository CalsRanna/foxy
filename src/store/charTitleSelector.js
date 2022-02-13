const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CHAR_TITLES_FOR_SELECTOR,
  COUNT_CHAR_TITLES_FOR_SELECTOR,
  PAGINATE_CHAR_TITLES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    charTitles: [],
  }),
  actions: {
    searchCharTitlesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CHAR_TITLES_FOR_SELECTOR, payload);
        ipcRenderer.once(SEARCH_CHAR_TITLES_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_CHAR_TITLES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_CHAR_TITLES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countCharTitlesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_CHAR_TITLES_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_CHAR_TITLES_FOR_SELECTOR, (event, response) => {
          commit(COUNT_CHAR_TITLES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_CHAR_TITLES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateCharTitlesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_CHAR_TITLES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_CHAR_TITLES_FOR_SELECTOR](state, charTitles) {
      state.charTitles = charTitles;
    },
    [COUNT_CHAR_TITLES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CHAR_TITLES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
