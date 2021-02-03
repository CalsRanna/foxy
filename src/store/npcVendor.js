const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_NPC_VENDORS,
  STORE_NPC_VENDOR,
  FIND_NPC_VENDOR,
  UPDATE_NPC_VENDOR,
  DESTROY_NPC_VENDOR,
  CREATE_NPC_VENDOR,
  COPY_NPC_VENDOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    npcVendors: [],
    npcVendor: {},
  }),
  actions: {
    searchNpcVendors({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_NPC_VENDORS, payload);
        ipcRenderer.on(SEARCH_NPC_VENDORS, (event, response) => {
          commit(SEARCH_NPC_VENDORS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_NPC_VENDORS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    storeNpcVendor(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_NPC_VENDOR, payload);
        ipcRenderer.on(STORE_NPC_VENDOR, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_NPC_VENDOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findNpcVendor({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_NPC_VENDOR, payload);
        ipcRenderer.on(FIND_NPC_VENDOR, (event, response) => {
          commit(FIND_NPC_VENDOR, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_NPC_VENDOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateNpcVendor(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_NPC_VENDOR, payload);
        ipcRenderer.on(UPDATE_NPC_VENDOR, () => {
          resolve();
        });
        ipcRenderer.on(`${UPDATE_NPC_VENDOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyNpcVendor(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_NPC_VENDOR, payload);
        ipcRenderer.on(DESTROY_NPC_VENDOR, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_NPC_VENDOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createNpcVendor({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_NPC_VENDOR, payload);
        ipcRenderer.on(CREATE_NPC_VENDOR, (event, response) => {
          commit(CREATE_NPC_VENDOR, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_NPC_VENDOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyNpcVendor(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_NPC_VENDOR, payload);
        ipcRenderer.on(COPY_NPC_VENDOR, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_NPC_VENDOR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
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
    },
  },
};
