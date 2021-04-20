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
        size: 50,
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
        ipcRenderer.on(SEARCH_TALENT_TABS, (event, response) => {
          commit(SEARCH_TALENT_TABS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_TALENT_TABS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countTalentTabs({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_TALENT_TABS, payload);
        ipcRenderer.on(COUNT_TALENT_TABS, (event, response) => {
          commit(COUNT_TALENT_TABS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_TALENT_TABS}_REJECT`, (event, error) => {
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
        ipcRenderer.on(STORE_TALENT_TAB, () => {
          commit("UPDATE_REFRESH_OF_TALENT_TAB", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_TALENT_TAB, payload);
        ipcRenderer.on(FIND_TALENT_TAB, (event, response) => {
          commit(FIND_TALENT_TAB, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_TALENT_TAB, payload);
        ipcRenderer.on(UPDATE_TALENT_TAB, () => {
          commit("UPDATE_REFRESH_OF_TALENT_TAB", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyTalentTab(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_TALENT_TAB, payload);
        ipcRenderer.on(DESTROY_TALENT_TAB, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createTalentTab({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_TALENT_TAB, payload);
        ipcRenderer.on(CREATE_TALENT_TAB, (event, response) => {
          commit(CREATE_TALENT_TAB, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_TALENT_TAB}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyTalentTab(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_TALENT_TAB, payload);
        ipcRenderer.on(COPY_TALENT_TAB, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_TALENT_TAB}_REJECT`, (event, error) => {
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
