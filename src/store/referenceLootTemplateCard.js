const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD,
  STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  CREATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    referenceLootTemplates: [],
    referenceLootTemplate: {},
  }),
  actions: {
    searchReferenceLootTemplatesForCard({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD, payload);
        ipcRenderer.on(
          SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD,
          (event, response) => {
            commit(SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeReferenceLootTemplateForCard(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, payload);
        ipcRenderer.on(STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
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
    findReferenceLootTemplateForCard({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD, payload);
        ipcRenderer.on(
          FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
          (event, response) => {
            commit(FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${FIND_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateReferenceLootTemplateForCard(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, payload);
        ipcRenderer.on(UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
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
    destroyReferenceLootTemplateForCard(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, payload);
        ipcRenderer.on(DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
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
    createReferenceLootTemplateForCard({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, payload);
        resolve();
      });
    },
    copyReferenceLootTemplateForCard(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, payload);
        ipcRenderer.on(COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
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
    checkReferenceEntriesForCard(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("CHECK_REFERENCE_ENTRIES_FOR_CARD", payload);
        ipcRenderer.on(
          "CHECK_REFERENCE_ENTRIES_FOR_CARD",
          (event, response) => {
            let references = [];
            for (let record of response) {
              if (record.Reference) {
                references.push(record.Reference);
              }
            }
            resolve(references);
          }
        );
        ipcRenderer.on(
          "CHECK_REFERENCE_ENTRIES_FOR_CARD_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD](state, referenceLootTemplates) {
      state.referenceLootTemplates = referenceLootTemplates;
    },
    [FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD](state, referenceLootTemplate) {
      state.referenceLootTemplate = referenceLootTemplate;
    },
    [CREATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD](state, referenceLootTemplate) {
      state.referenceLootTemplate = referenceLootTemplate;
    },
  },
};
