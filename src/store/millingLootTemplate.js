const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_MILLING_LOOT_TEMPLATES,
  STORE_MILLING_LOOT_TEMPLATE,
  FIND_MILLING_LOOT_TEMPLATE,
  UPDATE_MILLING_LOOT_TEMPLATE,
  DESTROY_MILLING_LOOT_TEMPLATE,
  CREATE_MILLING_LOOT_TEMPLATE,
  COPY_MILLING_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    millingLootTemplates: [],
    millingLootTemplate: {},
  }),
  actions: {
    searchMillingLootTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_MILLING_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_MILLING_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_MILLING_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    },
    storeMillingLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(STORE_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    findMillingLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(FIND_MILLING_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_MILLING_LOOT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateMillingLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    destroyMillingLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createMillingLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_MILLING_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyMillingLootTemplate(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(COPY_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_MILLING_LOOT_TEMPLATES](state, millingLootTemplates) {
      state.millingLootTemplates = millingLootTemplates;
    },
    [FIND_MILLING_LOOT_TEMPLATE](state, millingLootTemplate) {
      state.millingLootTemplate = millingLootTemplate;
    },
    [CREATE_MILLING_LOOT_TEMPLATE](state, millingLootTemplate) {
      state.millingLootTemplate = millingLootTemplate;
    },
  },
};
