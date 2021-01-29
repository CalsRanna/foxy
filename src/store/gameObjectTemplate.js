const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_GAME_OBJECT_TEMPLATES,
  COUNT_GAME_OBJECT_TEMPLATES,
  PAGINATE_GAME_OBJECT_TEMPLATES,
  STORE_GAME_OBJECT_TEMPLATE,
  FIND_GAME_OBJECT_TEMPLATE,
  UPDATE_GAME_OBJECT_TEMPLATE,
  DESTROY_GAME_OBJECT_TEMPLATE,
  CREATE_GAME_OBJECT_TEMPLATE,
  COPY_GAME_OBJECT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        entry: undefined,
        name: undefined,
      },
      pagination: {
        page: 1,
        size: 50,
        total: 0,
      },
      gameObjectTemplates: [],
      gameObjectTemplate: {},
    };
  },
  actions: {
    searchGameObjectTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(SEARCH_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    countGameObjectTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COUNT_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.on(COUNT_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(COUNT_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateGameObjectTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GAME_OBJECT_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_GAME_OBJECT_TEMPLATE", true);
          resolve();
        });
      });
    },
    findGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(FIND_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_GAME_OBJECT_TEMPLATE", true);
          resolve();
        });
      });
    },
    destroyGameObjectTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(CREATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(CREATE_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(CREATE_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    copyGameObjectTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(COPY_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_GAME_OBJECT_TEMPLATE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_TEMPLATES](state, gameObjectTemplates) {
      state.gameObjectTemplates = gameObjectTemplates;
      state.refresh = false;
    },
    [COUNT_GAME_OBJECT_TEMPLATES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GAME_OBJECT_TEMPLATES](state, page) {
      state.pagination.page = page;
    },
    [FIND_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    [UPDATE_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    [CREATE_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    UPDATE_REFRESH_OF_GAME_OBJECT_TEMPLATE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_GAME_OBJECT_TEMPLATE(state) {
      state.credential = {
        entry: undefined,
        name: undefined,
      };
    },
  },
};
