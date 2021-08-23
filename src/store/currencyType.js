const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CURRENCY_TYPES,
  COUNT_CURRENCY_TYPES,
  PAGINATE_CURRENCY_TYPES,
  STORE_CURRENCY_TYPE,
  FIND_CURRENCY_TYPE,
  UPDATE_CURRENCY_TYPE,
  DESTROY_CURRENCY_TYPE,
  CREATE_CURRENCY_TYPE,
  COPY_CURRENCY_TYPE,
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
      currencyTypes: [],
      currencyType: {},
    };
  },
  actions: {
    searchCurrencyTypes({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CURRENCY_TYPES, payload);
        ipcRenderer.on(SEARCH_CURRENCY_TYPES, (event, response) => {
          commit(SEARCH_CURRENCY_TYPES, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_CURRENCY_TYPES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countCurrencyTypes({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_CURRENCY_TYPES, payload);
        ipcRenderer.on(COUNT_CURRENCY_TYPES, (event, response) => {
          commit(COUNT_CURRENCY_TYPES, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_CURRENCY_TYPES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateCurrencyTypes({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_CURRENCY_TYPES, payload.page);
        resolve();
      });
    },
    storeCurrencyType({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CURRENCY_TYPE, payload);
        ipcRenderer.on(STORE_CURRENCY_TYPE, () => {
          commit("UPDATE_REFRESH_OF_CURRENCY_TYPE", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_CURRENCY_TYPE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findCurrencyType({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CURRENCY_TYPE, payload);
        ipcRenderer.on(FIND_CURRENCY_TYPE, (event, response) => {
          commit(FIND_CURRENCY_TYPE, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_CURRENCY_TYPE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateCurrencyType({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CURRENCY_TYPE, payload);
        ipcRenderer.on(UPDATE_CURRENCY_TYPE, () => {
          commit("UPDATE_REFRESH_OF_CURRENCY_TYPE", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_CURRENCY_TYPE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyCurrencyType(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CURRENCY_TYPE, payload);
        ipcRenderer.on(DESTROY_CURRENCY_TYPE, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_CURRENCY_TYPE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createCurrencyType({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_CURRENCY_TYPE, payload);
        ipcRenderer.on(CREATE_CURRENCY_TYPE, (event, response) => {
          commit(CREATE_CURRENCY_TYPE, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_CURRENCY_TYPE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyCurrencyType(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CURRENCY_TYPE, payload);
        ipcRenderer.on(COPY_CURRENCY_TYPE, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_CURRENCY_TYPE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_CURRENCY_TYPE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_CURRENCY_TYPES](state, currencyTypes) {
      state.currencyTypes = currencyTypes;
      state.refresh = false;
    },
    [COUNT_CURRENCY_TYPES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CURRENCY_TYPES](state, page) {
      state.pagination.page = page;
    },
    [FIND_CURRENCY_TYPE](state, currencyType) {
      state.currencyType = currencyType;
    },
    [UPDATE_CURRENCY_TYPE](state, currencyType) {
      state.currencyType = currencyType;
    },
    [CREATE_CURRENCY_TYPE](state, currencyType) {
      state.currencyType = currencyType;
    },
    UPDATE_REFRESH_OF_CURRENCY_TYPE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_CURRENCY_TYPE(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
