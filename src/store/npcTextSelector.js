const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_NPC_TEXTS_FOR_SELECTOR,
  COUNT_NPC_TEXTS_FOR_SELECTOR,
  PAGINATE_NPC_TEXTS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      pagination: {
        page: 1,
        total: 0,
      },
      npcTexts: [],
    };
  },
  actions: {
    searchNpcTextsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_NPC_TEXTS_FOR_SELECTOR, payload);
        ipcRenderer.once(SEARCH_NPC_TEXTS_FOR_SELECTOR, (event, response) => {
          commit(SEARCH_NPC_TEXTS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_NPC_TEXTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countNpcTextsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_NPC_TEXTS_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_NPC_TEXTS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_NPC_TEXTS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_NPC_TEXTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateNpcTextsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_NPC_TEXTS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_NPC_TEXTS_FOR_SELECTOR](state, npcTexts) {
      state.npcTexts = npcTexts;
    },
    [COUNT_NPC_TEXTS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_NPC_TEXTS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
