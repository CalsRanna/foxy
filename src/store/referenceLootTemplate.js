const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_REFERENCE_LOOT_TEMPLATES,
  STORE_REFERENCE_LOOT_TEMPLATE,
  FIND_REFERENCE_LOOT_TEMPLATE,
  UPDATE_REFERENCE_LOOT_TEMPLATE,
  DESTROY_REFERENCE_LOOT_TEMPLATE,
  CREATE_REFERENCE_LOOT_TEMPLATE,
  COPY_REFERENCE_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    referenceLootTemplates: [],
    referenceLootTemplate: {},
  }),
  actions: {
    searchReferenceLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_REFERENCE_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_REFERENCE_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_REFERENCE_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_REFERENCE_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeReferenceLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(STORE_REFERENCE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findReferenceLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(FIND_REFERENCE_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_REFERENCE_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateReferenceLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_REFERENCE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyReferenceLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_REFERENCE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createReferenceLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_REFERENCE_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyReferenceLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.on(COPY_REFERENCE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    checkReferenceEntries(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("CHECK_REFERENCE_ENTRIES", payload);
        ipcRenderer.on("CHECK_REFERENCE_ENTRIES", (event, response) => {
          let references = [];
          for (let record of response) {
            if (record.Reference) {
              references.push(record.Reference);
            }
          }
          resolve(references);
        });
        ipcRenderer.on("CHECK_REFERENCE_ENTRIES_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
  },
  mutations: {
    [SEARCH_REFERENCE_LOOT_TEMPLATES](state, referenceLootTemplates) {
      state.referenceLootTemplates = referenceLootTemplates;
    },
    [FIND_REFERENCE_LOOT_TEMPLATE](state, referenceLootTemplate) {
      state.referenceLootTemplate = referenceLootTemplate;
    },
    [CREATE_REFERENCE_LOOT_TEMPLATE](state, referenceLootTemplate) {
      state.referenceLootTemplate = referenceLootTemplate;
    },
  },
};
