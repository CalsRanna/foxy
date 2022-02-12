const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GLYPH_PROPERTIES,
  COUNT_GLYPH_PROPERTIES,
  PAGINATE_GLYPH_PROPERTIES,
  STORE_GLYPH_PROPERTY,
  FIND_GLYPH_PROPERTY,
  UPDATE_GLYPH_PROPERTY,
  DESTROY_GLYPH_PROPERTY,
  CREATE_GLYPH_PROPERTY,
  COPY_GLYPH_PROPERTY,
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
      glyphProperties: [],
      glyphProperty: {},
    };
  },
  actions: {
    searchGlyphProperties({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GLYPH_PROPERTIES, payload);
        ipcRenderer.on(SEARCH_GLYPH_PROPERTIES, (event, response) => {
          commit(SEARCH_GLYPH_PROPERTIES, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_GLYPH_PROPERTIES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countGlyphProperties({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GLYPH_PROPERTIES, payload);
        ipcRenderer.on(COUNT_GLYPH_PROPERTIES, (event, response) => {
          commit(COUNT_GLYPH_PROPERTIES, response);
          resolve();
        });
        ipcRenderer.on(`${COUNT_GLYPH_PROPERTIES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateGlyphProperties({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GLYPH_PROPERTIES, payload.page);
        resolve();
      });
    },
    storeGlyphProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GLYPH_PROPERTY, payload);
        ipcRenderer.on(STORE_GLYPH_PROPERTY, () => {
          commit("UPDATE_REFRESH_OF_GLYPH_PROPERTY", true);
          resolve();
        });
        ipcRenderer.on(`${STORE_GLYPH_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findGlyphProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GLYPH_PROPERTY, payload);
        ipcRenderer.on(FIND_GLYPH_PROPERTY, (event, response) => {
          commit(FIND_GLYPH_PROPERTY, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_GLYPH_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateGlyphProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GLYPH_PROPERTY, payload);
        ipcRenderer.on(UPDATE_GLYPH_PROPERTY, () => {
          commit("UPDATE_REFRESH_OF_GLYPH_PROPERTY", true);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_GLYPH_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyGlyphProperty(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GLYPH_PROPERTY, payload);
        ipcRenderer.on(DESTROY_GLYPH_PROPERTY, () => {
          resolve();
        });
        ipcRenderer.on(`${DESTROY_GLYPH_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createGlyphProperty({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_GLYPH_PROPERTY, payload);
        ipcRenderer.on(CREATE_GLYPH_PROPERTY, (event, response) => {
          commit(CREATE_GLYPH_PROPERTY, response);
          resolve();
        });
        ipcRenderer.on(`${CREATE_GLYPH_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyGlyphProperty(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GLYPH_PROPERTY, payload);
        ipcRenderer.on(COPY_GLYPH_PROPERTY, () => {
          resolve();
        });
        ipcRenderer.on(`${COPY_GLYPH_PROPERTY}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_GLYPH_PROPERTY");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GLYPH_PROPERTIES](state, glyphProperties) {
      state.glyphProperties = glyphProperties;
      state.refresh = false;
    },
    [COUNT_GLYPH_PROPERTIES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GLYPH_PROPERTIES](state, page) {
      state.pagination.page = page;
    },
    [FIND_GLYPH_PROPERTY](state, glyphProperty) {
      state.glyphProperty = glyphProperty;
    },
    [UPDATE_GLYPH_PROPERTY](state, glyphProperty) {
      state.glyphProperty = glyphProperty;
    },
    [CREATE_GLYPH_PROPERTY](state, glyphProperty) {
      state.glyphProperty = glyphProperty;
    },
    UPDATE_REFRESH_OF_GLYPH_PROPERTY(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_GLYPH_PROPERTY(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
