const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_AREA_TABLES,
  COUNT_AREA_TABLES,
  PAGINATE_AREA_TABLES,
  STORE_AREA_TABLE,
  FIND_AREA_TABLE,
  UPDATE_AREA_TABLE,
  DESTROY_AREA_TABLE,
  CREATE_AREA_TABLE,
  COPY_AREA_TABLE,
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
      areaTables: [],
      areaTable: {},
    };
  },
  actions: {
    searchAreaTables({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_AREA_TABLES, payload);
        ipcRenderer.once(SEARCH_AREA_TABLES, (event, response) => {
          commit(SEARCH_AREA_TABLES, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_AREA_TABLES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countAreaTables({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_AREA_TABLES, payload);
        ipcRenderer.once(COUNT_AREA_TABLES, (event, response) => {
          commit(COUNT_AREA_TABLES, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_AREA_TABLES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateAreaTables({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_AREA_TABLES, payload.page);
        resolve();
      });
    },
    storeAreaTable({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_AREA_TABLE, payload);
        ipcRenderer.once(STORE_AREA_TABLE, () => {
          commit("UPDATE_REFRESH_OF_AREA_TABLE", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_AREA_TABLE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findAreaTable({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_AREA_TABLE, payload);
        ipcRenderer.once(FIND_AREA_TABLE, (event, response) => {
          commit(FIND_AREA_TABLE, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_AREA_TABLE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateAreaTable({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_AREA_TABLE, payload);
        ipcRenderer.once(UPDATE_AREA_TABLE, () => {
          commit("UPDATE_REFRESH_OF_AREA_TABLE", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_AREA_TABLE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyAreaTable(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_AREA_TABLE, payload);
        ipcRenderer.once(DESTROY_AREA_TABLE, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_AREA_TABLE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createAreaTable({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_AREA_TABLE, payload);
        ipcRenderer.once(CREATE_AREA_TABLE, (event, response) => {
          commit(CREATE_AREA_TABLE, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_AREA_TABLE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyAreaTable(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_AREA_TABLE, payload);
        ipcRenderer.once(COPY_AREA_TABLE, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_AREA_TABLE}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_AREA_TABLE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_AREA_TABLES](state, areaTables) {
      state.areaTables = areaTables;
      state.refresh = false;
    },
    [COUNT_AREA_TABLES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_AREA_TABLES](state, page) {
      state.pagination.page = page;
    },
    [FIND_AREA_TABLE](state, areaTable) {
      state.areaTable = areaTable;
    },
    [UPDATE_AREA_TABLE](state, areaTable) {
      state.areaTable = areaTable;
    },
    [CREATE_AREA_TABLE](state, areaTable) {
      state.areaTable = areaTable;
    },
    UPDATE_REFRESH_OF_AREA_TABLE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_AREA_TABLE(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
