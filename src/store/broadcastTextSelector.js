const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_BROADCAST_TEXTS_FOR_SELECTOR,
  COUNT_BROADCAST_TEXTS_FOR_SELECTOR,
  PAGINATE_BROADCAST_TEXTS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    broadcastTexts: [],
  }),
  actions: {
    searchBroadcastTextsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_BROADCAST_TEXTS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_BROADCAST_TEXTS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_BROADCAST_TEXTS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_BROADCAST_TEXTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countBroadcastTextsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_BROADCAST_TEXTS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_BROADCAST_TEXTS_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_BROADCAST_TEXTS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_BROADCAST_TEXTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateBroadcastTextsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_BROADCAST_TEXTS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_BROADCAST_TEXTS_FOR_SELECTOR](state, broadcastTexts) {
      state.broadcastTexts = broadcastTexts;
    },
    [COUNT_BROADCAST_TEXTS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_BROADCAST_TEXTS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
