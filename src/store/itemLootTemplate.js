const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_LOOT_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_ITEM_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_ITEM_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_ITEM_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeItemLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_ITEM_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findItemLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_ITEM_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_ITEM_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_ITEM_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateItemLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_ITEM_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyItemLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_ITEM_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createItemLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_ITEM_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyItemLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ITEM_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_ITEM_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_ITEM_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
