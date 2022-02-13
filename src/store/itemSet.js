const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ITEM_SETS,
  COUNT_ITEM_SETS,
  PAGINATE_ITEM_SETS,
  STORE_ITEM_SET,
  FIND_ITEM_SET,
  UPDATE_ITEM_SET,
  DESTROY_ITEM_SET,
  CREATE_ITEM_SET,
  COPY_ITEM_SET,
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
      itemSets: [],
      itemSet: {},
    };
  },
  actions: {
    searchItemSets({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_SETS, payload);
        ipcRenderer.once(SEARCH_ITEM_SETS, (event, response) => {
          commit(SEARCH_ITEM_SETS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_ITEM_SETS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countItemSets({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ITEM_SETS, payload);
        ipcRenderer.once(COUNT_ITEM_SETS, (event, response) => {
          commit(COUNT_ITEM_SETS, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_ITEM_SETS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateItemSets({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ITEM_SETS, payload.page);
        resolve();
      });
    },
    storeItemSet({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ITEM_SET, payload);
        ipcRenderer.once(STORE_ITEM_SET, () => {
          commit("UPDATE_REFRESH_OF_ITEM_SET", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_ITEM_SET}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findItemSet({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ITEM_SET, payload);
        ipcRenderer.once(FIND_ITEM_SET, (event, response) => {
          commit(FIND_ITEM_SET, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_ITEM_SET}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateItemSet({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ITEM_SET, payload);
        ipcRenderer.once(UPDATE_ITEM_SET, () => {
          commit("UPDATE_REFRESH_OF_ITEM_SET", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_ITEM_SET}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyItemSet(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ITEM_SET, payload);
        ipcRenderer.once(DESTROY_ITEM_SET, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_ITEM_SET}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createItemSet({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_ITEM_SET, payload);
        ipcRenderer.once(CREATE_ITEM_SET, (event, response) => {
          commit(CREATE_ITEM_SET, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_ITEM_SET}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyItemSet(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ITEM_SET, payload);
        ipcRenderer.once(COPY_ITEM_SET, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_ITEM_SET}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_ITEM_SET");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_SETS](state, itemSets) {
      state.itemSets = itemSets;
      state.refresh = false;
    },
    [COUNT_ITEM_SETS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ITEM_SETS](state, page) {
      state.pagination.page = page;
    },
    [FIND_ITEM_SET](state, itemSet) {
      state.itemSet = itemSet;
    },
    [UPDATE_ITEM_SET](state, itemSet) {
      state.itemSet = itemSet;
    },
    [CREATE_ITEM_SET](state, itemSet) {
      state.itemSet = itemSet;
    },
    UPDATE_REFRESH_OF_ITEM_SET(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_ITEM_SET(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
