import {
  SEARCH_ITEM_TEMPLATES,
  COUNT_ITEM_TEMPLATES,
  PAGINATE_ITEM_TEMPLATES,
  FIND_ITEM_TEMPLATE,
  SEARCH_ITEM_TEMPLATE_LOCALES
  // STORE_ITEM_TEMPLATE_LOCALE,
  // DESTROY_ITEM_TEMPLATE_LOCALE,
} from "./MUTATION_TYPES";
// import item from "../background/item";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    entry: undefined,
    name: undefined,
    page: 1,
    total: 0,
    itemTemplates: [],
    itemTemplate: {},
    itemTemplateLocales: [],
    itemEnchantmentTemplates: [],
    itemLootTemplates: [],
    disenchantLootTemplates: [],
    prospectingLootTemplates: [],
    millingLootTemplates: []
  }),
  actions: {
    search({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_ITEM_TEMPLATES", payload);
        ipcRenderer.on("SEARCH_ITEM_TEMPLATES_REPLY", (event, response) => {
          commit(SEARCH_ITEM_TEMPLATES, response);
          resolve();
        });
      });
    },
    count({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("COUNT_ITEM_TEMPLATES", payload);
        ipcRenderer.on("COUNT_ITEM_TEMPLATES_REPLY", (event, response) => {
          commit(COUNT_ITEM_TEMPLATES, response);
          resolve();
        });
      });
    },
    find({ commit }, payload) {
      ipcRenderer.on("FIND_ITEM_TEMPLATE_REPLY", (event, response) => {
        commit(FIND_ITEM_TEMPLATE, response);
      });
      ipcRenderer.send("FIND_ITEM_TEMPLATE", payload);
    },
    searchItemTemplateLocales({ commit }, payload) {
      ipcRenderer.on("SEARCH_ITEM_TEMPLATE_LOCALES_REPLY", (event, response) => {
        commit(SEARCH_ITEM_TEMPLATE_LOCALES, response);
      });
      ipcRenderer.send("SEARCH_ITEM_TEMPLATE_LOCALES", payload);
    }
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
    },
    [SEARCH_ITEM_TEMPLATE_LOCALES](state, itemTemplateLocales) {
      state.itemTemplateLocales = itemTemplateLocales;
    }
  }
};
