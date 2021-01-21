const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_GOSSIP_MENU_OPTIONS,
  STORE_GOSSIP_MENU_OPTION,
  FIND_GOSSIP_MENU_OPTION,
  UPDATE_GOSSIP_MENU_OPTION,
  DESTROY_GOSSIP_MENU_OPTION,
  CREATE_GOSSIP_MENU_OPTION,
  COPY_GOSSIP_MENU_OPTION,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      gossipMenuOptions: [],
      gossipMenuOption: {},
    };
  },
  actions: {
    searchGossipMenuOptions({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_GOSSIP_MENU_OPTIONS, payload);
        ipcRenderer.on(SEARCH_GOSSIP_MENU_OPTIONS, (event, response) => {
          commit(SEARCH_GOSSIP_MENU_OPTIONS, response);
          resolve();
        });
      });
    },
    storeGossipMenuOption(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.on(STORE_GOSSIP_MENU_OPTION, () => {
          resolve();
        });
      });
    },
    findGossipMenuOption({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.on(FIND_GOSSIP_MENU_OPTION, (event, response) => {
          commit(FIND_GOSSIP_MENU_OPTION, response);
          resolve();
        });
      });
    },
    updateGossipMenuOption({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.on(UPDATE_GOSSIP_MENU_OPTION, () => {
          commit(UPDATE_GOSSIP_MENU_OPTION, payload.gossipMenuOption);
          resolve();
        });
      });
    },
    destroyGossipMenuOption(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.on(DESTROY_GOSSIP_MENU_OPTION, () => {
          resolve();
        });
      });
    },
    createGossipMenuOption({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(CREATE_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.on(CREATE_GOSSIP_MENU_OPTION, (event, response) => {
          commit(CREATE_GOSSIP_MENU_OPTION, response);
          resolve();
        });
      });
    },
    copyGossipMenuOption(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.on(COPY_GOSSIP_MENU_OPTION, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_GOSSIP_MENU_OPTIONS](state, gossipMenuOptions) {
      state.gossipMenuOptions = gossipMenuOptions;
    },
    [FIND_GOSSIP_MENU_OPTION](state, gossipMenuOption) {
      state.gossipMenuOption = gossipMenuOption;
    },
    [UPDATE_GOSSIP_MENU_OPTION](state, gossipMenuOption) {
      state.gossipMenuOption = gossipMenuOption;
    },
    [CREATE_GOSSIP_MENU_OPTION](state, gossipMenuOption) {
      state.gossipMenuOption = gossipMenuOption;
    },
  },
};
