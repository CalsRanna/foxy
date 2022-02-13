const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELL_LOOT_TEMPLATES,
  STORE_SPELL_LOOT_TEMPLATE,
  FIND_SPELL_LOOT_TEMPLATE,
  UPDATE_SPELL_LOOT_TEMPLATE,
  DESTROY_SPELL_LOOT_TEMPLATE,
  CREATE_SPELL_LOOT_TEMPLATE,
  COPY_SPELL_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    spellLootTemplates: [],
    spellLootTemplate: {},
  }),
  actions: {
    searchSpellLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_LOOT_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_SPELL_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_SPELL_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_SPELL_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeSpellLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_SPELL_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_SPELL_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findSpellLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_SPELL_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_SPELL_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_SPELL_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateSpellLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_SPELL_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_SPELL_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroySpellLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SPELL_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_SPELL_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_SPELL_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createSpellLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SPELL_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copySpellLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SPELL_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_SPELL_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_SPELL_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_LOOT_TEMPLATES](state, spellLootTemplates) {
      state.spellLootTemplates = spellLootTemplates;
    },
    [FIND_SPELL_LOOT_TEMPLATE](state, spellLootTemplate) {
      state.spellLootTemplate = spellLootTemplate;
    },
    [CREATE_SPELL_LOOT_TEMPLATE](state, spellLootTemplate) {
      state.spellLootTemplate = spellLootTemplate;
    },
  },
};
