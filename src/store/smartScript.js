const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_SMART_SCRIPTS,
  COUNT_SMART_SCRIPTS,
  PAGINATE_SMART_SCRIPTS,
  STORE_SMART_SCRIPT,
  FIND_SMART_SCRIPT,
  UPDATE_SMART_SCRIPT,
  DESTROY_SMART_SCRIPT,
  CREATE_SMART_SCRIPT,
  COPY_SMART_SCRIPT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        entryorguid: undefined,
        comment: undefined,
      },
      pagination: {
        page: 1,
        size: 50,
        total: 0,
      },
      smartScripts: [],
      smartScript: {},
    };
  },
  actions: {
    searchSmartScripts({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_SMART_SCRIPTS, payload);
        ipcRenderer.on(SEARCH_SMART_SCRIPTS, (event, response) => {
          commit(SEARCH_SMART_SCRIPTS, response);
          resolve();
        });
      });
    },
    countSmartScripts({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COUNT_SMART_SCRIPTS, payload);
        ipcRenderer.on(COUNT_SMART_SCRIPTS, (event, response) => {
          commit(COUNT_SMART_SCRIPTS, response);
          resolve();
        });
      });
    },
    paginateSmartScripts({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SMART_SCRIPTS, payload.page);
        resolve();
      });
    },
    storeSmartScript({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_SMART_SCRIPT, payload);
        ipcRenderer.on(STORE_SMART_SCRIPT, () => {
          commit("UPDATE_REFRESH_OF_SMART_SCRIPT", true);
          resolve();
        });
      });
    },
    findSmartScript({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_SMART_SCRIPT, payload);
        ipcRenderer.on(FIND_SMART_SCRIPT, (event, response) => {
          commit(FIND_SMART_SCRIPT, response);
          resolve();
        });
      });
    },
    updateSmartScript({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_SMART_SCRIPT, payload);
        ipcRenderer.on(UPDATE_SMART_SCRIPT, () => {
          commit("UPDATE_REFRESH_OF_SMART_SCRIPT", true);
          resolve();
        });
      });
    },
    destroySmartScript(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_SMART_SCRIPT, payload);
        ipcRenderer.on(DESTROY_SMART_SCRIPT, () => {
          resolve();
        });
      });
    },
    createSmartScript({ commit }) {
      return new Promise((resolve) => {
        commit(CREATE_SMART_SCRIPT, { comment: "New - Smart Script" });
        resolve();
      });
    },
    copySmartScript(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_SMART_SCRIPT, payload);
        ipcRenderer.on(COPY_SMART_SCRIPT, () => {
          resolve();
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_SMART_SCRIPT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SMART_SCRIPTS](state, smartScripts) {
      state.smartScripts = smartScripts;
      state.refresh = false;
    },
    [COUNT_SMART_SCRIPTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SMART_SCRIPTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_SMART_SCRIPT](state, smartScript) {
      state.smartScript = smartScript;
    },
    [UPDATE_SMART_SCRIPT](state, smartScript) {
      state.smartScript = smartScript;
    },
    [CREATE_SMART_SCRIPT](state, smartScript) {
      state.smartScript = smartScript;
    },
    UPDATE_REFRESH_OF_SMART_SCRIPT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_SMART_SCRIPT(state) {
      state.credential = {
        entryorguid: undefined,
        comment: undefined,
      };
    },
  },
};
