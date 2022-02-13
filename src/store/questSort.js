const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_SORTS,
  COUNT_QUEST_SORTS,
  PAGINATE_QUEST_SORTS,
  STORE_QUEST_SORT,
  FIND_QUEST_SORT,
  UPDATE_QUEST_SORT,
  DESTROY_QUEST_SORT,
  CREATE_QUEST_SORT,
  COPY_QUEST_SORT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        SortName_Lang_zhCN: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      questSorts: [],
      questSort: {},
    };
  },
  actions: {
    searchQuestSorts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_SORTS, payload);
        ipcRenderer.once(SEARCH_QUEST_SORTS, (event, response) => {
          commit(SEARCH_QUEST_SORTS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_QUEST_SORTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countQuestSorts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_QUEST_SORTS, payload);
        ipcRenderer.once(COUNT_QUEST_SORTS, (event, response) => {
          commit(COUNT_QUEST_SORTS, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_QUEST_SORTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateQuestSorts({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_QUEST_SORTS, payload.page);
        resolve();
      });
    },
    storeQuestSort({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_SORT, payload);
        ipcRenderer.once(STORE_QUEST_SORT, () => {
          commit("UPDATE_REFRESH_OF_QUEST_SORT", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_QUEST_SORT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findQuestSort({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_SORT, payload);
        ipcRenderer.once(FIND_QUEST_SORT, (event, response) => {
          commit(FIND_QUEST_SORT, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_QUEST_SORT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateQuestSort({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_SORT, payload);
        ipcRenderer.once(UPDATE_QUEST_SORT, () => {
          commit("UPDATE_REFRESH_OF_QUEST_SORT", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_QUEST_SORT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyQuestSort(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_QUEST_SORT, payload);
        ipcRenderer.once(DESTROY_QUEST_SORT, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_QUEST_SORT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createQuestSort({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_QUEST_SORT, payload);
        ipcRenderer.once(CREATE_QUEST_SORT, (event, response) => {
          commit(CREATE_QUEST_SORT, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_QUEST_SORT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyQuestSort(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_QUEST_SORT, payload);
        ipcRenderer.once(COPY_QUEST_SORT, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_QUEST_SORT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_QUEST_SORT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_SORTS](state, questSorts) {
      state.questSorts = questSorts;
      state.refresh = false;
    },
    [COUNT_QUEST_SORTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_QUEST_SORTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_QUEST_SORT](state, questSort) {
      state.questSort = questSort;
    },
    [UPDATE_QUEST_SORT](state, questSort) {
      state.questSort = questSort;
    },
    [CREATE_QUEST_SORT](state, questSort) {
      state.questSort = questSort;
    },
    UPDATE_REFRESH_OF_QUEST_SORT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_QUEST_SORT(state) {
      state.credential = {
        ID: undefined,
        SortName_Lang_zhCN: undefined,
      };
    },
  },
};
