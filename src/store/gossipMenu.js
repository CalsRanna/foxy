const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GOSSIP_MENUS,
  COUNT_GOSSIP_MENUS,
  PAGINATE_GOSSIP_MENUS,
  STORE_GOSSIP_MENU,
  FIND_GOSSIP_MENU,
  UPDATE_GOSSIP_MENU,
  DESTROY_GOSSIP_MENU,
  CREATE_GOSSIP_MENU,
  COPY_GOSSIP_MENU,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        MenuID: undefined,
        Text: undefined,
      },
      pagination: {
        page: 1,
        size: 50,
        total: 0,
      },
      gossipMenus: [],
      gossipMenu: {},
    };
  },
  actions: {
    searchGossipMenus({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GOSSIP_MENUS, payload);
        ipcRenderer.on(SEARCH_GOSSIP_MENUS, (event, response) => {
          commit(SEARCH_GOSSIP_MENUS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_GOSSIP_MENUS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countGossipMenus({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GOSSIP_MENUS, payload);
        ipcRenderer.on(COUNT_GOSSIP_MENUS, (event, response) => {
          commit(COUNT_GOSSIP_MENUS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_GOSSIP_MENUS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateGossipMenus({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GOSSIP_MENUS, payload.page);
        resolve();
      });
    },
    storeGossipMenu({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GOSSIP_MENU, payload);
        ipcRenderer.on(STORE_GOSSIP_MENU, () => {
          commit("UPDATE_REFRESH_OF_GOSSIP_MENU", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_GOSSIP_MENU}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findGossipMenu({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GOSSIP_MENU, payload);
        ipcRenderer.on(FIND_GOSSIP_MENU, (event, response) => {
          commit(FIND_GOSSIP_MENU, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_GOSSIP_MENU}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateGossipMenu({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GOSSIP_MENU, payload);
        ipcRenderer.on(UPDATE_GOSSIP_MENU, () => {
          commit("UPDATE_REFRESH_OF_GOSSIP_MENU", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_GOSSIP_MENU}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyGossipMenu(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GOSSIP_MENU, payload);
        ipcRenderer.on(DESTROY_GOSSIP_MENU, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_GOSSIP_MENU}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createGossipMenu({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_GOSSIP_MENU, payload);
        ipcRenderer.on(CREATE_GOSSIP_MENU, (event, response) => {
          commit(CREATE_GOSSIP_MENU, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_GOSSIP_MENU}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyGossipMenu(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GOSSIP_MENU, payload);
        ipcRenderer.on(COPY_GOSSIP_MENU, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_GOSSIP_MENU}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_GOSSIP_MENU");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GOSSIP_MENUS](state, gossipMenus) {
      state.gossipMenus = gossipMenus;
    },
    [COUNT_GOSSIP_MENUS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GOSSIP_MENUS](state, page) {
      state.pagination.page = page;
    },
    [FIND_GOSSIP_MENU](state, gossipMenu) {
      state.gossipMenu = gossipMenu;
    },
    [UPDATE_GOSSIP_MENU](state, gossipMenu) {
      state.gossipMenu = gossipMenu;
    },
    [CREATE_GOSSIP_MENU](state, gossipMenu) {
      state.gossipMenu = gossipMenu;
    },
    UPDATE_REFRESH_OF_GOSSIP_MENU(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_GOSSIP_MENU(state) {
      state.credential = {
        MenuID: undefined,
        Text: undefined,
      };
    },
  },
};
