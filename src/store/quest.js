import { SEARCH_QUEST_TEMPLATES, COUNT_QUEST_TEMPLATES, PAGINATE_QUEST_TEMPLATES } from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      questTemplates: []
    };
  },
  actions: {
    search({ commit }, payload) {
      ipcRenderer.on("SEARCH_QUEST_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_QUEST_TEMPLATES, response);
      });
      ipcRenderer.send("SEARCH_QUEST_TEMPLATES", payload);
    },
    count({ commit }, payload) {
      ipcRenderer.on("COUNT_QUEST_TEMPLATES_REPLY", (event, response) => {
        commit(COUNT_QUEST_TEMPLATES, response);
      });
      ipcRenderer.send("COUNT_QUEST_TEMPLATES", payload);
    }
  },
  mutations: {
    [SEARCH_QUEST_TEMPLATES](state, questTemplates) {
      state.questTemplates = questTemplates;
    },
    [COUNT_QUEST_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_QUEST_TEMPLATES](state, page) {
      state.page = page;
    }
  }
};
