const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_EMOTE_TEXTS,
  COUNT_EMOTE_TEXTS,
  PAGINATE_EMOTE_TEXTS,
  STORE_EMOTE_TEXT,
  FIND_EMOTE_TEXT,
  UPDATE_EMOTE_TEXT,
  DESTROY_EMOTE_TEXT,
  CREATE_EMOTE_TEXT,
  COPY_EMOTE_TEXT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Name: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      emoteTexts: [],
      emoteText: {},
    };
  },
  actions: {
    searchEmoteTexts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_EMOTE_TEXTS, payload);
        ipcRenderer.on(SEARCH_EMOTE_TEXTS, (event, response) => {
          commit(SEARCH_EMOTE_TEXTS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_EMOTE_TEXTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countEmoteTexts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_EMOTE_TEXTS, payload);
        ipcRenderer.on(COUNT_EMOTE_TEXTS, (event, response) => {
          commit(COUNT_EMOTE_TEXTS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_EMOTE_TEXTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateEmoteTexts({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_EMOTE_TEXTS, payload.page);
        resolve();
      });
    },
    storeEmoteText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_EMOTE_TEXT, payload);
        ipcRenderer.on(STORE_EMOTE_TEXT, () => {
          commit("UPDATE_REFRESH_OF_EMOTE_TEXT", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_EMOTE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findEmoteText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_EMOTE_TEXT, payload);
        ipcRenderer.on(FIND_EMOTE_TEXT, (event, response) => {
          commit(FIND_EMOTE_TEXT, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_EMOTE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateEmoteText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_EMOTE_TEXT, payload);
        ipcRenderer.on(UPDATE_EMOTE_TEXT, () => {
          commit("UPDATE_REFRESH_OF_EMOTE_TEXT", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_EMOTE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyEmoteText(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_EMOTE_TEXT, payload);
        ipcRenderer.on(DESTROY_EMOTE_TEXT, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_EMOTE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createEmoteText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_EMOTE_TEXT, payload);
        ipcRenderer.on(CREATE_EMOTE_TEXT, (event, response) => {
          commit(CREATE_EMOTE_TEXT, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_EMOTE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyEmoteText(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_EMOTE_TEXT, payload);
        ipcRenderer.on(COPY_EMOTE_TEXT, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_EMOTE_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_EMOTE_TEXT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_EMOTE_TEXTS](state, emoteTexts) {
      state.emoteTexts = emoteTexts;
      state.refresh = false;
    },
    [COUNT_EMOTE_TEXTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_EMOTE_TEXTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_EMOTE_TEXT](state, emoteText) {
      state.emoteText = emoteText;
    },
    [UPDATE_EMOTE_TEXT](state, emoteText) {
      state.emoteText = emoteText;
    },
    [CREATE_EMOTE_TEXT](state, emoteText) {
      state.emoteText = emoteText;
    },
    UPDATE_REFRESH_OF_EMOTE_TEXT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_EMOTE_TEXT(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
