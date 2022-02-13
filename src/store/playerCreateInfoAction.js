const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PLAYER_CREATE_INFO_ACTIONS,
  STORE_PLAYER_CREATE_INFO_ACTION,
  FIND_PLAYER_CREATE_INFO_ACTION,
  UPDATE_PLAYER_CREATE_INFO_ACTION,
  DESTROY_PLAYER_CREATE_INFO_ACTION,
  CREATE_PLAYER_CREATE_INFO_ACTION,
  COPY_PLAYER_CREATE_INFO_ACTION,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    playerCreateInfoActions: [],
    playerCreateInfoAction: {},
  }),
  actions: {
    searchPlayerCreateInfoActions({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PLAYER_CREATE_INFO_ACTIONS, payload);
        ipcRenderer.once(
          SEARCH_PLAYER_CREATE_INFO_ACTIONS,
          (event, response) => {
            commit(SEARCH_PLAYER_CREATE_INFO_ACTIONS, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_PLAYER_CREATE_INFO_ACTIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storePlayerCreateInfoAction(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PLAYER_CREATE_INFO_ACTION, payload);
        ipcRenderer.once(STORE_PLAYER_CREATE_INFO_ACTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_PLAYER_CREATE_INFO_ACTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findPlayerCreateInfoAction({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_PLAYER_CREATE_INFO_ACTION, payload);
        ipcRenderer.once(FIND_PLAYER_CREATE_INFO_ACTION, (event, response) => {
          commit(FIND_PLAYER_CREATE_INFO_ACTION, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_PLAYER_CREATE_INFO_ACTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updatePlayerCreateInfoAction(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_PLAYER_CREATE_INFO_ACTION, payload);
        ipcRenderer.once(UPDATE_PLAYER_CREATE_INFO_ACTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_PLAYER_CREATE_INFO_ACTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyPlayerCreateInfoAction(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_PLAYER_CREATE_INFO_ACTION, payload);
        ipcRenderer.once(DESTROY_PLAYER_CREATE_INFO_ACTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_PLAYER_CREATE_INFO_ACTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createPlayerCreateInfoAction({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_PLAYER_CREATE_INFO_ACTION, payload);
        ipcRenderer.once(
          CREATE_PLAYER_CREATE_INFO_ACTION,
          (event, response) => {
            commit(CREATE_PLAYER_CREATE_INFO_ACTION, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${CREATE_PLAYER_CREATE_INFO_ACTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyPlayerCreateInfoAction(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_PLAYER_CREATE_INFO_ACTION, payload);
        ipcRenderer.once(COPY_PLAYER_CREATE_INFO_ACTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_PLAYER_CREATE_INFO_ACTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_PLAYER_CREATE_INFO_ACTIONS](state, playerCreateInfoActions) {
      state.playerCreateInfoActions = playerCreateInfoActions;
    },
    [FIND_PLAYER_CREATE_INFO_ACTION](state, playerCreateInfoAction) {
      state.playerCreateInfoAction = playerCreateInfoAction;
    },
    [CREATE_PLAYER_CREATE_INFO_ACTION](state, playerCreateInfoAction) {
      state.playerCreateInfoAction = playerCreateInfoAction;
    },
  },
};
