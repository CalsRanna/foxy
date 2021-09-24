const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CONDITIONS,
  COUNT_CONDITIONS,
  PAGINATE_CONDITIONS,
  STORE_CONDITION,
  FIND_CONDITION,
  UPDATE_CONDITION,
  DESTROY_CONDITION,
  CREATE_CONDITION,
  COPY_CONDITION,
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
      conditions: [],
      condition: {},
    };
  },
  actions: {
    searchConditions({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CONDITIONS, payload);
        ipcRenderer.on(SEARCH_CONDITIONS, (event, response) => {
          commit(SEARCH_CONDITIONS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_CONDITIONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countConditions({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_CONDITIONS, payload);
        ipcRenderer.on(COUNT_CONDITIONS, (event, response) => {
          commit(COUNT_CONDITIONS, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_CONDITIONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateConditions({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_CONDITIONS, payload.page);
        resolve();
      });
    },
    storeCondition({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CONDITION, payload);
        ipcRenderer.on(STORE_CONDITION, () => {
          commit("UPDATE_REFRESH_OF_CONDITION", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_CONDITION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findCondition({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CONDITION, payload);
        ipcRenderer.on(FIND_CONDITION, (event, response) => {
          commit(FIND_CONDITION, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_CONDITION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateCondition({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CONDITION, payload);
        ipcRenderer.on(UPDATE_CONDITION, () => {
          commit("UPDATE_REFRESH_OF_CONDITION", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_CONDITION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyCondition(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CONDITION, payload);
        ipcRenderer.on(DESTROY_CONDITION, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_CONDITION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createCondition({ commit }) {
      return new Promise((resolve) => {
        commit(CREATE_CONDITION, { Comment: "New - Condition" });
        resolve();
      });
    },
    copyCondition(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CONDITION, payload);
        ipcRenderer.on(COPY_CONDITION, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_CONDITION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_CONDITION");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_CONDITIONS](state, conditions) {
      state.conditions = conditions;
      state.refresh = false;
    },
    [COUNT_CONDITIONS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CONDITIONS](state, page) {
      state.pagination.page = page;
    },
    [FIND_CONDITION](state, condition) {
      state.condition = condition;
    },
    [UPDATE_CONDITION](state, condition) {
      state.condition = condition;
    },
    [CREATE_CONDITION](state, condition) {
      state.condition = condition;
    },
    UPDATE_REFRESH_OF_CONDITION(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_CONDITION(state) {
      state.credential = {
        ID: undefined,
        Text: undefined,
      };
    },
  },
};
