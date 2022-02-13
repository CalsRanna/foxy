const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GOSSIP_MENU_OPTIONS, payload);
        ipcRenderer.once(SEARCH_GOSSIP_MENU_OPTIONS, (event, response) => {
          commit(SEARCH_GOSSIP_MENU_OPTIONS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_GOSSIP_MENU_OPTIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeGossipMenuOption(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.once(STORE_GOSSIP_MENU_OPTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_GOSSIP_MENU_OPTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findGossipMenuOption({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.once(FIND_GOSSIP_MENU_OPTION, (event, response) => {
          commit(FIND_GOSSIP_MENU_OPTION, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_GOSSIP_MENU_OPTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateGossipMenuOption({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.once(UPDATE_GOSSIP_MENU_OPTION, () => {
          commit(UPDATE_GOSSIP_MENU_OPTION, payload.gossipMenuOption);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_GOSSIP_MENU_OPTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyGossipMenuOption(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.once(DESTROY_GOSSIP_MENU_OPTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_GOSSIP_MENU_OPTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createGossipMenuOption({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.once(CREATE_GOSSIP_MENU_OPTION, (event, response) => {
          commit(CREATE_GOSSIP_MENU_OPTION, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_GOSSIP_MENU_OPTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyGossipMenuOption(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GOSSIP_MENU_OPTION, payload);
        ipcRenderer.once(COPY_GOSSIP_MENU_OPTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_GOSSIP_MENU_OPTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
