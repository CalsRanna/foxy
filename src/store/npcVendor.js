const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_NPC_VENDORS,
  STORE_NPC_VENDOR,
  FIND_NPC_VENDOR,
  UPDATE_NPC_VENDOR,
  DESTROY_NPC_VENDOR,
  CREATE_NPC_VENDOR,
  COPY_NPC_VENDOR
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    npcVendors: [],
    npcVendor: {}
  }),
  actions: {
    searchCreatureEquipTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_NPC_VENDORS, payload);
        ipcRenderer.on(SEARCH_NPC_VENDORS, (event, response) => {
          commit(SEARCH_NPC_VENDORS, response);
          resolve();
        });
      });
    },
    storeCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_NPC_VENDOR, payload);
        ipcRenderer.on(STORE_NPC_VENDOR, (event, response) => {
          resolve();
        });
      });
    },
    findCreatureEquipTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_NPC_VENDOR, payload);
        ipcRenderer.on(FIND_NPC_VENDOR, (event, response) => {
          commit(FIND_NPC_VENDOR, response);
          resolve();
        });
      });
    },
    updateCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_NPC_VENDOR, payload);
        ipcRenderer.on(UPDATE_NPC_VENDOR, (event, response) => {
          resolve();
        });
      });
    },
    destroyCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_NPC_VENDOR, payload);
        ipcRenderer.on(DESTROY_NPC_VENDOR, (event, response) => {
          resolve();
        });
      });
    },
    createCreatureEquipTemplate({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_NPC_VENDOR, payload);
        resolve();
      });
    },
    copyCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_NPC_VENDOR, payload);
        ipcRenderer.on(COPY_NPC_VENDOR, (event, response) => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_NPC_VENDORS](state, npcVendors) {
      state.npcVendors = npcVendors;
    },
    [FIND_NPC_VENDOR](state, npcVendor) {
      state.npcVendor = npcVendor;
    },
    [CREATE_NPC_VENDOR](state, npcVendor) {
      state.npcVendor = npcVendor;
    }
  }
};
