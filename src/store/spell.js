const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELLS, payload);
        ipcRenderer.once(SEARCH_SPELLS, (event, response) => {
          commit(SEARCH_SPELLS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_SPELLS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countSpells({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SPELLS, payload);
        ipcRenderer.once(COUNT_SPELLS, (event, response) => {
          commit(COUNT_SPELLS, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_SPELLS}_REJECT`, (event, error) => {
          reject(error);
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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL, payload);
        ipcRenderer.once(STORE_SPELL, () => {
          commit("UPDATE_REFRESH_OF_SPELL", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_SPELL}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findSpell({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL, payload);
        ipcRenderer.once(FIND_SPELL, (event, response) => {
          commit(FIND_SPELL, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_SPELL}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateSpell({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL, payload);
        ipcRenderer.once(UPDATE_SPELL, () => {
          commit("UPDATE_REFRESH_OF_SPELL", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_SPELL}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroySpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SPELL, payload);
        ipcRenderer.once(DESTROY_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_SPELL}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createSpell({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_SPELL, payload);
        ipcRenderer.once(CREATE_SPELL, (event, response) => {
          commit(CREATE_SPELL, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_SPELL}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copySpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SPELL, payload);
        ipcRenderer.once(COPY_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_SPELL}_REJECT`, (event, error) => {
          reject(error);
        });
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
