const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_MAPS_FOR_SELECTOR,
  COUNT_MAPS_FOR_SELECTOR,
  PAGINATE_MAPS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    maps: [],
  }),
  actions: {
    searchMapsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_MAPS_FOR_SELECTOR, payload);
        ipcRenderer.on(SEARCH_MAPS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_MAPS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_MAPS_FOR_SELECTOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countMapsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_MAPS_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_MAPS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_MAPS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_MAPS_FOR_SELECTOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateMapsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_MAPS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_MAPS_FOR_SELECTOR](state, maps) {
      state.maps = maps;
    },
    [COUNT_MAPS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_MAPS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
