import {
  COPY_GAME_OBJECT_TEMPLATE,
  COUNT_GAME_OBJECT_TEMPLATES,
  GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE,
  PAGINATE_GAME_OBJECT_TEMPLATES,
  FIND_GAME_OBJECT_TEMPLATE,
  SEARCH_GAME_OBJECT_TEMPLATES,
  STORE_GAME_OBJECT_TEMPLATE,
  UPDATE_GAME_OBJECT_TEMPLATE,
  DESTROY_GAME_OBJECT_TEMPLATE
} from "../constants";

const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      gameObjectTemplates: [],
      gameObjectTemplate: {},
      gameObjectTemplateLocales: [],
      gameObjectTemplateAddon: {},
      gameObjectQuestItems: [],
      gameObjectLootTemplates: []
    };
  },
  actions: {
    searchGameObjectTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(SEARCH_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    countGameObjectTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.on(COUNT_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(COUNT_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateGameObjectTemplates({commit}, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_GAME_OBJECT_TEMPLATES, payload.page);
        resolve();
      })
    },
    copyGameObjectTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(COPY_GAME_OBJECT_TEMPLATE, (event, response) => {
          resolve()
        })
      })
    },
    storGameObjectTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(STORE_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    findGameObjectTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(FIND_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateGameObjectTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(UPDATE_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    destroyGameObjectTemplate(context, payload){
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_GAME_OBJECT_TEMPLATE, (event, response) => {
          resolve();
        })
      })
    },
    maxEntry() {
      return new Promise(resolve => {
        ipcRenderer.send(GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE);
        ipcRenderer.on(GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE, (event, response) => {
          resolve(response);
        });
      });
    }
  },
  mutations: {
    [SEARCH_GAME_OBJECT_TEMPLATES](state, gameObjectTemplates) {
      state.gameObjectTemplates = gameObjectTemplates;
    },
    [COUNT_GAME_OBJECT_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_GAME_OBJECT_TEMPLATES](state, page) {
      state.page = page;
    },
    [STORE_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      stat.gameObjectTemplate = gameObjectTemplate;
    },
    [FIND_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    [UPDATE_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    }
  }
};
