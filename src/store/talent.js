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
        ipcRenderer.once(SEARCH_TALENTS, (event, response) => {
          commit(SEARCH_TALENTS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_TALENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countTalents({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_TALENTS, payload);
        ipcRenderer.once(COUNT_TALENTS, (event, response) => {
          commit(COUNT_TALENTS, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_TALENTS}_REJECT`, (event, error) => {
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
        ipcRenderer.once(STORE_TALENT, () => {
          commit("UPDATE_REFRESH_OF_TALENT", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_TALENT, payload);
        ipcRenderer.once(FIND_TALENT, (event, response) => {
          commit(FIND_TALENT, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_TALENT, payload);
        ipcRenderer.once(UPDATE_TALENT, () => {
          commit("UPDATE_REFRESH_OF_TALENT", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyTalent(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_TALENT, payload);
        ipcRenderer.once(DESTROY_TALENT, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createTalent({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_TALENT, payload);
        ipcRenderer.once(CREATE_TALENT, (event, response) => {
          commit(CREATE_TALENT, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_TALENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyTalent(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_TALENT, payload);
        ipcRenderer.once(COPY_TALENT, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_TALENT}_REJECT`, (event, error) => {
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
