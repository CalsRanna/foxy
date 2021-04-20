const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_TALENTS,
  COUNT_TALENTS,
  PAGINATE_TALENTS,
  STORE_TALENT,
  FIND_TALENT,
  UPDATE_TALENT,
  DESTROY_TALENT,
  CREATE_TALENT,
  COPY_TALENT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Spell: undefined,
      },
      pagination: {
        page: 1,
        size: 50,
        total: 0,
      },
      talents: [],
      talent: {},
    };
  },
  actions: {
    searchTalents({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_TALENTS, payload);
        ipcRenderer.on(SEARCH_TALENTS, (event, response) => {
          commit(SEARCH_TALENTS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_TALENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countTalents({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_TALENTS, payload);
        ipcRenderer.on(COUNT_TALENTS, (event, response) => {
          commit(COUNT_TALENTS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_TALENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateTalents({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_TALENTS, payload.page);
        resolve();
      });
    },
    storeTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_TALENT, payload);
        ipcRenderer.on(STORE_TALENT, () => {
          commit("UPDATE_REFRESH_OF_TALENT", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_TALENT, payload);
        ipcRenderer.on(FIND_TALENT, (event, response) => {
          commit(FIND_TALENT, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_TALENT, payload);
        ipcRenderer.on(UPDATE_TALENT, () => {
          commit("UPDATE_REFRESH_OF_TALENT", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyTalent(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_TALENT, payload);
        ipcRenderer.on(DESTROY_TALENT, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_TALENT, payload);
        ipcRenderer.on(CREATE_TALENT, (event, response) => {
          commit(CREATE_TALENT, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyTalent(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_TALENT, payload);
        ipcRenderer.on(COPY_TALENT, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_TALENT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_TALENTS](state, talents) {
      state.talents = talents;
      state.refresh = false;
    },
    [COUNT_TALENTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_TALENTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_TALENT](state, talent) {
      state.talent = talent;
    },
    [UPDATE_TALENT](state, talent) {
      state.talent = talent;
    },
    [CREATE_TALENT](state, talent) {
      state.talent = talent;
    },
    UPDATE_REFRESH_OF_TALENT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_TALENT(state) {
      state.credential = {
        ID: undefined,
        Spell: undefined,
      };
    },
  },
};
