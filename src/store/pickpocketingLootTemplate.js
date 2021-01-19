const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  STORE_PICKPOCKETING_LOOT_TEMPLATE,
  FIND_PICKPOCKETING_LOOT_TEMPLATE,
  UPDATE_PICKPOCKETING_LOOT_TEMPLATE,
  DESTROY_PICKPOCKETING_LOOT_TEMPLATE,
  CREATE_PICKPOCKETING_LOOT_TEMPLATE,
  COPY_PICKPOCKETING_LOOT_TEMPLATE
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pickpocketingLootTemplates: [],
    pickpocketingLootTemplate: {}
  }),
  actions: {
    searchPickpocketingLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, payload);
        ipcRenderer.on(
          SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
          (event, response) => {
            commit(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, response);
            resolve();
          }
        );
      });
    },
    storePickpocketingLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(STORE_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    findPickpocketingLootTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(FIND_PICKPOCKETING_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_PICKPOCKETING_LOOT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updatePickpocketingLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    destroyPickpocketingLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createPickpocketingLootTemplate({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_PICKPOCKETING_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyPickpocketingLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_PICKPOCKETING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(COPY_PICKPOCKETING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    }
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
    }
  }
};
