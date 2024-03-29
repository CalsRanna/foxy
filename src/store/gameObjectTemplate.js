const ipcRenderer = window.ipcRenderer;

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
        total: 0,
      },
      gameObjectTemplates: [],
      gameObjectTemplate: {},
    };
  },
  actions: {
    searchGameObjectTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(SEARCH_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_GAME_OBJECT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countGameObjectTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.once(COUNT_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(COUNT_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_GAME_OBJECT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateGameObjectTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GAME_OBJECT_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.once(STORE_GAME_OBJECT_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_GAME_OBJECT_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_GAME_OBJECT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.once(FIND_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(FIND_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_GAME_OBJECT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_GAME_OBJECT_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_GAME_OBJECT_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_GAME_OBJECT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyGameObjectTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_GAME_OBJECT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createGameObjectTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.once(CREATE_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(CREATE_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_GAME_OBJECT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyGameObjectTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.once(COPY_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_GAME_OBJECT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
