import { SEARCH_SMART_SCRIPTS } from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      smartScripts: []
    };
  },
  actions: {
    search({ commit }, payload) {
      ipcRenderer.on("SEARCH_SMART_SCRIPTS_REPLY", (event, response) => {
        commit(SEARCH_SMART_SCRIPTS, response);
      });
      ipcRenderer.send("SEARCH_SMART_SCRIPTS", payload);
    }
  },
  mutations: {
    [SEARCH_SMART_SCRIPTS](state, smartScripts) {
      state.smartScripts = smartScripts;
    }
  }
};
