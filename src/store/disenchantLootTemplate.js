const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_DISENCHANT_LOOT_TEMPLATES,
  STORE_DISENCHANT_LOOT_TEMPLATE,
  FIND_DISENCHANT_LOOT_TEMPLATE,
  UPDATE_DISENCHANT_LOOT_TEMPLATE,
  DESTROY_DISENCHANT_LOOT_TEMPLATE,
  CREATE_DISENCHANT_LOOT_TEMPLATE,
  COPY_DISENCHANT_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    disenchantLootTemplates: [],
    disenchantLootTemplate: {},
  }),
  actions: {
    searchDisenchantLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DISENCHANT_LOOT_TEMPLATES, payload);
        ipcRenderer.once(
          SEARCH_DISENCHANT_LOOT_TEMPLATES,
          (event, response) => {
            commit(SEARCH_DISENCHANT_LOOT_TEMPLATES, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_DISENCHANT_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeDisenchantLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_DISENCHANT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_DISENCHANT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_DISENCHANT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findDisenchantLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_DISENCHANT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_DISENCHANT_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_DISENCHANT_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_DISENCHANT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateDisenchantLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_DISENCHANT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_DISENCHANT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_DISENCHANT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyDisenchantLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_DISENCHANT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_DISENCHANT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_DISENCHANT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createDisenchantLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_DISENCHANT_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyDisenchantLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_DISENCHANT_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_DISENCHANT_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_DISENCHANT_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_DISENCHANT_LOOT_TEMPLATES](state, disenchantLootTemplates) {
      state.disenchantLootTemplates = disenchantLootTemplates;
    },
    [FIND_DISENCHANT_LOOT_TEMPLATE](state, disenchantLootTemplate) {
      state.disenchantLootTemplate = disenchantLootTemplate;
    },
    [CREATE_DISENCHANT_LOOT_TEMPLATE](state, disenchantLootTemplate) {
      state.disenchantLootTemplate = disenchantLootTemplate;
    },
  },
};
