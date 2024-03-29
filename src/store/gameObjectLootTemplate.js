const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GAME_OBJECT_LOOT_TEMPLATES,
  STORE_GAME_OBJECT_LOOT_TEMPLATE,
  FIND_GAME_OBJECT_LOOT_TEMPLATE,
  UPDATE_GAME_OBJECT_LOOT_TEMPLATE,
  DESTROY_GAME_OBJECT_LOOT_TEMPLATE,
  CREATE_GAME_OBJECT_LOOT_TEMPLATE,
  COPY_GAME_OBJECT_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    gameObjectLootTemplates: [],
    gameObjectLootTemplate: {},
  }),
  actions: {
    searchGameObjectLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, payload);
        ipcRenderer.once(
          SEARCH_GAME_OBJECT_LOOT_TEMPLATES,
          (event, response) => {
            commit(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_GAME_OBJECT_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeGameObjectLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GAME_OBJECT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_GAME_OBJECT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findGameObjectLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GAME_OBJECT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_GAME_OBJECT_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_GAME_OBJECT_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateGameObjectLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_GAME_OBJECT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyGameObjectLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_GAME_OBJECT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createGameObjectLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_GAME_OBJECT_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyGameObjectLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GAME_OBJECT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_GAME_OBJECT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_LOOT_TEMPLATES](state, gameObjectLootTemplates) {
      state.gameObjectLootTemplates = gameObjectLootTemplates;
    },
    [FIND_GAME_OBJECT_LOOT_TEMPLATE](state, gameObjectLootTemplate) {
      state.gameObjectLootTemplate = gameObjectLootTemplate;
    },
    [CREATE_GAME_OBJECT_LOOT_TEMPLATE](state, gameObjectLootTemplate) {
      state.gameObjectLootTemplate = gameObjectLootTemplate;
    },
  },
};
