const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_INFOS,
  COUNT_QUEST_INFOS,
  PAGINATE_QUEST_INFOS,
  STORE_QUEST_INFO,
  FIND_QUEST_INFO,
  UPDATE_QUEST_INFO,
  DESTROY_QUEST_INFO,
  CREATE_QUEST_INFO,
  COPY_QUEST_INFO,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        InfoName_Lang_zhCN: undefined,
      },
      pagination: {
        page: 1,
        size: 50,
        total: 0,
      },
      questInfos: [],
      questInfo: {},
    };
  },
  actions: {
    searchQuestInfos({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_INFOS, payload);
        ipcRenderer.on(SEARCH_QUEST_INFOS, (event, response) => {
          commit(SEARCH_QUEST_INFOS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_QUEST_INFOS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countQuestInfos({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_QUEST_INFOS, payload);
        ipcRenderer.on(COUNT_QUEST_INFOS, (event, response) => {
          commit(COUNT_QUEST_INFOS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_QUEST_INFOS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateQuestInfos({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_QUEST_INFOS, payload.page);
        resolve();
      });
    },
    storeQuestInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_INFO, payload);
        ipcRenderer.on(STORE_QUEST_INFO, () => {
          commit("UPDATE_REFRESH_OF_QUEST_INFO", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_QUEST_INFO}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findQuestInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_INFO, payload);
        ipcRenderer.on(FIND_QUEST_INFO, (event, response) => {
          commit(FIND_QUEST_INFO, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_QUEST_INFO}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateQuestInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_INFO, payload);
        ipcRenderer.on(UPDATE_QUEST_INFO, () => {
          commit("UPDATE_REFRESH_OF_QUEST_INFO", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_QUEST_INFO}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyQuestInfo(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_QUEST_INFO, payload);
        ipcRenderer.on(DESTROY_QUEST_INFO, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_QUEST_INFO}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createQuestInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_QUEST_INFO, payload);
        ipcRenderer.on(CREATE_QUEST_INFO, (event, response) => {
          commit(CREATE_QUEST_INFO, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_QUEST_INFO}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyQuestInfo(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_QUEST_INFO, payload);
        ipcRenderer.on(COPY_QUEST_INFO, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_QUEST_INFO}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_QUEST_INFO");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_INFOS](state, questInfos) {
      state.questInfos = questInfos;
      state.refresh = false;
    },
    [COUNT_QUEST_INFOS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_QUEST_INFOS](state, page) {
      state.pagination.page = page;
    },
    [FIND_QUEST_INFO](state, questInfo) {
      state.questInfo = questInfo;
    },
    [UPDATE_QUEST_INFO](state, questInfo) {
      state.questInfo = questInfo;
    },
    [CREATE_QUEST_INFO](state, questInfo) {
      state.questInfo = questInfo;
    },
    UPDATE_REFRESH_OF_QUEST_INFO(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_QUEST_INFO(state) {
      state.credential = {
        ID: undefined,
        InfoName_Lang_zhCN: undefined,
      };
    },
  },
};
