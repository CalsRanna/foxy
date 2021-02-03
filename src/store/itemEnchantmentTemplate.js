const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_ITEM_ENCHANTMENT_TEMPLATES,
  STORE_ITEM_ENCHANTMENT_TEMPLATE,
  FIND_ITEM_ENCHANTMENT_TEMPLATE,
  UPDATE_ITEM_ENCHANTMENT_TEMPLATE,
  DESTROY_ITEM_ENCHANTMENT_TEMPLATE,
  CREATE_ITEM_ENCHANTMENT_TEMPLATE,
  COPY_ITEM_ENCHANTMENT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    itemEnchantmentTemplates: [],
    itemEnchantmentTemplate: {},
  }),
  actions: {
    searchItemEnchantmentTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, (event, response) => {
          commit(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_ITEM_ENCHANTMENT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeItemEnchantmentTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ITEM_ENCHANTMENT_TEMPLATE, payload);
        ipcRenderer.on(STORE_ITEM_ENCHANTMENT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findItemEnchantmentTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ITEM_ENCHANTMENT_TEMPLATE, payload);
        ipcRenderer.on(FIND_ITEM_ENCHANTMENT_TEMPLATE, (event, response) => {
          commit(FIND_ITEM_ENCHANTMENT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateItemEnchantmentTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ITEM_ENCHANTMENT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_ITEM_ENCHANTMENT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyItemEnchantmentTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ITEM_ENCHANTMENT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_ITEM_ENCHANTMENT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createItemEnchantmentTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_ITEM_ENCHANTMENT_TEMPLATE, payload);
        resolve();
      });
    },
    copyItemEnchantmentTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ITEM_ENCHANTMENT_TEMPLATE, payload);
        ipcRenderer.on(COPY_ITEM_ENCHANTMENT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_ENCHANTMENT_TEMPLATES](state, itemEnchantmentTemplates) {
      state.itemEnchantmentTemplates = itemEnchantmentTemplates;
    },
    [FIND_ITEM_ENCHANTMENT_TEMPLATE](state, itemEnchantmentTemplate) {
      state.itemEnchantmentTemplate = itemEnchantmentTemplate;
    },
    [CREATE_ITEM_ENCHANTMENT_TEMPLATE](state, itemEnchantmentTemplate) {
      state.itemEnchantmentTemplate = itemEnchantmentTemplate;
    },
  },
};
