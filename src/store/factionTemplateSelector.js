const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_FACTION_TEMPLATES_FOR_SELECTOR,
  COUNT_FACTION_TEMPLATES_FOR_SELECTOR,
  PAGINATE_FACTION_TEMPLATES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    factionTemplates: [],
  }),
  actions: {
    searchFactionTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_FACTION_TEMPLATES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_FACTION_TEMPLATES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_FACTION_TEMPLATES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_FACTION_TEMPLATES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countFactionTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_FACTION_TEMPLATES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_FACTION_TEMPLATES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_FACTION_TEMPLATES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_FACTION_TEMPLATES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateFactionTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_FACTION_TEMPLATES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_FACTION_TEMPLATES_FOR_SELECTOR](state, factionTemplates) {
      state.factionTemplates = factionTemplates;
    },
    [COUNT_FACTION_TEMPLATES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_FACTION_TEMPLATES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
