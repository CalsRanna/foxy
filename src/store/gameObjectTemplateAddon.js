const ipcRenderer = window.ipcRenderer;

import {
  STORE_GAME_OBJECT_TEMPLATE_ADDON,
  FIND_GAME_OBJECT_TEMPLATE_ADDON,
  UPDATE_GAME_OBJECT_TEMPLATE_ADDON,
  CREATE_GAME_OBJECT_TEMPLATE_ADDON,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    gameObjectTemplateAddon: {},
  }),
  actions: {
    storeGameObjectTemplateAddon(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE_ADDON, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE_ADDON, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_GAME_OBJECT_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findGameObjectTemplateAddon({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE_ADDON, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_GAME_OBJECT_TEMPLATE_ADDON, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_GAME_OBJECT_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateGameObjectTemplateAddon(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_GAME_OBJECT_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createGameObjectTemplateAddon({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_GAME_OBJECT_TEMPLATE_ADDON, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_GAME_OBJECT_TEMPLATE_ADDON](state, gameObjectTemplateAddon) {
      state.gameObjectTemplateAddon = gameObjectTemplateAddon;
    },
    [CREATE_GAME_OBJECT_TEMPLATE_ADDON](state, gameObjectTemplateAddon) {
      state.gameObjectTemplateAddon = gameObjectTemplateAddon;
    },
  },
};
