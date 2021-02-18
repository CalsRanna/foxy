const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_SPELL_DURATIONS_FOR_SELECTOR,
  COUNT_SPELL_DURATIONS_FOR_SELECTOR,
  PAGINATE_SPELL_DURATIONS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    spellDurations: [],
  }),
  actions: {
    searchSpellDurationsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_DURATIONS_FOR_SELECTOR, payload);
        ipcRenderer.on(SEARCH_SPELL_DURATIONS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_SPELL_DURATIONS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_SPELL_DURATIONS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countSpellDurationsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SPELL_DURATIONS_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_SPELL_DURATIONS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_SPELL_DURATIONS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${COUNT_SPELL_DURATIONS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateSpellDurationsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SPELL_DURATIONS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_DURATIONS_FOR_SELECTOR](state, spellDurations) {
      state.spellDurations = spellDurations;
    },
    [COUNT_SPELL_DURATIONS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SPELL_DURATIONS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
