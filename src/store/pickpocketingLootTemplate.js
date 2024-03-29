const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  STORE_PICKPOCKETING_LOOT_TEMPLATE,
  FIND_PICKPOCKETING_LOOT_TEMPLATE,
  UPDATE_PICKPOCKETING_LOOT_TEMPLATE,
  DESTROY_PICKPOCKETING_LOOT_TEMPLATE,
  CREATE_PICKPOCKETING_LOOT_TEMPLATE,
  COPY_PICKPOCKETING_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pickpocketingLootTemplates: [],
    pickpocketingLootTemplate: {},
  }),
  actions: {
    searchPickpocketingLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, payload);
        ipcRenderer.once(
          SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
          (event, response) => {
            commit(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_PICKPOCKETING_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storePickpocketingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findPickpocketingLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(
          FIND_PICKPOCKETING_LOOT_TEMPLATE,
          (event, response) => {
            commit(FIND_PICKPOCKETING_LOOT_TEMPLATE, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${FIND_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updatePickpocketingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyPickpocketingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createPickpocketingLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_PICKPOCKETING_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyPickpocketingLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_PICKPOCKETING_LOOT_TEMPLATES](state, pickpocketingLootTemplates) {
      state.pickpocketingLootTemplates = pickpocketingLootTemplates;
    },
    [FIND_PICKPOCKETING_LOOT_TEMPLATE](state, pickpocketingLootTemplate) {
      state.pickpocketingLootTemplate = pickpocketingLootTemplate;
    },
    [CREATE_PICKPOCKETING_LOOT_TEMPLATE](state, pickpocketingLootTemplate) {
      state.pickpocketingLootTemplate = pickpocketingLootTemplate;
    },
  },
};
