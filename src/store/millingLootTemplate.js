const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_MILLING_LOOT_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_MILLING_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_MILLING_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_MILLING_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeMillingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_MILLING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findMillingLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_MILLING_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_MILLING_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_MILLING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateMillingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_MILLING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyMillingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_MILLING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createMillingLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_MILLING_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyMillingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_MILLING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_MILLING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_MILLING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
