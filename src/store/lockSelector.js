const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_LOCKS_FOR_SELECTOR,
  COUNT_LOCKS_FOR_SELECTOR,
  PAGINATE_LOCKS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    locks: [],
  }),
  actions: {
    searchLocksForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_LOCKS_FOR_SELECTOR, payload);
        ipcRenderer.on(SEARCH_LOCKS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_LOCKS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_LOCKS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countLocksForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_LOCKS_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_LOCKS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_LOCKS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_LOCKS_FOR_SELECTOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateLocksForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_LOCKS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_LOCKS_FOR_SELECTOR](state, locks) {
      state.locks = locks;
    },
    [COUNT_LOCKS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_LOCKS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
