const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PAGE_TEXTS,
  COUNT_PAGE_TEXTS,
  PAGINATE_PAGE_TEXTS,
  STORE_PAGE_TEXT,
  FIND_PAGE_TEXT,
  UPDATE_PAGE_TEXT,
  DESTROY_PAGE_TEXT,
  CREATE_PAGE_TEXT,
  COPY_PAGE_TEXT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Text: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      pageTexts: [],
      pageText: {},
    };
  },
  actions: {
    searchPageTexts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PAGE_TEXTS, payload);
        ipcRenderer.on(SEARCH_PAGE_TEXTS, (event, response) => {
          commit(SEARCH_PAGE_TEXTS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_PAGE_TEXTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countPageTexts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_PAGE_TEXTS, payload);
        ipcRenderer.on(COUNT_PAGE_TEXTS, (event, response) => {
          commit(COUNT_PAGE_TEXTS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_PAGE_TEXTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginatePageTexts({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_PAGE_TEXTS, payload.page);
        resolve();
      });
    },
    storePageText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PAGE_TEXT, payload);
        ipcRenderer.on(STORE_PAGE_TEXT, () => {
          commit("UPDATE_REFRESH_OF_PAGE_TEXT", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_PAGE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findPageText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_PAGE_TEXT, payload);
        ipcRenderer.on(FIND_PAGE_TEXT, (event, response) => {
          commit(FIND_PAGE_TEXT, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_PAGE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updatePageText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_PAGE_TEXT, payload);
        ipcRenderer.on(UPDATE_PAGE_TEXT, () => {
          commit("UPDATE_REFRESH_OF_PAGE_TEXT", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_PAGE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyPageText(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_PAGE_TEXT, payload);
        ipcRenderer.on(DESTROY_PAGE_TEXT, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_PAGE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createPageText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_PAGE_TEXT, payload);
        ipcRenderer.on(CREATE_PAGE_TEXT, (event, response) => {
          commit(CREATE_PAGE_TEXT, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_PAGE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyPageText(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_PAGE_TEXT, payload);
        ipcRenderer.on(COPY_PAGE_TEXT, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_PAGE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_PAGE_TEXT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_PAGE_TEXTS](state, pageTexts) {
      state.pageTexts = pageTexts;
      state.refresh = false;
    },
    [COUNT_PAGE_TEXTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_PAGE_TEXTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_PAGE_TEXT](state, pageText) {
      state.pageText = pageText;
    },
    [UPDATE_PAGE_TEXT](state, pageText) {
      state.pageText = pageText;
    },
    [CREATE_PAGE_TEXT](state, pageText) {
      state.pageText = pageText;
    },
    UPDATE_REFRESH_OF_PAGE_TEXT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_PAGE_TEXT(state) {
      state.credential = {
        ID: undefined,
        Text: undefined,
      };
    },
  },
};
