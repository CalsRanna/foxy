const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GAME_OBJECT_TEMPLATE_LOCALES,
  STORE_GAME_OBJECT_TEMPLATE_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    gameObjectTemplateLocales: [],
  }),
  actions: {
    searchGameObjectTemplateLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, payload);
        ipcRenderer.once(
          SEARCH_GAME_OBJECT_TEMPLATE_LOCALES,
          (event, response) => {
            commit(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_GAME_OBJECT_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeGameObjectTemplateLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE_LOCALES, payload);
        ipcRenderer.once(STORE_GAME_OBJECT_TEMPLATE_LOCALES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_GAME_OBJECT_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_TEMPLATE_LOCALES](state, gameObjectTemplateLocales) {
      state.gameObjectTemplateLocales = gameObjectTemplateLocales;
    },
  },
};
