import {
  SEARCH_ITEM_TEMPLATES,
  COUNT_ITEM_TEMPLATES,
  PAGINATE_ITEM_TEMPLATES,
  FIND_ITEM_TEMPLATE,
} from "./MUTATION_TYPES";
// import item from "../background/item";
const ipcRenderer = window.require("electron").ipcRenderer;

const itemTemplate = {
  namespaced: true,
  state: () => ({
    entry: undefined,
    name: undefined,
    page: 1,
    total: 0,
    itemTemplates: [],
    itemTemplate: undefined,
  }),
  actions: {
    async search({ commit }, payload) {
      ipcRenderer.on("SEARCH_ITEM_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_ITEM_TEMPLATES, response);
      });
      ipcRenderer.send("SEARCH_ITEM_TEMPLATES", payload);
    },
    async count({ commit }, payload) {
      ipcRenderer.on("COUNT_ITEM_TEMPLATES_REPLY", (event, response) => {
        commit(COUNT_ITEM_TEMPLATES, response);
      });
      ipcRenderer.send("COUNT_ITEM_TEMPLATES", payload);
    },
    find({commit}, payload) {
      ipcRenderer.on("FIND_ITEM_TEMPLATE_REPLY", (event, response) => {
        commit(FIND_ITEM_TEMPLATE, response);
      });
      ipcRenderer.send("FIND_ITEM_TEMPLATE", payload);
    },
  },
  mutations: {
    [SEARCH_ITEM_TEMPLATES](state, itemTemplates) {
      state.itemTemplates = itemTemplates;
    },
    [COUNT_ITEM_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_ITEM_TEMPLATES](state, page) {
      state.page = page;
    },
    [FIND_ITEM_TEMPLATE](state, itemTemplate) {
      state.itemTemplate = itemTemplate;
    }
  },
};

export default itemTemplate;
