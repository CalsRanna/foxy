const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELL_CAST_TIMES_FOR_SELECTOR,
  COUNT_SPELL_CAST_TIMES_FOR_SELECTOR,
  PAGINATE_SPELL_CAST_TIMES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    spellCastTimes: [],
  }),
  actions: {
    searchSpellCastTimesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_CAST_TIMES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_SPELL_CAST_TIMES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_SPELL_CAST_TIMES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_SPELL_CAST_TIMES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countSpellCastTimesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SPELL_CAST_TIMES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_SPELL_CAST_TIMES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_SPELL_CAST_TIMES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_SPELL_CAST_TIMES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateSpellCastTimesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SPELL_CAST_TIMES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_CAST_TIMES_FOR_SELECTOR](state, spellCastTimes) {
      state.spellCastTimes = spellCastTimes;
    },
    [COUNT_SPELL_CAST_TIMES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SPELL_CAST_TIMES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
