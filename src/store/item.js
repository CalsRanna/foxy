import {
  COPY_ITEM_TEMPLATE,
  COUNT_ITEM_TEMPLATES,
  CREATE_ITEM_TEMPLATE,
  DESTROY_ITEM_TEMPLATE,
  FIND_ITEM_TEMPLATE,
  PAGINATE_ITEM_TEMPLATES,
  SEARCH_ITEM_TEMPLATES,
  SEARCH_ITEM_TEMPLATE_LOCALES,
  STORE_ITEM_TEMPLATE,
  UPDATE_ITEM_TEMPLATE
} from "../constants";

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
    searchItemTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_ITEM_TEMPLATES", payload);
        ipcRenderer.on("SEARCH_ITEM_TEMPLATES_REPLY", (event, response) => {
          commit(SEARCH_ITEM_TEMPLATES, response);
          resolve();
        });
      });
    },
    countItemTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_ITEM_TEMPLATES, payload);
        ipcRenderer.on(COUNT_ITEM_TEMPLATES, (event, response) => {
          commit(COUNT_ITEM_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateItemTemplates({ commit }, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_ITEM_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeItemTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_ITEM_TEMPLATE, payload);
        ipcRenderer.on(STORE_ITEM_TEMPLATE, (event, response) => {
          commit(STORE_ITEM_TEMPLATE, response);
          resolve();
        });
      });
    },
    findItemTemplate({ commit }, payload) {
      ipcRenderer.on("FIND_ITEM_TEMPLATE_REPLY", (event, response) => {
        commit(FIND_ITEM_TEMPLATE, response);
      });
      ipcRenderer.send("FIND_ITEM_TEMPLATE", payload);
    },
    updateItemTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_ITEM_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_ITEM_TEMPLATE, (event, response) => {
          commit(UPDATE_ITEM_TEMPLATE, response);
          resolve();
        });
      });
    },
    destroyItemTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_ITEM_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_ITEM_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createItemTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(CREATE_ITEM_TEMPLATE, payload);
        ipcRenderer.on(CREATE_ITEM_TEMPLATE, (event, response) => {
          commit(CREATE_ITEM_TEMPLATE, response);
          resolve();
        });
      });
    },
    copyItemTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_ITEM_TEMPLATE, payload);
        ipcRenderer.on(COPY_ITEM_TEMPLATE, () => {
          resolve();
        });
      });
    },
    searchItemTemplateLocales({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_ITEM_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(SEARCH_ITEM_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_ITEM_TEMPLATE_LOCALES, response);
          resolve();
        });
      });
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
    [STORE_ITEM_TEMPLATE](state, itemTemplate) {
      state.itemTemplate = itemTemplate;
    },
    [FIND_ITEM_TEMPLATE](state, itemTemplate) {
      state.itemTemplate = itemTemplate;
    },
    [UPDATE_ITEM_TEMPLATE](state, itemTemplate) {
      state.itemTemplate = itemTemplate;
    },
    [CREATE_ITEM_TEMPLATE](state, itemTemplate) {
      state.itemTemplate = itemTemplate;
    },
    [SEARCH_ITEM_TEMPLATE_LOCALES](state, itemTemplateLocales) {
      state.itemTemplateLocales = itemTemplateLocales;
    }
  }
};
