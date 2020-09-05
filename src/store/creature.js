import {
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_ENTRY,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_NAME,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_SUBNAME,
  SEARCH_CREATURE_TEMPLATES,
  COUNT_CREATURE_TEMPLATES,
  PAGINATE_CREATURE_TEMPLATES,
  FIND_ITEM_TEMPLATE
} from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    entry: undefined,
    name: undefined,
    subname: undefined,
    page: 1,
    total: 0,
    creatureTemplates: [],
    creatureTemplate: undefined
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
    find({ commit }, payload) {
      ipcRenderer.on("FIND_CREATURE_TEMPLATE_REPLY", (event, response) => {
        commit(FIND_ITEM_TEMPLATE, response);
      });
      ipcRenderer.send("FIND_CREATURE_TEMPLATE", payload);
    }
  },
  mutations: {
    [UPDATE_CREATURE_TEMPLATE_CREDENTIAL_ENTRY](state, entry) {
      state.entry = entry;
    },
    [UPDATE_CREATURE_TEMPLATE_CREDENTIAL_NAME](state, name) {
      state.name = name;
    },
    [UPDATE_CREATURE_TEMPLATE_CREDENTIAL_SUBNAME](state, subname) {
      state.subname = subname;
    },
    [SEARCH_CREATURE_TEMPLATES](state, creatureTemplates) {
      state.creatureTemplates = creatureTemplates;
    },
    [COUNT_CREATURE_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_CREATURE_TEMPLATES](state, page) {
      state.page = page;
    },
    [FIND_ITEM_TEMPLATE](state, creatureTemplate) {
      state.creatureTemplate = creatureTemplate;
    }
  }
};
