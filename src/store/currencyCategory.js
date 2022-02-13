const ipcRenderer = window.ipcRenderer;

import {
  STORE_CURRENCY_CATEGORY,
  FIND_CURRENCY_CATEGORY,
  UPDATE_CURRENCY_CATEGORY,
  CREATE_CURRENCY_CATEGORY,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    currencyCategory: {},
  }),
  actions: {
    storeCurrencyCategory(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CURRENCY_CATEGORY, payload);
        ipcRenderer.once(STORE_CURRENCY_CATEGORY, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CURRENCY_CATEGORY}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCurrencyCategory({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CURRENCY_CATEGORY, payload);
        ipcRenderer.once(FIND_CURRENCY_CATEGORY, (event, response) => {
          commit(FIND_CURRENCY_CATEGORY, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_CURRENCY_CATEGORY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateCurrencyCategory(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CURRENCY_CATEGORY, payload);
        ipcRenderer.once(UPDATE_CURRENCY_CATEGORY, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_CURRENCY_CATEGORY}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCurrencyCategory({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CURRENCY_CATEGORY, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_CURRENCY_CATEGORY](state, currencyCategory) {
      state.currencyCategory = currencyCategory;
    },
    [CREATE_CURRENCY_CATEGORY](state, currencyCategory) {
      state.currencyCategory = currencyCategory;
    },
  },
};
