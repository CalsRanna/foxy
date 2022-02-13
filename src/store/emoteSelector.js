const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_EMOTES_FOR_SELECTOR,
  COUNT_EMOTES_FOR_SELECTOR,
  PAGINATE_EMOTES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    emotes: [],
  }),
  actions: {
    searchEmotesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_EMOTES_FOR_SELECTOR, payload);
        ipcRenderer.once(SEARCH_EMOTES_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_EMOTES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_EMOTES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countEmotesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_EMOTES_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_EMOTES_FOR_SELECTOR, (event, response) => {
          commit(COUNT_EMOTES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_EMOTES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateEmotesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_EMOTES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_EMOTES_FOR_SELECTOR](state, emotes) {
      state.emotes = emotes;
    },
    [COUNT_EMOTES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_EMOTES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
