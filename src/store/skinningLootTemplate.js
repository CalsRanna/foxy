const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_SKINNING_LOOT_TEMPLATES,
  STORE_SKINNING_LOOT_TEMPLATE,
  FIND_SKINNING_LOOT_TEMPLATE,
  UPDATE_SKINNING_LOOT_TEMPLATE,
  DESTROY_SKINNING_LOOT_TEMPLATE,
  CREATE_SKINNING_LOOT_TEMPLATE,
  COPY_SKINNING_LOOT_TEMPLATE
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    skinningLootTemplates: [],
    skinningLootTemplate: {}
  }),
  actions: {
    searchSkinningLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_SKINNING_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_SKINNING_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_SKINNING_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    },
    storeSkinningLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(STORE_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    findSkinningLootTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(FIND_SKINNING_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_SKINNING_LOOT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateSkinningLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    destroySkinningLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createSkinningLootTemplate({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_SKINNING_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copySkinningLootTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.on(COPY_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_SKINNING_LOOT_TEMPLATES](state, skinningLootTemplates) {
      state.skinningLootTemplates = skinningLootTemplates;
    },
    [FIND_SKINNING_LOOT_TEMPLATE](state, skinningLootTemplate) {
      state.skinningLootTemplate = skinningLootTemplate;
    },
    [CREATE_SKINNING_LOOT_TEMPLATE](state, skinningLootTemplate) {
      state.skinningLootTemplate = skinningLootTemplate;
    }
  }
};
