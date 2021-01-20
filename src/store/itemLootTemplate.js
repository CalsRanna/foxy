const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_ITEM_LOOT_TEMPLATES,
  STORE_ITEM_LOOT_TEMPLATE,
  FIND_ITEM_LOOT_TEMPLATE,
  UPDATE_ITEM_LOOT_TEMPLATE,
  DESTROY_ITEM_LOOT_TEMPLATE,
  CREATE_ITEM_LOOT_TEMPLATE,
  COPY_ITEM_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    itemLootTemplates: [],
    itemLootTemplate: {},
  }),
  actions: {
    searchItemLootTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_ITEM_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_ITEM_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_ITEM_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    },
    storeItemLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.on(STORE_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    findItemLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.on(FIND_ITEM_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_ITEM_LOOT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateItemLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    destroyItemLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createItemLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_ITEM_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyItemLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.on(COPY_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_LOOT_TEMPLATES](state, itemLootTemplates) {
      state.itemLootTemplates = itemLootTemplates;
    },
    [FIND_ITEM_LOOT_TEMPLATE](state, itemLootTemplate) {
      state.itemLootTemplate = itemLootTemplate;
    },
    [CREATE_ITEM_LOOT_TEMPLATE](state, itemLootTemplate) {
      state.itemLootTemplate = itemLootTemplate;
    },
  },
};
