const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELL_AREAS,
  STORE_SPELL_AREA,
  FIND_SPELL_AREA,
  UPDATE_SPELL_AREA,
  DESTROY_SPELL_AREA,
  CREATE_SPELL_AREA,
  COPY_SPELL_AREA,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    spellAreas: [],
    spellArea: {},
  }),
  actions: {
    searchSpellAreas({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_AREAS, payload);
        ipcRenderer.on(SEARCH_SPELL_AREAS, (event, response) => {
          commit(SEARCH_SPELL_AREAS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_SPELL_AREAS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    storeSpellArea(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_AREA, payload);
        ipcRenderer.on(STORE_SPELL_AREA, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_SPELL_AREA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findSpellArea({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_AREA, payload);
        ipcRenderer.on(FIND_SPELL_AREA, (event, response) => {
          commit(FIND_SPELL_AREA, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_SPELL_AREA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateSpellArea(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_AREA, payload);
        ipcRenderer.on(UPDATE_SPELL_AREA, () => {
          resolve();
        });
        ipcRenderer.on(`${UPDATE_SPELL_AREA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroySpellArea(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SPELL_AREA, payload);
        ipcRenderer.on(DESTROY_SPELL_AREA, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_SPELL_AREA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createSpellArea({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SPELL_AREA, payload);
        resolve();
      });
    },
    copySpellArea(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SPELL_AREA, payload);
        ipcRenderer.on(COPY_SPELL_AREA, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_SPELL_AREA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_AREAS](state, spellAreas) {
      state.spellAreas = spellAreas;
    },
    [FIND_SPELL_AREA](state, spellArea) {
      state.spellArea = spellArea;
    },
    [CREATE_SPELL_AREA](state, spellArea) {
      state.spellArea = spellArea;
    },
  },
};
