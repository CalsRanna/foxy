const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELL_GROUPS,
  STORE_SPELL_GROUP,
  FIND_SPELL_GROUP,
  UPDATE_SPELL_GROUP,
  DESTROY_SPELL_GROUP,
  CREATE_SPELL_GROUP,
  COPY_SPELL_GROUP,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    spellGroups: [],
    spellGroup: {},
  }),
  actions: {
    searchSpellGroups({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_GROUPS, payload);
        ipcRenderer.once(SEARCH_SPELL_GROUPS, (event, response) => {
          commit(SEARCH_SPELL_GROUPS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_SPELL_GROUPS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    storeSpellGroup(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_GROUP, payload);
        ipcRenderer.once(STORE_SPELL_GROUP, () => {
          resolve();
        });
        ipcRenderer.once(`${STORE_SPELL_GROUP}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findSpellGroup({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_GROUP, payload);
        ipcRenderer.once(FIND_SPELL_GROUP, (event, response) => {
          commit(FIND_SPELL_GROUP, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_SPELL_GROUP}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateSpellGroup(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_GROUP, payload);
        ipcRenderer.once(UPDATE_SPELL_GROUP, () => {
          resolve();
        });
        ipcRenderer.once(`${UPDATE_SPELL_GROUP}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroySpellGroup(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SPELL_GROUP, payload);
        ipcRenderer.once(DESTROY_SPELL_GROUP, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_SPELL_GROUP}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createSpellGroup({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SPELL_GROUP, payload);
        resolve();
      });
    },
    copySpellGroup(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SPELL_GROUP, payload);
        ipcRenderer.once(COPY_SPELL_GROUP, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_SPELL_GROUP}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_GROUPS](state, spellGroups) {
      state.spellGroups = spellGroups;
    },
    [FIND_SPELL_GROUP](state, spellGroup) {
      state.spellGroup = spellGroup;
    },
    [CREATE_SPELL_GROUP](state, spellGroup) {
      state.spellGroup = spellGroup;
    },
  },
};
