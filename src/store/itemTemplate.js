const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_ITEM_TEMPLATES,
  COUNT_ITEM_TEMPLATES,
  PAGINATE_ITEM_TEMPLATES,
  STORE_ITEM_TEMPLATE,
  FIND_ITEM_TEMPLATE,
  UPDATE_ITEM_TEMPLATE,
  DESTROY_ITEM_TEMPLATE,
  CREATE_ITEM_TEMPLATE,
  COPY_ITEM_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    refresh: true,
    filter: {
      class: undefined,
      subclass: undefined,
    },
    credential: {
      entry: undefined,
      name: undefined,
      description: undefined,
    },
    pagination: {
      page: 1,
      size: 50,
      total: 0,
    },
    itemTemplates: [],
    itemTemplate: {},
  }),
  actions: {
    searchItemTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_ITEM_TEMPLATES, (event, response) => {
          commit(SEARCH_ITEM_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_ITEM_TEMPLATES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countItemTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ITEM_TEMPLATES, payload);
        ipcRenderer.on(COUNT_ITEM_TEMPLATES, (event, response) => {
          commit(COUNT_ITEM_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_ITEM_TEMPLATES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateItemTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ITEM_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeItemTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ITEM_TEMPLATE, payload);
        ipcRenderer.on(STORE_ITEM_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_ITEM_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_ITEM_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findItemTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ITEM_TEMPLATE, payload);
        ipcRenderer.on(FIND_ITEM_TEMPLATE, (event, response) => {
          commit(FIND_ITEM_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_ITEM_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateItemTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ITEM_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_ITEM_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_ITEM_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_ITEM_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyItemTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ITEM_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_ITEM_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_ITEM_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createItemTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_ITEM_TEMPLATE, payload);
        ipcRenderer.on(CREATE_ITEM_TEMPLATE, (event, response) => {
          commit(CREATE_ITEM_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_ITEM_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyItemTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ITEM_TEMPLATE, payload);
        ipcRenderer.on(COPY_ITEM_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_ITEM_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateFilter({ commit }, payload) {
      return new Promise((resolve) => {
        commit("UPDATE_FILTER_OF_ITEM_TEMPLATE", payload);
        resolve();
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_ITEM_TEMPLATE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_TEMPLATES](state, itemTemplates) {
      state.itemTemplates = itemTemplates;
      state.refresh = false;
    },
    [COUNT_ITEM_TEMPLATES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ITEM_TEMPLATES](state, page) {
      state.pagination.page = page;
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
    UPDATE_FILTER_OF_ITEM_TEMPLATE(state, filter) {
      state.filter = filter;
    },
    UPDATE_REFRESH_OF_ITEM_TEMPLATE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_ITEM_TEMPLATE(state) {
      state.credential = {
        entry: undefined,
        name: undefined,
        description: undefined,
      };
    },
  },
};
