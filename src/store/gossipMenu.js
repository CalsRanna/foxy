const ipcRenderer = window.require("electron").ipcRenderer;

import { SEARCH_GOSSIP_MENUS, COUNT_GOSSIP_MENUS, PAGINATE_GOSSIP_MENUS } from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      size: 50,
      gossipMenus: [],
      gossipMenu: {}
    };
  },
  actions: {
    searchGossipMenus({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_GOSSIP_MENUS, payload);
        ipcRenderer.on(SEARCH_GOSSIP_MENUS, (event, response) => {
          commit(SEARCH_GOSSIP_MENUS, response);
          resolve();
        });
      });
    },
    countGossipMenus({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_GOSSIP_MENUS, payload);
        ipcRenderer.on(COUNT_GOSSIP_MENUS, (event, response) => {
          commit(COUNT_GOSSIP_MENUS, response);
          resolve();
        });
      });
    },
    paginateGossipMenus({ commit }, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_GOSSIP_MENUS, payload.page);
        resolve();
      });
    }
  },
  mutations: {
    [SEARCH_GOSSIP_MENUS](state, gossipMenus) {
      state.gossipMenus = gossipMenus;
    },
    [COUNT_GOSSIP_MENUS](state, total) {
      state.total = total;
    },
    [PAGINATE_GOSSIP_MENUS](state, page) {
      state.page = page;
    }
  }
};
