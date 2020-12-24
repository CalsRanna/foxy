import { SEARCH_SMART_SCRIPTS, COUNT_SMART_SCRIPTS, PAGINATE_SMART_SCRIPTS, FIND_SMART_SCRIPT } from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      smartScripts: [],
      smartScript: {}
    };
  },
  actions: {
    search({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_SMART_SCRIPTS", payload);
        ipcRenderer.on("SEARCH_SMART_SCRIPTS_REPLY", (event, response) => {
          commit(SEARCH_SMART_SCRIPTS, response);
          resolve();
        });
      });
    },
    count({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("COUNT_SMART_SCRIPTS", payload);
        ipcRenderer.on("COUNT_SMART_SCRIPTS_REPLY", (event, response) => {
          commit(COUNT_SMART_SCRIPTS, response);
          resolve();
        });
      });
    },
    find({commit}, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_SMART_SCRIPT, payload);
        ipcRenderer.on(FIND_SMART_SCRIPT, (event, response) => {
          commit(FIND_SMART_SCRIPT, response);
          resolve();
        })
      })
    }
  },
  mutations: {
    [SEARCH_SMART_SCRIPTS](state, smartScripts) {
      state.smartScripts = smartScripts;
    },
    [COUNT_SMART_SCRIPTS](state, total) {
      state.total = total;
    },
    [PAGINATE_SMART_SCRIPTS](state, page) {
      state.page = page;
    },
    [FIND_SMART_SCRIPT](state, smartScript) {
      state.smartScript = smartScript
    }
  }
};
