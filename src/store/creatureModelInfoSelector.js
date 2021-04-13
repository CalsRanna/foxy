const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR,
  COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR,
  PAGINATE_CREATURE_MODEL_INFOS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    creatureModelInfos: [],
  }),
  actions: {
    searchCreatureModelInfosForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countCreatureModelInfosForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateCreatureModelInfosForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_CREATURE_MODEL_INFOS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR](state, creatureModelInfos) {
      state.creatureModelInfos = creatureModelInfos;
    },
    [COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CREATURE_MODEL_INFOS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
