const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELL_LINKED_SPELLS,
  STORE_SPELL_LINKED_SPELL,
  FIND_SPELL_LINKED_SPELL,
  UPDATE_SPELL_LINKED_SPELL,
  DESTROY_SPELL_LINKED_SPELL,
  CREATE_SPELL_LINKED_SPELL,
  COPY_SPELL_LINKED_SPELL,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    spellLinkedSpells: [],
    spellLinkedSpell: {},
  }),
  actions: {
    searchSpellLinkedSpells({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_LINKED_SPELLS, payload);
        ipcRenderer.once(SEARCH_SPELL_LINKED_SPELLS, (event, response) => {
          commit(SEARCH_SPELL_LINKED_SPELLS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_SPELL_LINKED_SPELLS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeSpellLinkedSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_LINKED_SPELL, payload);
        ipcRenderer.once(STORE_SPELL_LINKED_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_SPELL_LINKED_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findSpellLinkedSpell({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_LINKED_SPELL, payload);
        ipcRenderer.once(FIND_SPELL_LINKED_SPELL, (event, response) => {
          commit(FIND_SPELL_LINKED_SPELL, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_SPELL_LINKED_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateSpellLinkedSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_LINKED_SPELL, payload);
        ipcRenderer.once(UPDATE_SPELL_LINKED_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_SPELL_LINKED_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroySpellLinkedSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SPELL_LINKED_SPELL, payload);
        ipcRenderer.once(DESTROY_SPELL_LINKED_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_SPELL_LINKED_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createSpellLinkedSpell({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SPELL_LINKED_SPELL, payload);
        resolve();
      });
    },
    copySpellLinkedSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SPELL_LINKED_SPELL, payload);
        ipcRenderer.once(COPY_SPELL_LINKED_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_SPELL_LINKED_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_LINKED_SPELLS](state, spellLinkedSpells) {
      state.spellLinkedSpells = spellLinkedSpells;
    },
    [FIND_SPELL_LINKED_SPELL](state, spellLinkedSpell) {
      state.spellLinkedSpell = spellLinkedSpell;
    },
    [CREATE_SPELL_LINKED_SPELL](state, spellLinkedSpell) {
      state.spellLinkedSpell = spellLinkedSpell;
    },
  },
};
