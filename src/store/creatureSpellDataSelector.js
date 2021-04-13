const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR,
  COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR,
  PAGINATE_CREATURE_SPELL_DATAS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    creatureSpellDatas: [],
  }),
  actions: {
    searchCreatureSpellDatasForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countCreatureSpellDatasForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateCreatureSpellDatasForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_CREATURE_SPELL_DATAS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR](state, creatureSpellDatas) {
      state.creatureSpellDatas = creatureSpellDatas;
    },
    [COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CREATURE_SPELL_DATAS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
