import {
  SEARCH_GAME_OBJECT_TEMPLATES,
  COUNT_GAME_OBJECT_TEMPLATES,
  PAGINATE_GAME_OBJECT_TEMPLATES,
  FIND_GAME_OBJECT_TEMPLATE
} from "./MUTATION_TYPES";
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
    search({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_GAME_OBJECT_TEMPLATES", payload);
        ipcRenderer.on("SEARCH_GAME_OBJECT_TEMPLATES_REPLY", (event, response) => {
          commit(SEARCH_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    count({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("COUNT_GAME_OBJECT_TEMPLATES", payload);
        ipcRenderer.on("COUNT_GAME_OBJECT_TEMPLATES_REPLY", (event, response) => {
          commit(COUNT_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    find({commit}, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_TEMPLATE, (event, response) =>{
          commit(FIND_GAME_OBJECT_TEMPLATE, response);
          resolve();
        })
      })
    },
    maxEntry() {
      return new Promise(resolve => {
        ipcRenderer.send("GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE");
        ipcRenderer.on("GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE", (event, response) => {
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
    [FIND_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate
    }
  }
};
