const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GOSSIP_MENUS_FOR_SELECTOR,
  COUNT_GOSSIP_MENUS_FOR_SELECTOR,
  PAGINATE_GOSSIP_MENUS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      pagination: {
        page: 1,
        total: 0,
      },
      gossipMenus: [],
    };
  },
  actions: {
    searchGossipMenusForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GOSSIP_MENUS_FOR_SELECTOR, payload);
        ipcRenderer.once(
          SEARCH_GOSSIP_MENUS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_GOSSIP_MENUS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_GOSSIP_MENUS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countGossipMenusForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GOSSIP_MENUS_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_GOSSIP_MENUS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_GOSSIP_MENUS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_GOSSIP_MENUS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateGossipMenusForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GOSSIP_MENUS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GOSSIP_MENUS_FOR_SELECTOR](state, gossipMenus) {
      state.gossipMenus = gossipMenus;
    },
    [COUNT_GOSSIP_MENUS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GOSSIP_MENUS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
