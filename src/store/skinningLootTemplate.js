const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SKINNING_LOOT_TEMPLATES,
  STORE_SKINNING_LOOT_TEMPLATE,
  FIND_SKINNING_LOOT_TEMPLATE,
  UPDATE_SKINNING_LOOT_TEMPLATE,
  DESTROY_SKINNING_LOOT_TEMPLATE,
  CREATE_SKINNING_LOOT_TEMPLATE,
  COPY_SKINNING_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    skinningLootTemplates: [],
    skinningLootTemplate: {},
  }),
  actions: {
    searchSkinningLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SKINNING_LOOT_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_SKINNING_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_SKINNING_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_SKINNING_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeSkinningLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_SKINNING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findSkinningLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_SKINNING_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_SKINNING_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_SKINNING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateSkinningLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_SKINNING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroySkinningLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_SKINNING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createSkinningLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SKINNING_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copySkinningLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SKINNING_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_SKINNING_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_SKINNING_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
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
    },
  },
};
