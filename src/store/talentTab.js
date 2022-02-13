const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_TALENT_TABS,
  COUNT_TALENT_TABS,
  PAGINATE_TALENT_TABS,
  STORE_TALENT_TAB,
  FIND_TALENT_TAB,
  UPDATE_TALENT_TAB,
  DESTROY_TALENT_TAB,
  CREATE_TALENT_TAB,
  COPY_TALENT_TAB,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Name_Lang_zhCN: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      talentTabs: [],
      talentTab: {},
    };
  },
  actions: {
    searchTalentTabs({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_TALENT_TABS, payload);
        ipcRenderer.once(SEARCH_TALENT_TABS, (event, response) => {
          commit(SEARCH_TALENT_TABS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_TALENT_TABS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countTalentTabs({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_TALENT_TABS, payload);
        ipcRenderer.once(COUNT_TALENT_TABS, (event, response) => {
          commit(COUNT_TALENT_TABS, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_TALENT_TABS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateTalentTabs({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_TALENT_TABS, payload.page);
        resolve();
      });
    },
    storeTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_TALENT_TAB, payload);
        ipcRenderer.once(STORE_TALENT_TAB, () => {
          commit("UPDATE_REFRESH_OF_TALENT_TAB", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_TALENT_TAB, payload);
        ipcRenderer.once(FIND_TALENT_TAB, (event, response) => {
          commit(FIND_TALENT_TAB, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_TALENT_TAB, payload);
        ipcRenderer.once(UPDATE_TALENT_TAB, () => {
          commit("UPDATE_REFRESH_OF_TALENT_TAB", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyTalentTab(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_TALENT_TAB, payload);
        ipcRenderer.once(DESTROY_TALENT_TAB, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_TALENT_TAB, payload);
        ipcRenderer.once(CREATE_TALENT_TAB, (event, response) => {
          commit(CREATE_TALENT_TAB, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyTalentTab(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_TALENT_TAB, payload);
        ipcRenderer.once(COPY_TALENT_TAB, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_TALENT_TAB");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_TALENT_TABS](state, talentTabs) {
      state.talentTabs = talentTabs;
      state.refresh = false;
    },
    [COUNT_TALENT_TABS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_TALENT_TABS](state, page) {
      state.pagination.page = page;
    },
    [FIND_TALENT_TAB](state, talentTab) {
      state.talentTab = talentTab;
    },
    [UPDATE_TALENT_TAB](state, talentTab) {
      state.talentTab = talentTab;
    },
    [CREATE_TALENT_TAB](state, talentTab) {
      state.talentTab = talentTab;
    },
    UPDATE_REFRESH_OF_TALENT_TAB(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_TALENT_TAB(state) {
      state.credential = {
        ID: undefined,
        Name_Lang_zhCN: undefined,
      };
    },
  },
};
