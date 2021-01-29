const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_SPELLS,
  COUNT_SPELLS,
  PAGINATE_SPELLS,
  STORE_SPELL,
  FIND_SPELL,
  UPDATE_SPELL,
  DESTROY_SPELL,
  CREATE_SPELL,
  COPY_SPELL,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    refresh: true,
    credential: {
      ID: undefined,
      Name: undefined,
    },
    pagination: {
      page: 1,
      size: 50,
      total: 0,
    },
    spells: [],
    spell: {},
  }),
  actions: {
    searchSpells({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_SPELLS, payload);
        ipcRenderer.on(SEARCH_SPELLS, (event, response) => {
          commit(SEARCH_SPELLS, response);
          resolve();
        });
      });
    },
    countSpells({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COUNT_SPELLS, payload);
        ipcRenderer.on(COUNT_SPELLS, (event, response) => {
          commit(COUNT_SPELLS, response);
          resolve();
        });
      });
    },
    paginateSpells({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SPELLS, payload.page);
        resolve();
      });
    },
    storeSpell({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_SPELL, payload);
        ipcRenderer.on(STORE_SPELL, () => {
          commit("UPDATE_REFRESH_OF_SPELL", true);
          resolve();
        });
      });
    },
    findSpell({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_SPELL, payload);
        ipcRenderer.on(FIND_SPELL, (event, response) => {
          commit(FIND_SPELL, response);
          resolve();
        });
      });
    },
    updateSpell({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_SPELL, payload);
        ipcRenderer.on(UPDATE_SPELL, () => {
          commit("UPDATE_REFRESH_OF_SPELL", true);
          resolve();
        });
      });
    },
    destroySpell(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_SPELL, payload);
        ipcRenderer.on(DESTROY_SPELL, () => {
          resolve();
        });
      });
    },
    createSpell({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(CREATE_SPELL, payload);
        ipcRenderer.on(CREATE_SPELL, (event, response) => {
          commit(CREATE_SPELL, response);
          resolve();
        });
      });
    },
    copySpell(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_SPELL, payload);
        ipcRenderer.on(COPY_SPELL, () => {
          resolve();
        });
      });
    },
    updateFilter({ commit }, payload) {
      return new Promise((resolve) => {
        commit("UPDATE_FILTER_OF_SPELL", payload);
        resolve();
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_SPELL");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SPELLS](state, spells) {
      state.spells = spells;
      state.refresh = false;
    },
    [COUNT_SPELLS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SPELLS](state, page) {
      state.pagination.page = page;
    },
    [STORE_SPELL](state, spell) {
      state.spell = spell;
    },
    [FIND_SPELL](state, spell) {
      state.spell = spell;
    },
    [UPDATE_SPELL](state, spell) {
      state.spell = spell;
    },
    [CREATE_SPELL](state, spell) {
      state.spell = spell;
    },
    UPDATE_FILTER_OF_SPELL(state, filter) {
      state.filter = filter;
    },
    UPDATE_REFRESH_OF_SPELL(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_SPELL(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
