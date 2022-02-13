const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PLAYER_CREATE_INFO_ITEMS,
  STORE_PLAYER_CREATE_INFO_ITEM,
  FIND_PLAYER_CREATE_INFO_ITEM,
  UPDATE_PLAYER_CREATE_INFO_ITEM,
  DESTROY_PLAYER_CREATE_INFO_ITEM,
  CREATE_PLAYER_CREATE_INFO_ITEM,
  COPY_PLAYER_CREATE_INFO_ITEM,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    playerCreateInfoItems: [],
    playerCreateInfoItem: {},
  }),
  actions: {
    searchPlayerCreateInfoItems({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PLAYER_CREATE_INFO_ITEMS, payload);
        ipcRenderer.once(SEARCH_PLAYER_CREATE_INFO_ITEMS, (event, response) => {
          commit(SEARCH_PLAYER_CREATE_INFO_ITEMS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_PLAYER_CREATE_INFO_ITEMS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storePlayerCreateInfoItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PLAYER_CREATE_INFO_ITEM, payload);
        ipcRenderer.once(STORE_PLAYER_CREATE_INFO_ITEM, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_PLAYER_CREATE_INFO_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findPlayerCreateInfoItem({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_PLAYER_CREATE_INFO_ITEM, payload);
        ipcRenderer.once(FIND_PLAYER_CREATE_INFO_ITEM, (event, response) => {
          commit(FIND_PLAYER_CREATE_INFO_ITEM, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_PLAYER_CREATE_INFO_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updatePlayerCreateInfoItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_PLAYER_CREATE_INFO_ITEM, payload);
        ipcRenderer.once(UPDATE_PLAYER_CREATE_INFO_ITEM, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_PLAYER_CREATE_INFO_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyPlayerCreateInfoItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_PLAYER_CREATE_INFO_ITEM, payload);
        ipcRenderer.once(DESTROY_PLAYER_CREATE_INFO_ITEM, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_PLAYER_CREATE_INFO_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createPlayerCreateInfoItem({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_PLAYER_CREATE_INFO_ITEM, payload);
        resolve();
      });
    },
    copyPlayerCreateInfoItem(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_PLAYER_CREATE_INFO_ITEM, payload);
        ipcRenderer.once(COPY_PLAYER_CREATE_INFO_ITEM, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_PLAYER_CREATE_INFO_ITEM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_PLAYER_CREATE_INFO_ITEMS](state, playerCreateInfoItems) {
      state.playerCreateInfoItems = playerCreateInfoItems;
    },
    [FIND_PLAYER_CREATE_INFO_ITEM](state, playerCreateInfoItem) {
      state.playerCreateInfoItem = playerCreateInfoItem;
    },
    [CREATE_PLAYER_CREATE_INFO_ITEM](state, playerCreateInfoItem) {
      state.playerCreateInfoItem = playerCreateInfoItem;
    },
  },
};
