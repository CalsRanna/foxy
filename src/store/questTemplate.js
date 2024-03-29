const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_TEMPLATES,
  COUNT_QUEST_TEMPLATES,
  PAGINATE_QUEST_TEMPLATES,
  STORE_QUEST_TEMPLATE,
  FIND_QUEST_TEMPLATE,
  UPDATE_QUEST_TEMPLATE,
  DESTROY_QUEST_TEMPLATE,
  CREATE_QUEST_TEMPLATE,
  COPY_QUEST_TEMPLATE,
} from "./../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        LogTtitle: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      questTemplates: [],
      questTemplate: {},
    };
  },
  actions: {
    searchQuestTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_QUEST_TEMPLATES, (event, response) => {
          commit(SEARCH_QUEST_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_QUEST_TEMPLATES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countQuestTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_QUEST_TEMPLATES, payload);
        ipcRenderer.once(COUNT_QUEST_TEMPLATES, (event, response) => {
          commit(COUNT_QUEST_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_QUEST_TEMPLATES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateQuestTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_QUEST_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeQuestTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_TEMPLATE, payload);
        ipcRenderer.once(STORE_QUEST_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_QUEST_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_QUEST_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findQuestTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_TEMPLATE, payload);
        ipcRenderer.once(FIND_QUEST_TEMPLATE, (event, response) => {
          commit(FIND_QUEST_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_QUEST_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateQuestTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_QUEST_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_QUEST_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_QUEST_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyQuestTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_QUEST_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_QUEST_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_QUEST_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createQuestTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_QUEST_TEMPLATE, payload);
        ipcRenderer.once(CREATE_QUEST_TEMPLATE, (event, response) => {
          commit(CREATE_QUEST_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_QUEST_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyQuestTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_QUEST_TEMPLATE, payload);
        ipcRenderer.once(COPY_QUEST_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_QUEST_TEMPLATE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_QUEST_TEMPLATE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_TEMPLATES](state, questTemplates) {
      state.questTemplates = questTemplates;
      state.refresh = false;
    },
    [COUNT_QUEST_TEMPLATES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_QUEST_TEMPLATES](state, page) {
      state.pagination.page = page;
    },
    [FIND_QUEST_TEMPLATE](state, questTemplate) {
      state.questTemplate = questTemplate;
    },
    [CREATE_QUEST_TEMPLATE](state, questTemplate) {
      state.questTemplate = questTemplate;
    },
    UPDATE_REFRESH_OF_QUEST_TEMPLATE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_QUEST_TEMPLATE(state) {
      state.credential = {
        ID: undefined,
        LogTitle: undefined,
      };
    },
  },
};
