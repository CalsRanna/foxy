const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_AREA_TABLES_FOR_SELECTOR,
  COUNT_AREA_TABLES_FOR_SELECTOR,
  PAGINATE_AREA_TABLES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    areaTables: [],
  }),
  actions: {
    searchAreaTablesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_AREA_TABLES_FOR_SELECTOR, payload);
        ipcRenderer.once(SEARCH_AREA_TABLES_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_AREA_TABLES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_AREA_TABLES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countAreaTablesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_AREA_TABLES_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_AREA_TABLES_FOR_SELECTOR, (event, response) => {
          commit(COUNT_AREA_TABLES_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_AREA_TABLES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateAreaTablesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_AREA_TABLES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_AREA_TABLES_FOR_SELECTOR](state, areaTables) {
      state.areaTables = areaTables;
    },
    [COUNT_AREA_TABLES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_AREA_TABLES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
