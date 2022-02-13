const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR,
  COUNT_GLYPH_PROPERTIES_FOR_SELECTOR,
  PAGINATE_GLYPH_PROPERTIES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    glyphProperties: [],
  }),
  actions: {
    searchGlyphPropertiesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR, payload);
        ipcRenderer.once(
          SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countGlyphPropertiesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GLYPH_PROPERTIES_FOR_SELECTOR, payload);
        ipcRenderer.once(
          COUNT_GLYPH_PROPERTIES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_GLYPH_PROPERTIES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${COUNT_GLYPH_PROPERTIES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateGlyphPropertiesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GLYPH_PROPERTIES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR](state, glyphProperties) {
      state.glyphProperties = glyphProperties;
    },
    [COUNT_GLYPH_PROPERTIES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GLYPH_PROPERTIES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
