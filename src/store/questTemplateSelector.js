const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_TEMPLATES_FOR_SELECTOR,
  COUNT_QUEST_TEMPLATES_FOR_SELECTOR,
  PAGINATE_QUEST_TEMPLATES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    questTemplates: [],
  }),
  actions: {
    searchQuestTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_TEMPLATES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_QUEST_TEMPLATES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_QUEST_TEMPLATES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_QUEST_TEMPLATES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countQuestTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_QUEST_TEMPLATES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_QUEST_TEMPLATES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_QUEST_TEMPLATES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_QUEST_TEMPLATES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateQuestTemplatesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_QUEST_TEMPLATES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_TEMPLATES_FOR_SELECTOR](state, questTemplates) {
      state.questTemplates = questTemplates;
    },
    [COUNT_QUEST_TEMPLATES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_QUEST_TEMPLATES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
