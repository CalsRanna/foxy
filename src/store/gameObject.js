import { SEARCH_GAME_OBJECT_TEMPLATES } from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      gameObjectTemplates: []
    };
  },
  actions: {
    search({ commit }, payload) {
      ipcRenderer.on("SEARCH_GAME_OBJECT_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_GAME_OBJECT_TEMPLATES, response);
      });
      ipcRenderer.send("SEARCH_GAME_OBJECT_TEMPLATES", payload);
    }
  },
  mutations: {
    [SEARCH_GAME_OBJECT_TEMPLATES](state, gameObjectTemplates) {
      state.gameObjectTemplates = gameObjectTemplates;
    }
  }
};
