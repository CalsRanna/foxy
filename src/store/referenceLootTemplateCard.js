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
        ipcRenderer.once(
          SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD,
          (event, response) => {
            commit(SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD, response);
            resolve();
          }
        );
        ipcRenderer.once(
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
        ipcRenderer.once(STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(
          FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
          (event, response) => {
            commit(FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD, response);
            resolve();
          }
        );
        ipcRenderer.once(
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
        ipcRenderer.once(UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(
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
        ipcRenderer.once(
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
