const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_LOOT_TEMPLATES,
  STORE_CREATURE_LOOT_TEMPLATE,
  FIND_CREATURE_LOOT_TEMPLATE,
  UPDATE_CREATURE_LOOT_TEMPLATE,
  DESTROY_CREATURE_LOOT_TEMPLATE,
  CREATE_CREATURE_LOOT_TEMPLATE,
  COPY_CREATURE_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureLootTemplates: [],
    creatureLootTemplate: {},
  }),
  actions: {
    searchCreatureLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_CREATURE_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(STORE_CREATURE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_CREATURE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(FIND_CREATURE_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_CREATURE_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_CREATURE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_CREATURE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_CREATURE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_CREATURE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_CREATURE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CREATURE_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyCreatureLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(COPY_CREATURE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_CREATURE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_LOOT_TEMPLATES](state, creatureLootTemplates) {
      state.creatureLootTemplates = creatureLootTemplates;
    },
    [FIND_CREATURE_LOOT_TEMPLATE](state, creatureLootTemplate) {
      state.creatureLootTemplate = creatureLootTemplate;
    },
    [CREATE_CREATURE_LOOT_TEMPLATE](state, creatureLootTemplate) {
      state.creatureLootTemplate = creatureLootTemplate;
    },
  },
};
