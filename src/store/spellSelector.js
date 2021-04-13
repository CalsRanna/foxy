const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELLS_FOR_SELECTOR,
  COUNT_SPELLS_FOR_SELECTOR,
  PAGINATE_SPELLS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    spells: [],
  }),
  actions: {
    searchSpellsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELLS_FOR_SELECTOR, payload);
        ipcRenderer.on(SEARCH_SPELLS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_SPELLS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_SPELLS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countSpellsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SPELLS_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_SPELLS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_SPELLS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${COUNT_SPELLS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateSpellsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SPELLS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SPELLS_FOR_SELECTOR](state, spells) {
      state.spells = spells;
    },
    [COUNT_SPELLS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SPELLS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
