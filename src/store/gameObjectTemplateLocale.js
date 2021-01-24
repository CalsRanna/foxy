const ipcRenderer = window.require("electron").ipcRenderer;

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
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(
          SEARCH_GAME_OBJECT_TEMPLATE_LOCALES,
          (event, response) => {
            commit(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, response);
            resolve();
          }
        );
      });
    },
    storeGameObjectTemplateLocales(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE_LOCALES, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_TEMPLATE_LOCALES](state, gameObjectTemplateLocales) {
      state.gameObjectTemplateLocales = gameObjectTemplateLocales;
    },
  },
};
