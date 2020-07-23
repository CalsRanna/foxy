import {
  SEARCH_CREATURE_TEMPLATES,
  COUNT_CREATURE_TEMPLATES,
  PAGINATE_CREATURE_TEMPLATES,
} from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

const creatureTemplate = {
  namespaced: true,
  state: () => ({
    entry: undefined,
    name: undefined,
    subname: undefined,
    page: 1,
    total: 0,
    creatureTemplates: [],
  }),
  actions: {
    async search({ commit }, payload) {
      ipcRenderer.on("SEARCH_CREATURE_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_TEMPLATES, response);
      });
      ipcRenderer.send("SEARCH_CREATURE_TEMPLATES", payload);
    },
    async count({ commit }, payload) {
      ipcRenderer.on("COUNT_CREATURE_TEMPLATES_REPLY", (event, response) => {
        commit(COUNT_CREATURE_TEMPLATES, response);
      });
      ipcRenderer.send("COUNT_CREATURE_TEMPLATES", payload);
    },
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATES](state, creatureTemplates) {
      state.creatureTemplates = creatureTemplates;
    },
    [COUNT_CREATURE_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_CREATURE_TEMPLATES](state, page) {
      state.page = page;
    },
  },
};

export default creatureTemplate;
