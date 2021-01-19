const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_TEMPLATES,
  COUNT_CREATURE_TEMPLATES,
  PAGINATE_CREATURE_TEMPLATES,
  STORE_CREATURE_TEMPLATE,
  FIND_CREATURE_TEMPLATE,
  UPDATE_CREATURE_TEMPLATE,
  DESTROY_CREATURE_TEMPLATE,
  CREATE_CREATURE_TEMPLATE,
  COPY_CREATURE_TEMPLATE
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    refresh: true,
    credential: {
      entry: undefined,
      name: undefined,
      subname: undefined
    },
    pagination: {
      page: 1,
      size: 50,
      total: 0
    },
    creatureTemplates: [],
    creatureTemplate: {}
  }),
  actions: {
    searchCreatureTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_TEMPLATES, response);
          resolve();
        });
      });
    },
    countCreatureTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_CREATURE_TEMPLATES, payload);
        ipcRenderer.on(COUNT_CREATURE_TEMPLATES, (event, response) => {
          commit(COUNT_CREATURE_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateCreatureTemplates({ commit }, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_CREATURE_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_CREATURE_TEMPLATE", true);
          resolve();
        });
      });
    },
    findCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(FIND_CREATURE_TEMPLATE, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_CREATURE_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_CREATURE_TEMPLATE", true);
          resolve();
        });
      });
    },
    destroyCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_CREATURE_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(CREATE_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(CREATE_CREATURE_TEMPLATE, (event, response) => {
          commit(CREATE_CREATURE_TEMPLATE, response);
          resolve();
        });
      });
    },
    copyCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(COPY_CREATURE_TEMPLATE, () => {
          resolve();
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise(resolve => {
        commit("RESET_CREDENTIAL_OF_CREATURE_TEMPLATE");
        resolve();
      });
    }
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATES](state, creatureTemplates) {
      state.creatureTemplates = creatureTemplates;
      state.refresh = false;
    },
    [COUNT_CREATURE_TEMPLATES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_CREATURE_TEMPLATES](state, page) {
      state.pagination.page = page;
    },
    [FIND_CREATURE_TEMPLATE](state, creatureTemplate) {
      state.creatureTemplate = creatureTemplate;
    },
    [CREATE_CREATURE_TEMPLATE](state, creatureTemplate) {
      state.creatureTemplate = creatureTemplate;
    },
    UPDATE_REFRESH_OF_CREATURE_TEMPLATE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_CREATURE_TEMPLATE(state) {
      state.credential = {
        entry: undefined,
        name: undefined,
        subname: undefined
      };
    }
  }
};
