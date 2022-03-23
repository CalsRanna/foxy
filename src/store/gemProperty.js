const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GEM_PROPERTIES,
  COUNT_GEM_PROPERTIES,
  PAGINATE_GEM_PROPERTIES,
  STORE_GEM_PROPERTY,
  FIND_GEM_PROPERTY,
  UPDATE_GEM_PROPERTY,
  DESTROY_GEM_PROPERTY,
  CREATE_GEM_PROPERTY,
  COPY_GEM_PROPERTY,
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
      gemProperties: [],
      gemProperty: {},
    };
  },
  actions: {
    searchGemProperties({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GEM_PROPERTIES, payload);
        ipcRenderer.once(SEARCH_GEM_PROPERTIES, (event, response) => {
          commit(SEARCH_GEM_PROPERTIES, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_GEM_PROPERTIES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countGemProperties({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GEM_PROPERTIES, payload);
        ipcRenderer.once(COUNT_GEM_PROPERTIES, (event, response) => {
          commit(COUNT_GEM_PROPERTIES, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_GEM_PROPERTIES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateGemProperties({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GEM_PROPERTIES, payload.page);
        resolve();
      });
    },
    storeGemProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GEM_PROPERTY, payload);
        ipcRenderer.once(STORE_GEM_PROPERTY, () => {
          commit("UPDATE_REFRESH_OF_GEM_PROPERTY", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_GEM_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findGemProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GEM_PROPERTY, payload);
        ipcRenderer.once(FIND_GEM_PROPERTY, (event, response) => {
          commit(FIND_GEM_PROPERTY, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_GEM_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateGemProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GEM_PROPERTY, payload);
        ipcRenderer.once(UPDATE_GEM_PROPERTY, () => {
          commit("UPDATE_REFRESH_OF_GEM_PROPERTY", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_GEM_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyGemProperty(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GEM_PROPERTY, payload);
        ipcRenderer.once(DESTROY_GEM_PROPERTY, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_GEM_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createGemProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_GEM_PROPERTY, payload);
        ipcRenderer.once(CREATE_GEM_PROPERTY, (event, response) => {
          commit(CREATE_GEM_PROPERTY, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_GEM_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyGemProperty(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GEM_PROPERTY, payload);
        ipcRenderer.once(COPY_GEM_PROPERTY, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_GEM_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_GEM_PROPERTY");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GEM_PROPERTIES](state, gemProperties) {
      state.gemProperties = gemProperties;
      state.refresh = false;
    },
    [COUNT_GEM_PROPERTIES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GEM_PROPERTIES](state, page) {
      state.pagination.page = page;
    },
    [FIND_GEM_PROPERTY](state, gemProperty) {
      state.gemProperty = gemProperty;
    },
    [UPDATE_GEM_PROPERTY](state, gemProperty) {
      state.gemProperty = gemProperty;
    },
    [CREATE_GEM_PROPERTY](state, gemProperty) {
      state.gemProperty = gemProperty;
    },
    UPDATE_REFRESH_OF_GEM_PROPERTY(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_GEM_PROPERTY(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
