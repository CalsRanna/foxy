const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_FACTIONS_FOR_SELECTOR,
  COUNT_FACTIONS_FOR_SELECTOR,
  PAGINATE_FACTIONS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    factions: [],
  }),
  actions: {
    searchFactionsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_FACTIONS_FOR_SELECTOR, payload);
        ipcRenderer.once(SEARCH_FACTIONS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_FACTIONS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_FACTIONS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countFactionsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_FACTIONS_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_FACTIONS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_FACTIONS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_FACTIONS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateFactionsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_FACTIONS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_FACTIONS_FOR_SELECTOR](state, factions) {
      state.factions = factions;
    },
    [COUNT_FACTIONS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_FACTIONS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
